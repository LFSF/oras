<?php
/**
 * This file implements the post browsing
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2005 by Daniel HAHLER - {@link http://thequod.de/contact}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _item_list_full.view.php,v 1.13 2008/01/23 17:55:01 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Blog
 */
global $Blog;
/**
 * @var ItemList2
 */
global $ItemList;
/**
 * Note: definition only (does not need to be a global)
 * @var Item
 */
global $Item;

global $action, $dispatcher, $blog, $posts, $poststart, $postend, $ReqURI;
global $edit_item_url, $delete_item_url, $htsrv_url, $p;
global $comment_allowed_tags, $comments_use_autobr;

if( $highlight = param( 'highlight', 'integer', NULL ) )
{	// There are lines we want to highlight:
	global $rsc_url;
	echo '<script type="text/javascript" src="'.$rsc_url.'js/fadeout.js"></script>';
	echo '<script type="text/javascript">addEvent( window, "load", Fat.fade_all, false);</script>';
}


// Run the query:
$ItemList->query();

// Old style globals for category.funcs:
global $postIDlist;
$postIDlist = $ItemList->get_page_ID_list();
global $postIDarray;
$postIDarray = $ItemList->get_page_ID_array();



$block_item_Widget = & new Widget( 'block_item' );

if( $action == 'view' )
{	// We are displaying a single post:
	$block_item_Widget->title = $ItemList->get_filter_title( '', '', ' - ', NULL, 'htmlbody' );
	$block_item_Widget->global_icon( T_('Close post'), 'close',
				regenerate_url( 'p,action', 'filter=restore&amp;highlight='.$p ), T_('close'), 4, 1 );
}
else
{	// We are displaying multiple posts
	$block_item_Widget->title = T_('Full posts');
	if( $ItemList->is_filtered() )
	{	// List is filtered, offer option to reset filters:
		$block_item_Widget->global_icon( T_('Reset all filters!'), 'reset_filters', '?ctrl=items&amp;blog='.$Blog->ID.'&amp;filter=reset', T_('Reset filters') );
	}
	$block_item_Widget->global_icon( T_('Write a new post...'), 'new', '?ctrl=items&amp;action=new&amp;blog='.$blog, T_('New post').' &raquo;', 3, 4 );
}

$block_item_Widget->disp_template_replaced( 'block_start' );



if( $action == 'view' )
{
	// Initialize things in order to be ready for displaying.
	$display_params = array(
					'header_start' => '',
						'header_text_single' => '',
					'header_end' => '',
					'footer_start' => '',
						'footer_text_single' => '',
					'footer_end' => ''
				);
}
else
{ // Not a single post!
	// Display title depending on selection params:
	echo $ItemList->get_filter_title( '<h3>', '</h3>', '<br />', NULL, 'htmlbody' );

	// Initialize things in order to be ready for displaying.
	$display_params = array(
					'header_start' => '<div class="NavBar center">',
						'header_text' => '<strong>'.T_('Pages').'</strong>: $prev$ $first$ $list_prev$ $list$ $list_next$ $last$ $next$',
						'header_text_single' => T_('1 page'),
					'header_end' => '</div>',
					'footer_start' => '',
						'footer_text' => '<div class="NavBar center"><strong>'.T_('Pages').'</strong>: $prev$ $first$ $list_prev$ $list$ $list_next$ $last$ $next$</div>',
						'footer_text_single' => '',
							'prev_text' => T_('Previous'),
							'next_text' => T_('Next'),
							'list_prev_text' => T_('...'),
							'list_next_text' => T_('...'),
							'list_span' => 11,
							'scroll_list_range' => 5,
					'footer_end' => ''
				);
}

$ItemList->display_init( $display_params );

// Display navigation:
$ItemList->display_nav( 'header' );

/*
 * Display posts:
 */
