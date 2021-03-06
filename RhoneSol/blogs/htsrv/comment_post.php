<?php
/**
 * This file posts a comment!
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
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
 * }}
 *
 * @package htsrv
 */


/**
 * Initialize everything:
 */
require_once dirname(__FILE__).'/../conf/_config.php';

require_once $inc_path.'_main.inc.php';

header( 'Content-Type: text/html; charset='.$io_charset );


// Getting GET or POST parameters:
param( 'comment_post_ID', 'integer', true ); // required
param( 'redirect_to', 'string', '' );


$action = param_arrayindex( 'submit_comment_post_'.$comment_post_ID, 'save' );


$ItemCache = & get_Cache( 'ItemCache' );
$commented_Item = & $ItemCache->get_by_ID( $comment_post_ID );

if( ! $commented_Item->can_comment( NULL ) )
{
	$Messages->add( T_('You cannot leave comments on this post!'), 'error' );
}

// Note: we use funky field names to defeat the most basic guestbook spam bots and/or their most basic authors
$comment = param( 'p', 'html' );

param( 'comment_autobr', 'integer', ($comments_use_autobr == 'always') ? 1 : 0 );

if( is_logged_in() )
{
  /**
	 * @var User
	 */
	$User = & $current_User;
	$author = null;
	$email = null;
	$url = null;
	$comment_cookies = null;
	$comment_allow_msgform = null;
}
else
{	// User is not logged in (registered users), we need some id info from him:
	$User = NULL;
	// Note: we use funky field names to defeat the most basic guestbook spam bots and/or their most basic authors
	$author = param( 'u', 'string' );
	$email = param( 'i', 'string' );
	$url = param( 'o', 'string' );
	param( 'comment_cookies', 'integer', 0 );
	param( 'comment_allow_msgform', 'integer', 0 ); // checkbox
}

param( 'comment_rating', 'integer', NULL );

$now = date( 'Y-m-d H:i:s', $localtimenow );


// VALIDATION:

$original_comment = $comment;

// Trigger event: a Plugin could add a $category="error" message here..
// This must get triggered before any internal validation and must pass all relevant params.
// openID plugin will validate a given OpenID here
$Plugins->trigger_event( 'CommentFormSent', array(
		'comment_post_ID' => $comment_post_ID,
		'comment' => & $comment,
		'original_comment' => & $original_comment,
		'comment_autobr' => & $comment_autobr,
		'action' => & $action,
		'anon_name' => & $author,
		'anon_email' => & $email,
		'anon_url' => & $url,
		'rating' => & $comment_rating,
		'anon_allow_msgform' => & $comment_allow_msgform,
		'anon_cookies' => & $comment_cookies,
		'User' => & $User,
		'redirect_to' => & $redirect_to,
	) );


// CHECK and FORMAT content
// TODO: AutoBR should really be a "comment renderer" (like with Items)
$comment = format_to_post( $comment, $comment_autobr, 1 ); // includes antispam


if( ! $User )
{	// User is still not logged in, we need some id info from him:
	if ($require_name_email)
	{ // We want Name and EMail with comments
		if( empty($author) )
		{
			$Messages->add( T_('Please fill in your name.'), 'error' );
		}
		if( empty($email) )
		{
			$Messages->add( T_('Please fill in your email.'), 'error' );
		}
	}

	if( !empty($author) && antispam_check( $author ) )
	{
		$Messages->add( T_('Supplied name is invalid.'), 'error' );
	}

	if( !empty($email)
		&& ( !is_email($email)|| antispam_check( $email ) ) )
	{
		$Messages->add( T_('Supplied email address is invalid.'), 'error' );
	}


	if( !stristr($url, '://') && !stristr($url, '@') )
	{ // add 'http://' if no protocol defined for URL; but not if the user seems to be entering an email address alone
		$url = 'http://'.$url;
	}

	if( strlen($url) <= 8 )
	{	// ex: https:// is 8 chars
		$url = '';
	}

	// Note: as part of the validation we require the url to be absolute; otherwise we cannot detect bozos typing in
	// a title for their comment or whatever...
	if( $error = validate_url( $url, 'commenting' ) )
	{
		$Messages->add( T_('Supplied website address is invalid: ').$error, 'error' );
	}
}

if( empty($comment) )
{ // comment should not be empty!
	$Messages->add( T_('Please do not send empty comments.'), 'error' );
}

// Flood protection was here and SHOULD NOT have moved down!

/**
 * Create comment object. Gets validated, before recording it into DB:
 */
$Comment = & new Comment();
$Comment->set( 'type', 'comment' );
$Comment->set_Item( $commented_Item );
if( $User )
{ // User is logged in, we'll use his ID
	$Comment->set_author_User( $User );
}
else
{	// User is not logged in:
	$Comment->set( 'author', $author );
	$Comment->set( 'author_email', $email );
	$Comment->set( 'author_url', $url );
	$Comment->set( 'allow_msgform', $comment_allow_msgform );
}

if( $commented_Item->can_rate() )
{	// Comment rating:
	$Comment->set( 'rating', $comment_rating );
}
$Comment->set( 'author_IP', $Hit->IP );
$Comment->set( 'date', $now );
$Comment->set( 'content', $comment );

$commented_Item->get_Blog(); // Make sure Blog is loaded

if( !empty($User) && $User->check_perm( 'blog_comments', 'edit', false ) )
{	// User has perm to moderate comments, publish automatically:
	$Comment->set( 'status', 'published' );
}
else
{ // Assign default status for new comments:
	$Comment->set( 'status', $commented_Item->Blog->get_setting('new_feedback_status') );
}

