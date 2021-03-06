<?php
/**
 * This is the template that displays the user subscriptions form
 *
 * This file is not meant to be called directly.
 * It is meant to be called by an include in the main.page.php template.
 * To display a feedback, you should call a stub AND pass the right parameters
 * For example: /blogs/index.php?disp=profile
 * Note: don't code this URL by hand, use the template functions to generate it!
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * @package evoskins
 *
 * @todo dh> Allow limiting to current blog and list of "public" ones (e.g. with blog_disp_bloglist==1)
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _subs.disp.php,v 1.3 2008/01/21 09:35:42 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var DB
 */
global $DB;

if( ! is_logged_in() )
{ // must be logged in!
	echo '<p>', T_( 'You are not logged in.' ), '</p>';
	return;
}

// fp> Note: This will "fail" if the user clicks on the 'subscriptions' link from the subscriptions page
$redirect_to = param( 'redirect_to', 'string', '' );


/**
 * form to update the profile
 * @var Form
 */
$Form = & new Form( $htsrv_url.'subs_update.php', 'SubsForm' );

$Form->begin_form( 'bComment' );
	$Form->hidden( 'checkuser_id', $current_User->ID );
	$Form->hidden( 'redirect_to', url_rel_to_same_host($redirect_to, $htsrv_url) );

	$Form->begin_fieldset( T_('Global settings') );

		$Form->info( T_('Login'), $current_User->get('login') );

		$Form->text( 'newuser_email', $current_User->get( 'email' ), 40, T_('Email'), '', 100, 'bComment' );

		$Form->checkbox( 'newuser_notify', $current_User->get( 'notify' ), T_('Notifications'), T_('Check this to receive a notification whenever someone else comments on one of <strong>your</strong> posts.') );

	$Form->end_fieldset();

	$Form->begin_fieldset( T_('Blog subscriptions') );

		// Gte those blogs for which we have already subscriptions (for this user)
		$sql = 'SELECT blog_ID, blog_shortname, sub_items, sub_comments
		          FROM T_blogs INNER JOIN T_subscriptions ON ( blog_ID = sub_coll_ID AND sub_user_ID = '.$current_User->ID.' )
		          			INNER JOIN T_coll_settings ON ( blog_ID = cset_coll_ID AND cset_name = "allow_subscriptions" AND cset_value = "1" )
		         WHERE blog_in_bloglist <> 0';
		$blog_subs = $DB->get_results( $sql );

		$encountered_current_blog = false;
		$subs_blog_IDs = array();
		foreach( $blog_subs AS $blog_sub )
		{
			if( $blog_sub->blog_ID == $Blog->ID )
			{
				$encountered_current_blog = true;
			}

			$subs_blog_IDs[] = $blog_sub->blog_ID;
			$subscriptions = array(
					array( 'sub_items_'.$blog_sub->blog_ID,    '1', T_('Posts'),    $blog_sub->sub_items ),
					array( 'sub_comments_'.$blog_sub->blog_ID, '1', T_('Comments'), $blog_sub->sub_comments )
				);
			$Form->checklist( $subscriptions, 'subscriptions', format_to_output( $blog_sub->blog_shortname, 'htmlbody' ) );
		}

		if( $Blog->get_setting( 'allow_subscriptions' ) )
		{
			if( !$encountered_current_blog )
			{	// Propose current blog too:
				$subs_blog_IDs[] = $Blog->ID;
				$subscriptions = array(
						array( 'sub_items_'.$Blog->ID,    '1', T_('Posts'),    0 ),
						array( 'sub_comments_'.$Blog->ID, '1', T_('Comments'), 0 )
					);
				$Form->checklist( $subscriptions, 'subscriptions', $Blog->dget('shortname') );
			}
		}
		else
		{
			$Form->info( $Blog->dget('shortname'), T_('Subscriptions are not allowed for this blog.') );
		}

		$Form->hidden( 'subs_blog_IDs', implode( ',', $subs_blog_IDs ) );

	$Form->end_fieldset();

$Form->end_form( array( array( '', '', T_('Update'), 'SaveButton' ),
                        array( 'reset', '', T_('Reset'), 'ResetButton' ) ) );



?>