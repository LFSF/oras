<?php
/**
 * This is the template that displays the feedback for a post
 * (comments, trackback, pingback...)
 *
 * You may want to call this file multiple time in a row with different $c $tb $pb params.
 * This allow to seprate different kinds of feedbacks instead of displaying them mixed together
 *
 * This file is not meant to be called directly.
 * It is meant to be called by an include in the main.page.php template.
 * To display a feedback, you should call a stub AND pass the right parameters
 * For example: /blogs/index.php?p=1&more=1&c=1&tb=1&pb=1
 * Note: don't code this URL by hand, use the template functions to generate it!
 *
 * b2evolution - {@link http://b2evolution.net/}
 * Released under GNU GPL License - {@link http://b2evolution.net/about/license.html}
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 *
 * @package evoskins
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

?>
<!-- ===================== START OF FEEDBACK ===================== -->
<?php

// Default params:
$params = array_merge( array(
		'disp_comments'        =>	true,
		'disp_comment_form'	   =>	true,
		'disp_trackbacks'	     =>	true,
		'disp_trackback_url'   =>	true,
		'disp_pingbacks'	     =>	true,
		'before_section_title' => '<h3>',
		'after_section_title'  => '</h3>',
    'comment_list_start'   => "\n\n",
    'comment_list_end'     => "\n\n",
    'comment_start'        => '<div class="bComment">',
    'comment_end'          => '</div>',
    'preview_start'        => '<div class="bComment" id="comment_preview">',
    'preview_end'          => '</div>',
    'comment_template'     => '_item_comment.inc.php',	// The template used for displaying individual comments (including preview)
		'form_title_start'     => '<h3>',
		'form_title_end'       => '</h3>',
	), $params );


global $c, $tb, $pb;


if( ! $Item->can_see_comments() )
{	// Comments are disabled for this post
	return;
}

if( empty($c) )
{	// Comments not requested
	$params['disp_comments'] = false;					// DO NOT Display the comments if not requested
	$params['disp_comment_form'] = false;			// DO NOT Display the comments form if not requested
}

if( empty($tb) || !$Blog->get( 'allowtrackbacks' ) )
{	// Trackback not requested or not allowed
	$params['disp_trackbacks'] = false;				// DO NOT Display the trackbacks if not requested
	$params['disp_trackback_url'] = false;		// DO NOT Display the trackback URL if not requested
}

if( empty($pb) )
{	// Pingback not requested
	$params['disp_pingbacks'] = false;				// DO NOT Display the pingbacks if not requested
}

if( ! ($params['disp_comments'] || $params['disp_comment_form'] || $params['disp_trackbacks'] || $params['disp_trackback_url'] || $params['disp_pingbacks'] ) )
{	// Nothing more to do....
	return false;
}

echo '<a id="feedbacks"></a>';

$type_list = array();
$disp_title = array();

if( $params['disp_comments'] )
{	// We requested to display comments
	if( $Item->can_see_comments() )
	{ // User can see a comments
		$type_list[] = "'comment'";
		if( $title = $Item->get_feedback_title( 'comments' ) )
		{
			$disp_title[] = $title;
		}
	}
	else
	{ // Use cannot see comments
		$params['disp_comments'] = false;
	}
	echo '<a id="comments"></a>';
}

if( $params['disp_trackbacks'] )
{
	$type_list[] = "'trackback'";
	if( $title = $Item->get_feedback_title( 'trackbacks' ) )
	{
		$disp_title[] = $title;
	}
	echo '<a id="trackbacks"></a>';
}

if( $params['disp_pingbacks'] )
{
	$type_list[] = "'pingback'";
	if( $title = $Item->get_feedback_title( 'pingbacks' ) )
	{
		$disp_title[] = $title;
	}
	echo '<a id="pingbacks"></a>';
}

if( $params['disp_trackback_url'] )
{ // We want to display the trackback URL:

	echo $params['before_section_title'];
	echo T_('Trackback address for this post');
	echo $params['after_section_title'];

	/*
	 * Trigger plugin event, which could display a captcha form, before generating a whitelisted URL:
	 */
	if( ! $Plugins->trigger_event_first_true( 'DisplayTrackbackAddr', array('Item' => & $Item, 'template' => '<code>%url%</code>') ) )
	{ // No plugin displayed a payload, so we just display the default:
		echo '<p class="trackback_url"><a href="'.$Item->get_trackback_url().'">'.T_('Trackback URL (right click and copy shortcut/link location)').'</a></p>';
	}
}


if( $params['disp_comments'] || $params['disp_trackbacks'] || $params['disp_pingbacks']  )
{
	if( empty($disp_title) )
	{	// No title yet
		if( $title = $Item->get_feedback_title( 'feedbacks', '', T_('Feedback awaiting moderation'), T_('Feedback awaiting moderation'), 'draft' ) )
		{ // We have some feedback awaiting moderation: we'll want to show that in the title
			$disp_title[] = $title;
		}
	}

	if( empty($disp_title) )
	{	// Still no title
		$disp_title[] = T_('No feedback yet');
	}

	echo $params['before_section_title'];
	echo implode( ', ', $disp_title);
	echo $params['after_section_title'];

	$CommentList = & new CommentList( NULL, implode(',', $type_list), array('published'), $Item->ID, '', 'ASC' );

	echo $params['comment_list_start'];
	/**
	 * @var Comment
	 */
	while( $Comment = & $CommentList->get_next() )
	{	// Loop through comments:

		// ------------------ COMMENT INCLUDED HERE ------------------
		skin_include( $params['comment_template'], array(
				'Comment'              => & $Comment,
			  'comment_start'        => $params['comment_start'],
			  'comment_end'          => $params['comment_end'],
			) );
		// Note: You can customize the default item feedback by copying the generic
		// /skins/_item_comment.inc.php file into the current skin folder.
		// ---------------------- END OF COMMENT ---------------------

	}	// End of comment list loop.
	echo $params['comment_list_end'];


	// _______________________________________________________________

	// Display count of comments to be moderated:
	$Item->feedback_moderation( 'feedbacks', '<div class="moderation_msg"><p>', '</p></div>', '',
			T_('This post has 1 feedback awaiting moderation... %s'),
			T_('This post has %d feedbacks awaiting moderation... %s') );

	// _______________________________________________________________

	// Display link for comments feed:
	$Item->feedback_feed_link( '_rss2', '<div class="feedback_feed_msg"><p>', '</p></div>' );

	// _______________________________________________________________

}



// ------------------ COMMENT FORM INCLUDED HERE ------------------
skin_include( '_item_comment_form.inc.php', $params );
// Note: You can customize the default item feedback by copying the generic
// /skins/_item_comment_form.inc.php file into the current skin folder.
// ---------------------- END OF COMMENT FORM ---------------------



?>
