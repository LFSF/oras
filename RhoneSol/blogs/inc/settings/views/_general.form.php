<?php
/**
 * This file implements the UI view for the general settings.
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
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 * @author blueyed: Daniel HAHLER.
 *
 * @version $Id: _general.form.php,v 1.3 2008/01/21 09:35:34 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var User
 */
global $current_User;
/**
 * @var GeneralSettings
 */
global $Settings;

$Form = & new Form( NULL, 'settings_checkchanges' );
$Form->begin_form( 'fform', T_('General Settings'),
	// enable all form elements on submit (so values get sent):
	array( 'onsubmit'=>'var es=this.elements; for( var i=0; i < es.length; i++ ) { es[i].disabled=false; };' ) );

$Form->hidden( 'ctrl', 'settings' );
$Form->hidden( 'action', 'update' );
$Form->hidden( 'tab', 'general' );

// --------------------------------------------

$Form->begin_fieldset( T_('Display options') );

$BlogCache = & get_Cache( 'BlogCache' );
$Form->select_object( 'default_blog_ID', $Settings->get('default_blog_ID'), $BlogCache, T_('Default blog to display'),
										T_('This blog will be displayed on index.php.').' <a href="admin.php?ctrl=collections&action=new">'.T_('Create new blog').' &raquo;</a>', true );

$Form->end_fieldset();

// --------------------------------------------

$Form->begin_fieldset( T_('Default user permissions') );

	$Form->checkbox( 'newusers_canregister', $Settings->get('newusers_canregister'), T_('New users can register'), T_('Check to allow new users to register themselves.' ) );

	$GroupCache = & get_Cache( 'GroupCache' );
	$Form->select_object( 'newusers_grp_ID', $Settings->get('newusers_grp_ID'), $GroupCache, T_('Group for new users'), T_('Groups determine user roles and permissions.') );

	$Form->text_input( 'newusers_level', $Settings->get('newusers_level'), 1, T_('Level for new users'), T_('Levels determine hierarchy of users in blogs.' ), array( 'maxlength'=>1, 'required'=>true ) );

$Form->end_fieldset();

// --------------------------------------------

$Form->begin_fieldset( T_('Email validation') );

	$Form->checkbox( 'newusers_mustvalidate', $Settings->get('newusers_mustvalidate'), T_('New users must validate email'), T_('Check to require users to validate their email by clicking a link sent to them.' ) );

	$Form->checkbox( 'newusers_revalidate_emailchg', $Settings->get('newusers_revalidate_emailchg'), T_('Validate email changes'), T_('Check to require users to re-validate when they change their email address.' ) );

$Form->end_fieldset();

// --------------------------------------------

$Form->begin_fieldset( T_('Security options') );

	$Form->text_input( 'user_minpwdlen', (int)$Settings->get('user_minpwdlen'), 2, T_('Minimum password length'), T_('characters.'), array( 'maxlength'=>2, 'required'=>true ) );

	$Form->checkbox_input( 'js_passwd_hashing', (bool)$Settings->get('js_passwd_hashing'), T_('Login password hashing'), array( 'note'=>T_('Check to enable the login form to hash the password with Javascript before transmitting it. This provides extra security on non-SSL connections.')) );

$Form->end_fieldset();

// --------------------------------------------

$Form->begin_fieldset( T_('Timeouts') );

	// fp>TODO: enhance UI with a general Form method for Days:Hours:Minutes:Seconds
	$Form->text_input( 'timeout_sessions', $Settings->get('timeout_sessions'), 9, T_('Session timeout'), T_('seconds. How long can a user stay inactive before automatic logout?'), array( 'required'=>true) );

	// fp>TODO: It may make sense to have a different (smaller) timeout for sessions with no logged user.
	// fp>This might reduce the size of the Sessions table. But this needs to be checked against the hit logging feature.

	$Form->text_input( 'reloadpage_timeout', (int)$Settings->get('reloadpage_timeout'), 5,
								T_('Reload-page timeout'), T_('Time (in seconds) that must pass before a request to the same URI from the same IP and useragent is considered as a new hit.'), array( 'maxlength'=>5, 'required'=>true ) );

$Form->end_fieldset();

// --------------------------------------------

if( $current_User->check_perm( 'options', 'edit' ) )
{
	$Form->end_form( array( array( 'submit', 'submit', T_('Save !'), 'SaveButton' ),
													array( 'reset', '', T_('Reset'), 'ResetButton' ) ) );
}


?>