<?php
/**
 * This file implements the Comment form.
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _comment.form.php,v 1.3 2008/01/21 09:35:27 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Blog
 */
global $Blog;
/**
 * @var Comment
 */
global $edited_Comment;
/**
 *
 */
global $Plugins;

global $comments_use_autobr, $mode, $month, $tab, $redirect_to;

$Form = & new Form( NULL, 'comment_checkchanges', 'post' );

$Form->global_icon( T_('Cancel editing!'), 'close', $redirect_to, T_('cancel'), 4, 1 );

$Form->begin_form( 'eform' );

$Form->hidden( 'ctrl', 'comments' );
$Form->hidden( 'action', 'update' );
$Form->hidden( 'redirect_to', $redirect_to );
$Form->hidden( 'comment_ID', $edited_Comment->ID );
?>

<div class="clear"></div>

<div class="left_col">


	<?php
	$Form->begin_fieldset( T_('Comment contents') );

	echo '<table cellspacing="0" class="compose_layout">';

	echo '<tr><td width="1%"><strong>'.T_('In response to').':</strong></td>';
	echo '<td class="input">';
	$comment_Item = & $edited_Comment->get_Item();
	$comment_Item->title( array(
			'link_type' => 'admin_view',
		) );
	echo '</td></tr>';

	if( ! $edited_Comment->get_author_User() )
	{ // This is not a member comment
		$Form->switch_layout( 'none' );

		echo '<tr><td width="1%"><strong>'.T_('Author').':</strong></td>';
		echo '<td class="input">';
		$Form->text_input( 'newcomment_author', $edited_Comment->author, 20, '', '', array('maxlength'=>100, 'style'=>'width: 100%;') );
		echo '</td></tr>';

		echo '<tr><td width="1%"><strong>'.T_('Email').':</strong></td>';
		echo '<td class="input">';
		$Form->text_input( 'newcomment_author_email', $edited_Comment->author_email, 20, '', '', array('maxlength'=>100, 'style'=>'width: 100%;') );
		echo '</td></tr>';

		echo '<tr><td width="1%"><strong>'.T_('Website URL').':</strong></td>';
		echo '<td class="input">';
		$Form->text_input( 'newcomment_author_url', $edited_Comment->author_url, 20, '', '', array('maxlength'=>100, 'style'=>'width: 100%;') );
		echo '</td></tr>';

		$Form->switch_layout( NULL );
	}
	else
	{
		echo '<tr><td width="1%"><strong>'.T_('Author').':</strong></td>';
		echo '<td class="input">';
		$edited_Comment->author();
		echo '</td></tr>';
	}

	echo '</table>';
	?>

	<div class="edit_toolbars">
	<?php // --------------------------- TOOLBARS ------------------------------------
		// CALL PLUGINS NOW:
		$Plugins->trigger_event( 'AdminDisplayToolbar', array( 'target_type' => 'Comment', 'edit_layout' => NULL ) );
	?>
	</div>

	<?php // ---------------------------- TEXTAREA -------------------------------------
	$content = $edited_Comment->content;
	if( $comments_use_autobr == 'always' || $comments_use_autobr == 'opt-out' )
	{
		// echo 'unBR:',htmlspecialchars(str_replace( ' ', '*', $content) );
		$content = unautobrize($content);
	}

	$Form->fieldstart = '<div class="edit_area">';
	$Form->fieldend = "</div>\n";
	$Form->textarea( 'content', $content, 16, '', '', 40 , '' );
	$Form->fieldstart = '<div class="tile">';
	$Form->fieldend = '</div>';
	?>
	<script type="text/javascript">
		<!--
		// This is for toolbar plugins
		var b2evoCanvas = document.getElementById('content');
		//-->
	</script>

	<div class="edit_actions">

	<input type="submit" value="<?php /* TRANS: This is the value of an input submit button */ echo T_('Save !'); ?>" class="SaveButton" tabindex="10" />

	<?php
	// ---------- DELETE ----------
	if( $action == 'editcomment' )
	{	// Editing comment
		// Display delete button if user has permission to:
		$edited_Comment->delete_link( ' ', ' ', '#', '#', 'DeleteButton', true );
	}

	// CALL PLUGINS NOW:
	$Plugins->trigger_event( 'AdminDisplayEditorButton', array( 'target_type' => 'Comment', 'edit_layout' => NULL ) );

	?>
	</div>

	<?php
	$Form->end_fieldset();

	$Form->begin_fieldset( T_('Advanced properties') );

 	$Form->switch_layout( 'linespan' );

	if( $current_User->check_perm( 'edit_timestamp' ) )
	{	// ------------------------------------ TIME STAMP -------------------------------------
		echo '<div id="itemform_edit_timestamp">';
		$Form->date( 'comment_issue_date', $edited_Comment->date, T_('Comment date') );
		echo ' '; // allow wrapping!
		$Form->time( 'comment_issue_time', $edited_Comment->date, '' );
		echo '</div>';
	}

	// --------------------------- AUTOBR --------------------------------------
	// fp> TODO: this should be Auto-P and handled by the Auto-P plugin
	?>
	<input type="checkbox" class="checkbox" name="post_autobr" value="1"
	<?php	if( $comments_use_autobr == 'always' || $comments_use_autobr == 'opt-out' ) echo ' checked="checked"' ?>
		id="autobr" tabindex="6" />
	<label for="autobr"><strong><?php echo T_('Auto-BR') ?></strong></label>

	<?php

	$Form->switch_layout( NULL );

	$Form->end_fieldset();

	// ####################### PLUGIN FIELDSETS #########################

	$Plugins->trigger_event( 'AdminDisplayCommentFormFieldset', array( 'Form' => & $Form, 'Comment' => & $edited_Comment, 'edit_layout' => NULL ) );
	?>

