<?php
/**
 * This file implements the comment list
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
 * @version $Id: _comment_list.inc.php,v 1.7 2008/01/21 09:35:27 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Comment
 */
global $Comment;
/**
 * @var Blog
 */
global $Blog;
/**
 * @var CommentList
 */
global $CommentList;

global $dispatcher;

while( $Comment = & $CommentList->get_next() )
{ // Loop through comments:
	?>
	<!-- ========== START of a COMMENT/TB/PB ========== -->
	<div id="c<?php echo $Comment->ID ?>" class="bComment bComment<?php $Comment->status('raw') ?>">
		<div class="bSmallHead">
			<?php
				echo '<div class="bSmallHeadRight">';
				echo T_('Visibility').': ';
				echo '<span class="bStatus">';
				$Comment->status();
				echo '</span>';
				echo '</div>';
			?>
			<span class="bDate"><?php $Comment->date(); ?></span>
			@
			<span class="bTime"><?php $Comment->time( 'H:i' ); ?></span>
			<?php
			if( $Comment->author_url( '', ' &middot; Url: <span class="bUrl">', '</span>' )
					&& $current_User->check_perm( 'spamblacklist', 'edit' ) )
			{ // There is an URL and we have permission to ban...
				// TODO: really ban the base domain! - not by keyword
				echo ' <a href="'.$dispatcher.'?ctrl=antispam&amp;action=ban&amp;keyword='.rawurlencode(get_ban_domain($Comment->author_url))
					.'">'.get_icon( 'ban' ).'</a> ';
			}
			$Comment->author_email( '', ' &middot; Email: <span class="bEmail">', '</span>' );
			$Comment->author_ip( ' &middot; IP: <span class="bIP">', '</span>' );
			echo ' &middot; <span class="bKarma">';
			$Comment->spam_karma( T_('Spam Karma').': %s%', T_('No Spam Karma') );
			echo '</span>';
		 ?>
		</div>
		<div class="bCommentContent">
		<div class="bTitle">
			<?php
			$comment_Item = & $Comment->get_Item();
			echo T_('In response to:')
				.' <a href="?ctrl=items&amp;blog='.$Blog->ID.'&amp;p='.$comment_Item->ID.'">'.$comment_Item->dget('title').'</a>';
			?>
		</div>
		<div class="bCommentTitle">
		<?php
			switch( $Comment->get( 'type' ) )
			{
				case 'comment': // Display a comment:
					echo T_('Comment from') ?>
					<?php break;

				case 'trackback': // Display a trackback:
					echo T_('Trackback from') ?>
					<?php break;

				case 'pingback': // Display a pingback:
					echo T_('Pingback from') ?>
					<?php break;
			}
		echo ': ';
		?>
		<?php $Comment->author() ?>
		</div>
		<div class="bCommentText">
			<?php $Comment->rating(); ?>
			<?php $Comment->content() ?>
		</div>
		</div>
		<div class="CommentActionsArea">
			<?php
				$Comment->permanent_link( array(
						'class'    => 'permalink_right'
					) );

				// Display edit button if current user has the rights:
				$Comment->edit_link( ' ', ' ', '#', '#', 'ActionButton');

				// Display publish NOW button if current user has the rights:
				$Comment->publish_link( ' ', ' ', '#', '#', 'PublishButton', '&amp;', true );

				// Display deprecate button if current user has the rights:
				$Comment->deprecate_link( ' ', ' ', '#', '#', 'DeleteButton', '&amp;', true );

				// Display delete button if current user has the rights:
				$Comment->delete_link( ' ', ' ', '#', '#', 'DeleteButton');
			?>
   		<div class="clear"></div>
		</div>

	</div>
	<!-- ========== END of a COMMENT/TB/PB ========== -->
	<?php //end of the loop, don't delete
}


?>