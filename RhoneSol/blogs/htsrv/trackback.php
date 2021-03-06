<?php
/**
 * This file handles trackback requests
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 * Parts of this file are copyright (c)2004-2006 by Daniel HAHLER - {@link http://thequod.de/contact}.
 *
 * {@internal License choice
 * - If you have received this file as part of a package, please find the license.txt file in
 *   the same folder or the closest folder above for complete license terms.
 * - If you have received this file individually (e-g: from http://evocms.cvs.sourceforge.net/)
 *   then you must choose one of the following licenses before using the file:
 *   - GNU General Public License 2 (GPL) - http://www.opensource.org/licenses/gpl-license.php
 *   - Mozilla Public License 1.1 (MPL) - http://www.opensource.org/licenses/mozilla1.1.php
 * }}
 *
 * {@internal Open Source relicensing agreement:
 * Daniel HAHLER grants Francois PLANQUE the right to license
 * Daniel HAHLER's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package htsrv
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: trackback.php,v 1.63 2008/01/21 09:35:23 fplanque Exp $
 */


/**
 * Initialize everything:
 */
require_once dirname(__FILE__).'/../conf/_config.php';

require_once $inc_path.'_main.inc.php';

/**
 * Send a trackback response and exits.
 *
 * @param integer Error code
 * @param string Error message
 */
function trackback_response( $error = 0, $error_message = '' )
{ // trackback - reply
	global $io_charset;

	echo '<?xml version="1.0" encoding="'.$io_charset.'"?'.">\n";
	echo "<response>\n";
	echo "<error>$error</error>\n";
	echo "<message>$error_message</message>\n";
	echo "</response>";
	exit();
}

// statuses allowed for acting on:
$show_statuses = array( 'published', 'protected', 'private' );

param( 'tb_id', 'integer' );
param( 'url', 'string' );
param( 'title', 'string' );
param( 'excerpt', 'html' );
param( 'blog_name', 'string' );


if( empty($tb_id) )
{ // No parameter for ID, get if from URL:
	$path_elements = explode( '/', $ReqPath, 30 );
	$tb_id = intval( $path_elements[count($path_elements)-1] );
}


if( ! empty($_GET['__mode']) )
{ // some MT extension (AFAIK), that we do not support
	return;
}

if( empty($tb_id) )
{
	trackback_response( 1, 'No trackback post ID given.' ); // exits
}
if( empty($url) )
{
	trackback_response( 1, 'No url to your permanent entry given.' ); // exits
}

@header('Content-Type: text/xml');

$comment_post_ID = $tb_id;
$ItemCache = & get_Cache( 'ItemCache' );
$commented_Item = & $ItemCache->get_by_ID( $comment_post_ID );
if( !( $Blog = & $commented_Item->get_Blog() ) )
{
	trackback_response( 1, 'Sorry, could not get the post\'s weblog.' ); // exits
}

if( ! $Blog->get('allowtrackbacks') )
{
	trackback_response( 1, 'Sorry, this weblog does not allow you to trackback its posts.' ); // exits
}

// Commented out again, because it's comment specific: if( ! $commented_Item->can_comment( NULL ) )
// "BeforeTrackbackInsert" should be hooked instead!
if( $commented_Item->comment_status != 'open' )
{
	trackback_response( 1, 'Sorry, this item does not accept trackbacks.' ); // exits
}


// CHECK content
if( $error = validate_url( $url, 'commenting' ) )
{
	$Messages->add( T_('Supplied URL is invalid: ').$error, 'error' );
}

if( $Messages->count('error') )
{
	trackback_response( 1, $Messages->get_string( '', '', 'all', "\n" ) ); // exits
}


$title = strip_tags($title);
$title = (strlen($title) > 255) ? substr($title, 0, 252).'...' : $title;
$excerpt = strip_tags($excerpt);
$excerpt = (strlen($excerpt) > 255) ? substr($excerpt, 0, 252).'...' : $excerpt;
$blog_name = htmlspecialchars($blog_name);
$blog_name = (strlen($blog_name) > 255) ? substr($blog_name, 0, 252).'...' : $blog_name;

$comment = '';
if( ! empty($title) )
{
	$comment .= '<strong>'.$title.'</strong>';

	if( ! empty($excerpt) )
	{
		$comment .= '<br />';
	}
}
$comment .= $excerpt;

$comment = format_to_post( $comment, 1, 1 ); // includes antispam
if( empty($comment) )
{ // comment should not be empty!
	$Messages->add( T_('Please do not send empty comment'), 'error' );
}


/**
 * @global Comment Trackback object
 */
$Comment = & new Comment();
$Comment->set( 'type', 'trackback' );
$Comment->set_Item( $commented_Item );
$Comment->set( 'author', $blog_name );
$Comment->set( 'author_url', $url );
$Comment->set( 'author_IP', $Hit->IP );
$Comment->set( 'date', date('Y-m-d H:i:s', $localtimenow ) );
$Comment->set( 'content', $comment );
// Assign default status for new comments:
$Comment->set( 'status', $commented_Item->Blog->get_setting('new_feedback_status') );


// Trigger event, which may add a message of category "error":
$Plugins->trigger_event( 'BeforeTrackbackInsert', array( 'Comment' => & $Comment ) );


// Display errors:
if( $errstring = $Messages->get_string( 'Cannot insert trackback, please correct these errors:', '' ) )
{
	trackback_response(2, $errstring);	// TODO: check TRACKBACK SPEC that error code 2 is ok
}


// Record trackback into DB:
$Comment->dbinsert();


if( $Comment->ID == 0 )
{
	// Exit silently! Wz don't want to give an easy tool to try and pass the filters.
	trackback_response( 0, 'ok' );
}


/*
 * ----------------------------
 * New trackback notification:
 * ----------------------------
 */
// TODO: dh> this should only send published feedback probably and should also use "outbound_notifications_mode"
$Comment->send_email_notifications();


// Trigger event: a Plugin should cleanup any temporary data here..
// fp>> WARNING: won't be called if trackback gets deleted by antispam
$Plugins->trigger_event( 'AfterTrackbackInsert', array( 'Comment' => & $Comment ) );


// fp>TODO: warn about moderation
trackback_response( 0, 'ok' );



?>