while( $Item = & $ItemList->get_item() )
{
	?>
	<div id="<?php $Item->anchor_id() ?>" class="bPost bPost<?php $Item->status_raw() ?>" lang="<?php $Item->lang() ?>">
		<?php
		// We don't switch locales in the backoffice, since we use the user pref anyway
		// Load item's creator user:
		$Item->get_creator_User();
		?>
		<div class="bSmallHead <?php
		if( $Item->ID == $highlight )
		{
			echo 'fadeout-ffff00" id="fadeout-1';
		}
	 	?>">
			<?php
				echo '<div class="bSmallHeadRight">';
				$Item->locale_flag();
				echo '</div>';

				$Item->issue_date( array(
						'before'      => '<span class="bDate">',
						'after'       => '</span>',
						'date_format' => '#',
					) );

				$Item->issue_time( array(
						'before'      => ' @ <span class="bTime">',
						'after'      => '</span>',
					) );

				// TRANS: backoffice: each post is prefixed by "date BY author IN categories"
				echo ' ', T_('by'), ' <acronym title="';
				$Item->creator_User->login();
				echo ', '.T_('level:');
				$Item->creator_User->level();
				echo '"><span class="bAuthor">';
				$Item->creator_User->preferred_name();
				echo '</span></acronym>';

				echo '<div class="bSmallHeadRight">';
				$Item->status( array(
						'before' => T_('Visibility').': <span class="bStatus">',
						'after'  => '</span>',
					) );
				echo '</div>';

				echo '<br />';
				$Item->type( T_('Type').': <span class="bType">', '</span> &nbsp; ' );
				$Item->priority( T_('Priority').': <span class="bPriority">', '</span> &nbsp; ' );
				$Item->assigned_to( T_('Assigned to:').' <span class="bAssignee">', '</span> &nbsp; ' );
				$Item->extra_status( T_('Task Status').': <span class="bExtStatus">', '</span>' );
				echo '&nbsp;';

				echo '<div class="bSmallHeadRight"><span class="bViews">';
				$Item->views();
				echo '</span></div>';

				echo '<br />';

				$Item->categories( array(
					'before'          => T_('Categories').': <span class="bCategories">',
					'after'           => '</span>',
					'include_main'    => true,
					'include_other'   => true,
					'include_external'=> true,
					'link_categories' => false,
				) );
			?>
		</div>

		<div class="bContent">
			<h3 class="bTitle"><?php $Item->title() ?></h3>

			<?php
				// Display images that are linked to this post:
				$Item->images( array(
						'before' =>              '<div class="bImages">',
						'before_image' =>        '<div class="image_block">',
						'before_image_legend' => '<div class="image_legend">',
						'after_image_legend' =>  '</div>',
						'after_image' =>         '</div>',
						'after' =>               '</div>',
						'image_size' =>          'fit-320x320'
					) );
			?>

			<div class="bText">
				<?php
					// Uncomment this in case you wnt to count view in backoffice:
					/*
					$Item->count_view( array(
							'allow_multiple_counts_per_page' => false,
						) );
					*/

					// Display CONTENT:
					$Item->content_teaser( array(
							'before'      => '',
							'after'       => '',
						) );
					$Item->more_link();
					$Item->content_extension( array(
							'before'      => '',
							'after'       => '',
						) );

					// Links to post pages (for multipage posts):
					$Item->page_links( '<p class="right">'.T_('Pages:').' ', '</p>', ' &middot; ' );
				?>
			</div>

		</div>

		<?php
			// List all tags attached to this post:
			$Item->tags( array(
					'url' =>            regenerate_url( 'tag' ),
					'before' =>         '<div class="bSmallPrint">'.T_('Tags').': ',
					'after' =>          '</div>',
					'separator' =>      ', ',
				) );
		?>

		<div class="PostActionsArea">
			<?php
			$Item->permanent_link( array(
					'class' => 'permalink_right',
				) );

			echo '<a href="?ctrl=items&amp;blog='.$Blog->ID.'&amp;p='.$Item->ID.'" class="ActionButton">'.T_('View...').'</a>';

			echo '<a href="'.url_add_param( $Blog->get_filemanager_link(), 'fm_mode=link_item&amp;item_ID='.$Item->ID )
							.'" class="ActionButton">'.T_('Files...').'</a>';

			// Display edit button if current user has the rights:
			$Item->edit_link( array( // Link to backoffice for editing
					'before'    => ' ',
					'after'     => ' ',
					'class'     => 'ActionButton'
				) );

			// Display publish NOW button if current user has the rights:
			$Item->publish_link( ' ', ' ', '#', '#', 'PublishButton');

			// Display deprecate button if current user has the rights:
			$Item->deprecate_link( ' ', ' ', '#', '#', 'DeleteButton');

			// Display delete button if current user has the rights:
			$Item->delete_link( ' ', ' ', '#', '#', 'DeleteButton', false );

			if( $Blog->allowcomments != 'never' )
			{
				echo '<a href="?ctrl=items&amp;blog='.$Blog->ID.'&amp;p='.$Item->ID.'#comments" class="ActionButton">';
				// TRANS: Link to comments for current post
				comments_number(T_('no comment'), T_('1 comment'), T_('%d comments'), $Item->ID );
				load_funcs('comments/_trackback.funcs.php'); // TODO: use newer call below
				trackback_number('', ' &middot; '.T_('1 Trackback'), ' &middot; '.T_('%d Trackbacks'), $Item->ID);
				echo '</a>';
			} ?>

   		<div class="clear"></div>
		</div>

		<?php

		// _____________________________________ Displayed in SINGLE VIEW mode only _____________________________________

		if( $action == 'view' )
		{ // We are looking at a single post, include files and comments:

			// Files:
			echo '<div class="bFeedback">';	// TODO

			/**
			 * Needed by file display funcs
			 * @var Item
			 */
			global $edited_Item;
			$edited_Item = $Item;	// COPY or it will be out of scope for display funcs
			require dirname(__FILE__).'/inc/_item_links.inc.php';
			echo '</div>';



  		// ---------- comments ----------
			?>
			<div class="bFeedback">
			<a id="comments"></a>
			<h4><?php echo T_('Comments'), ', ', T_('Trackbacks'), ', ', T_('Pingbacks') ?>:</h4>
			<?php
			global $CommentList;

			$CommentList = new CommentList( NULL, "'comment','trackback','pingback'", array(), $Item->ID, '', 'ASC' );

			$CommentList->display_if_empty( array(
					'before'    => '<div class="bComment"><p>',
					'after'     => '</p></div>',
					'msg_empty' => T_('No feedback for this post yet...'),
				) );

			// Display list of comments:
			require $inc_path.'comments/views/_comment_list.inc.php';

			if( $Item->can_comment() )
			{ // User can leave a comment
			?>
			<!-- ========== FORM to add a comment ========== -->
			<h4><?php echo T_('Leave a comment') ?>:</h4>

			<?php

			$Form = & new Form( $htsrv_url.'comment_post.php', 'comment_checkchanges' );

			$Form->begin_form( 'bComment' );

			$Form->hidden( 'comment_post_ID', $Item->ID );
			$Form->hidden( 'redirect_to', $ReqURI );
			?>
				<fieldset>
					<div class="label"><?php echo T_('User') ?>:</div>
					<div class="info">
						<strong><?php $current_User->preferred_name()?></strong>
						<?php user_profile_link( ' [', ']', T_('Edit profile') ) ?>
						</div>
				</fieldset>
			<?php
			$Form->textarea( 'p', '', 12, T_('Comment text'),
												T_('Allowed XHTML tags').': '.htmlspecialchars(str_replace( '><',', ', $comment_allowed_tags)), 40, 'bComment' );

			if(substr($comments_use_autobr,0,4) == 'opt-')
			{
				echo $Form->fieldstart;
				echo $Form->labelstart;
			?>
			<label><?php echo T_('Options') ?>:</label>

			<?php
				echo $Form->labelend;
				echo $Form->inputstart;
				$Form->checkbox( 'comment_autobr', 1, T_('Auto-BR'), T_('(Line breaks become &lt;br&gt;)'), 'checkbox' );
				echo $Form->inputend;
				$Form->end_fieldset();

			}

				echo $Form->fieldstart;
				echo $Form->inputstart;
				$Form->submit( array ('submit', T_('Send comment'), 'SaveButton' ) );
				echo $Form->inputend;
				$Form->end_fieldset();

			?>

				<div class="clear"></div>
			<?php
				$Form->end_form();
			?>
			<!-- ========== END of FORM to add a comment ========== -->
			<?php
			} // / can comment
		?>
		</div>
		<?php
	} // / comments requested
?>
</div>
<?php
}

// Display navigation:
$ItemList->display_nav( 'footer' );


$block_item_Widget->disp_template_replaced( 'block_end' );


?>