</div>

<div class="right_col">

<?php
	if( $Blog->get_setting('allow_rating') != 'never'
		|| !empty( $edited_Comment->rating ) )
	{	// Rating is editable
		$Form->begin_fieldset( T_('Rating') );

		echo '<p>';
		$edited_Comment->rating_input();
		echo '</p>';

		echo '<p>';
		$edited_Comment->rating_none_input();
		echo '</p>';

 		$Form->end_fieldset();
	}
	else
	{
		$Form->hidden( 'comment_rating', 0 );
	}

/*
		$Form->begin_fieldset( T_('Properties') );


		echo '<p>';
		$Form->checkbox_basic_input( 'comment_featured', $edited_Comment->featured, T_('Featured') );
		echo '</p>';

		echo '<p>';
		$Form->checkbox_basic_input( 'comment_nofollow', $edited_Comment->nofollow, 'Nofollow' );
		echo '</p>';

		$Form->end_fieldset();
*/

		$Form->begin_fieldset( T_('Visibility'), array( 'id' => 'commentform_visibility' ) );

		$sharing_options[] = array( 'published', T_('Published (Public)') );
		$sharing_options[] = array( 'draft', T_('Draft (Not published!)') );
		$sharing_options[] = array( 'deprecated', T_('Deprecated (Not published!)') );
		$Form->radio( 'comment_status', $edited_Comment->status, $sharing_options, '', true );

		$Form->end_fieldset();

		$Form->begin_fieldset( T_('Links') );

		$Form->checkbox_basic_input( 'comment_nofollow', $edited_Comment->nofollow, T_('Nofollow website URL') );
		// TODO: apply to all links

		$Form->end_fieldset();

		$Form->begin_fieldset( T_('Feedback info') );
	?>

	<p><strong><?php echo T_('Type') ?>:</strong> <?php echo $edited_Comment->type; ?></p>
	<p><strong><?php echo T_('IP address') ?>:</strong> <?php
		// Display IP address and allow plugins to filter it, e.g. the DNSBL plugin will add a link to check the IP:
		echo $Plugins->get_trigger_event( 'FilterIpAddress', array('format'=>'htmlbody', 'data'=>$edited_Comment->author_IP), 'data' ); ?></p>
	<p><strong><?php echo T_('Spam Karma') ?>:</strong> <?php $edited_Comment->spam_karma(); ?></p>

	<?php
		$Form->end_fieldset();
	?>
</div>

<div class="clear"></div>

<?php
$Form->end_form();


?>