<?php
/**
 * This is the template that displays the user profile form. It gets POSTed to /htsrv/profile_update.php.
 *
 * This file is not meant to be called directly.
 * It is meant to be called by an include in the main.page.php template.
 * To display a feedback, you should call a stub AND pass the right parameters
 * For example: /blogs/index.php?disp=profile
 * Note: don't code this URL by hand, use the template functions to generate it!
 *
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * {@internal Open Source relicensing agreement:
 * Daniel HAHLER grants Francois PLANQUE the right to license
 * Daniel HAHLER's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 *
 * PROGIDISTRI grants Francois PLANQUE the right to license
 * PROGIDISTRI's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package evoskins
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _profile.disp.php,v 1.3 2008/01/21 09:35:42 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


if( ! is_logged_in() )
{ // must be logged in!
	echo '<p class="error">'.T_( 'You are not logged in.' ).'</p>';
	return;
}
// --- //
$redirect_to = param( 'redirect_to', 'string', '' );


/**
 * form to update the profile
 * @var Form
 */
$ProfileForm = & new Form( $htsrv_url_sensitive.'profile_update.php', 'ProfileForm' );

$ProfileForm->begin_form( 'bComment' );
$ProfileForm->hidden( 'checkuser_id', $current_User->ID );
$ProfileForm->hidden( 'redirect_to', url_rel_to_same_host($redirect_to, $htsrv_url_sensitive) );

$ProfileForm->begin_fieldset( T_('Email communications') );

	$ProfileForm->text_input( 'newuser_email', $current_User->get( 'email' ), 40, T_('Email'), '', array( 'maxlength' => 100, 'class' => 'bComment' ) );
	$ProfileForm->checkbox( 'newuser_allow_msgform', $current_User->get('allow_msgform'), T_('Message form'), T_('Check this to allow receiving emails through a message form.') );
	$ProfileForm->checkbox( 'newuser_notify', $current_User->get( 'notify' ), T_('Notifications'), T_('Check this to receive a notification whenever someone else comments on one of <strong>your</strong> posts.') );

$ProfileForm->end_fieldset();

$ProfileForm->begin_fieldset( T_('Identity') );

  $ProfileForm->info( T_('Login'), $current_User->get('login') );
	$ProfileForm->text_input( 'newuser_firstname', $current_User->get( 'firstname' ), 40, T_('First name'), '', array( 'maxlength' => 50, 'class' => 'bComment' ) );
	$ProfileForm->text_input( 'newuser_lastname', $current_User->get( 'lastname' ), 40, T_('Last name'), '', array( 'maxlength' => 50, 'class' => 'bComment' ) );
	$ProfileForm->text_input( 'newuser_nickname', $current_User->get( 'nickname' ), 40, T_('Nickname'), '', array( 'maxlength' => 50, 'class' => 'bComment' ) );
	$ProfileForm->select( 'newuser_idmode', $current_User->get('idmode'), array( &$current_User, 'callback_optionsForIdMode' ), T_('Identity shown'), '', 'bComment' );
	$ProfileForm->checkbox( 'newuser_showonline', $current_User->get( 'showonline' ), T_('Show online'), T_('Check this to be displayed as online when visiting the site.') );

$ProfileForm->end_fieldset();

$ProfileForm->begin_fieldset( T_('Password') );

	$ProfileForm->password_input( 'pass1', '', 16, T_('New pass'), array( 'note' => T_('Leave blank to leave the password unchanged.'), 'maxlength' => 50, 'class' => 'bComment' ) );
	$ProfileForm->password_input( 'pass2', '', 16, T_('Confirm'), array( 'note' => T_('Confirm new password by typing it again.')
		.' '.sprintf( T_('Minimum length: %d characters.'), $Settings->get('user_minpwdlen') ), 'maxlength' => 50, 'class' => 'bComment' ) );

$ProfileForm->end_fieldset();


$ProfileForm->begin_fieldset( T_('Preferences') );

	$ProfileForm->select( 'newuser_locale', $current_User->get( 'locale' ), 'locale_options_return', T_('Preferred locale'), '', 'bComment' );

$ProfileForm->end_fieldset();

$ProfileForm->begin_fieldset( T_('Additional info') );

	$ProfileForm->info( T_('Level'), $current_User->get('level') );
	$ProfileForm->info( T_('Posts'), $current_User->get('num_posts') );
	$ProfileForm->text_input( 'newuser_url', $current_User->get( 'url' ), 40, T_('URL'), '', array( 'maxlength' => 100, 'class' => 'bComment' ) );
	$ProfileForm->text_input( 'newuser_icq', $current_User->get( 'icq' ), 40, T_('ICQ'), '', array( 'maxlength' => 10, 'class' => 'bComment' ) );
	$ProfileForm->text_input( 'newuser_aim', $current_User->get( 'aim' ), 40, T_('AOL I.M.'), '', array( 'maxlength' => 50, 'class' => 'bComment' ) );
	$ProfileForm->text_input( 'newuser_msn', $current_User->get( 'msn' ), 40, T_('MSN I.M.'), '', array( 'maxlength' => 100, 'class' => 'bComment' ) );
	$ProfileForm->text_input( 'newuser_yim', $current_User->get( 'yim' ), 40, T_('Yahoo I.M.'), '', array( 'maxlength' => 50, 'class' => 'bComment' ) );

$ProfileForm->end_fieldset();

$ProfileForm->buttons( array( array( '', '', T_('Update'), 'SaveButton' ),
															array( 'reset', '', T_('Reset'), 'ResetButton' ) ) );

$ProfileForm->end_form();



?>