if( $action != 'preview' )
{
	/*
	 * Flood-protection
	 * NOTE: devs can override the flood protection delay in /conf/_overrides_TEST.php
	 * TODO: Put time check into query?
	 * TODO: move that as far !!UP!! as possible! We want to waste minimum resources on Floods
	 * TODO: have several thresholds. For example:
	 * 1 comment max every 30 sec + 5 comments max every 10 minutes + 15 comments max every 24 hours
	 * TODO: factorize with trackback
	 */
	$query = 'SELECT MAX(comment_date)
							FROM T_comments
						 WHERE comment_author_IP = '.$DB->quote($Hit->IP).'
								OR comment_author_email = '.$DB->quote($Comment->get_author_email());
	$ok = 1;
	if( $then = $DB->get_var( $query ) )
	{
		$time_lastcomment = mysql2date("U",$then);
		$time_newcomment = mysql2date("U",$now);
		if( ($time_newcomment - $time_lastcomment) < $minimum_comment_interval )
			$ok = 0;
	}
	if( !$ok )
	{
		$Messages->add( sprintf( T_('You can only post a new comment every %d seconds.'), $minimum_comment_interval ), 'error' );
	}
	/* end flood-protection */
}


// Trigger event: a Plugin could add a $category="error" message here..
$Plugins->trigger_event('BeforeCommentFormInsert', array(
	'Comment' => & $Comment,
	'original_comment' => $original_comment,
	'is_preview' => ($action == 'preview'),
	'action' => & $action ) );


/*
 * Display error messages:
 */
if( $Messages->count('error') )
{
	if( ! isset($page_title) )
	{
		$page_title = T_('Errors while processing your comment');
	}
	// TODO: dh> HEAD part should be some global front end include file..
	// fp> actually, I'd like the error messages to de displayed in a skinnable file. Something that looks like the _main skin file but with minimum extra gadgets (in order to save on DB requests at each "spam denied" error)
	// fp> So please don't waste time on implementing a half baked solution.
	// fp> We may want to rethink skins more deeply beofre implementing this.
	?>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php locale_lang() ?>" lang="<?php locale_lang() ?>">
	<head>
		<title><?php echo $app_shortname.' &rsaquo; '.$page_title ?></title>
		<meta name="ROBOTS" content="NOINDEX" />
		<meta http-equiv="Content-Type" content="text/html; charset=<?php echo $io_charset ?>" />
	</head>
	<body>
	<?php
	$Messages->display( T_('Cannot post comment, please correct these errors:'),
	'[<a href="javascript:history.go(-1)">'.T_('Back to comment editing').'</a>]' );

	debug_info();  // output debug info, useful to see what a plugin might have done
	?>
	</body>
	</html>
	<?php
	exit();
}

if( $action == 'preview' )
{ // set the Comment into user's session and redirect.
	$Comment->set( 'original_content', $original_comment ); // used in the textarea input field again
	$Session->set( 'core.preview_Comment', $Comment );
	$Session->set( 'core.no_CachePageContent', 1 );
	$Session->dbsave();

	$redirect_to .= '#comment_preview';

	header_nocache();
	header_redirect();
	exit();
}
else
{ // delete any preview comment from session data:
	$Session->delete( 'core.preview_Comment' );
}


// RECORD comment:

$Comment->dbinsert();


/*
 * ---------------
 * Handle cookies:
 * ---------------
 */
if( !is_logged_in() )
{
	if( $comment_cookies )
	{	// Set cookies:
		if ($email == '')
			$email = ' '; // this to make sure a cookie is set for 'no email'
		if ($url == '')
			$url = ' '; // this to make sure a cookie is set for 'no url'

		// fplanque: made cookies available for whole site
		setcookie( $cookie_name, $author, $cookie_expires, $cookie_path, $cookie_domain);
		setcookie( $cookie_email, $email, $cookie_expires, $cookie_path, $cookie_domain);
		setcookie( $cookie_url, $url, $cookie_expires, $cookie_path, $cookie_domain);
	}
	else
	{	// Erase cookies:
		if( !empty($_COOKIE[$cookie_name]) )
		{
			setcookie( $cookie_name, '', $cookie_expired, $cookie_path, $cookie_domain);
		}
		if( !empty($_COOKIE['comment_author_email']) )
		{
			setcookie( $cookie_email, '', $cookie_expired, $cookie_path, $cookie_domain);
		}
		if( !empty($_COOKIE['comment_author_url']) )
		{
			setcookie( $cookie_url, '', $cookie_expired, $cookie_path, $cookie_domain);
		}
	}
}

// Note: we don't give any clue that we have automatically deleted a comment. Il would only give spammers the perfect tool to find out how to pass the filter.

if( $Comment->ID )
{ // comment has not been deleted
	// Trigger event: a Plugin should cleanup any temporary data here..
	$Plugins->trigger_event( 'AfterCommentFormInsert', array( 'Comment' => & $Comment, 'original_comment' => $original_comment ) );

	/*
	 * --------------------------
	 * New comment notifications:
	 * --------------------------
	 */
	// TODO: dh> this should only send published feedback probably and should also use "outbound_notifications_mode"
	// fp> yes for general users, but comment moderators need to receive notifications for new unpublished comments
	$Comment->send_email_notifications();


	// Add a message, according to the comment's status:
	if( $Comment->status == 'published' )
	{
		$Messages->add( T_('Your comment has been submitted.'), 'success' );

		// Append anchor to the redirect_to param, so the user sees his comment:
		$redirect_to .= '#'.$Comment->get_anchor();
	}
	else
	{
		$Messages->add( T_('Your comment has been submitted. It will appear once it has been approved.'), 'success' );
	}
}


header_nocache();
header_redirect(); // Will save $Messages into Session



?>