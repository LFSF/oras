<?php
/**
 * Register a new user.
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
 * @version $Id: register.php,v 1.89 2008/01/21 09:35:23 fplanque Exp $
 */

/**
 * Includes:
 */
require_once dirname(__FILE__).'/../conf/_config.php';

require_once $inc_path.'_main.inc.php';

// Login is not required on the register page:
$login_required = false;


param( 'action', 'string', '' );
param( 'login', 'string', '' );
param( 'email', 'string', '' );
param( 'locale', 'string', $Settings->get('default_locale') );
param( 'redirect_to', 'string', '' ); // do not default to $admin_url; "empty" gets handled better in the end (uses $blogurl, if no admin perms).

locale_activate( $locale );

if( ! $Settings->get('newusers_canregister') )
{
	$action = 'disabled';
}

switch( $action )
{
	case 'register':
		/*
		 * Do the registration:
		 */
		param( 'pass1', 'string', '' );
		param( 'pass2', 'string', '' );

		// Call plugin event to allow catching input in general and validating own things from DisplayRegisterFormFieldset event
		$Plugins->trigger_event( 'RegisterFormSent', array(
				'login' => & $login,
				'email' => & $email,
				'locale' => & $locale,
				'pass1' => & $pass1,
				'pass2' => & $pass2,
			) );

		if( $Messages->count( 'error' ) )
		{ // a Plugin has added an error
			break;
		}

		// Check profile params:
		profile_check_params( array(
			'login' => $login,
			'pass1' => $pass1,
			'pass2' => $pass2,
			'email' => $email,
			'pass_required' => true ) );

		// We want all logins to be lowercase to guarantee uniqueness regardless of the database case handling for UNIQUE indexes:
		$login = strtolower( $login );

		$UserCache = & get_Cache( 'UserCache' );
		if( $UserCache->get_by_login( $login ) )
		{ // The login is already registered
			param_error( 'login', sprintf( T_('The login &laquo;%s&raquo; is already registered, please choose another one.'), $login ) );
		}

		if( $Messages->count( 'error' ) )
		{
			break;
		}

		$DB->begin();

		$new_User = & new User();
		$new_User->set( 'login', $login );
		$new_User->set( 'pass', md5($pass1) ); // encrypted
		$new_User->set( 'nickname', $login );
		$new_User->set_email( $email );
		$new_User->set( 'ip', $Hit->IP );
		$new_User->set( 'domain', $Hit->get_remote_host( true ) );
		$new_User->set( 'browser', $Hit->user_agent );
		$new_User->set_datecreated( $localtimenow );
		$new_User->set( 'locale', $locale );
		$newusers_grp_ID = $Settings->get('newusers_grp_ID');
		// echo $newusers_grp_ID;
		$GroupCache = & get_Cache( 'GroupCache' );
		$new_user_Group = & $GroupCache->get_by_ID( $newusers_grp_ID );
		// echo $new_user_Group->disp('name');
		$new_User->set_Group( $new_user_Group );

 		// Determine if the user must validate before using the system:
		$new_User->set( 'validated', ! $Settings->get('newusers_mustvalidate') );

		$new_User->dbinsert();

		$new_user_ID = $new_User->ID; // we need this to "rollback" user creation if there's no DB transaction support

		// TODO: Optionally auto create a blog (handle this together with the LDAP plugin)

		// TODO: Optionally auto assign rights

		// Actions to be appended to the user registration transaction:
		if( $Plugins->trigger_event_first_false( 'AppendUserRegistrTransact', array( 'User' => & $new_User ) ) )
		{
			// TODO: notify the plugins that have been called before about canceling of the event?!
			$DB->rollback();

			// Delete, in case there's no transaction support:
			$new_User->dbdelete( $Debuglog );

			$Messages->add( T_('No user account has been created!'), 'error' );
			break; // break out to _reg_form.php
		}

		// User created:
		$DB->commit();

		$UserCache->add( $new_User );

		// Send email to admin (using his locale):
		/**
		 * @var User
		 */
		$AdminUser = & $UserCache->get_by_ID( 1 );
		locale_temp_switch( $AdminUser->get( 'locale' ) );

		$message  = T_('New user registration on your blog').":\n"
							."\n"
							.T_('Login:')." $login\n"
							.T_('Email').": $email\n"
							."\n"
							.T_('Edit user').': '.$admin_url.'?ctrl=users&user_ID='.$new_User->ID."\n";

		send_mail( $AdminUser->get( 'email' ), T_('New user registration on your blog'), $message, $notify_from ); // ok, if this may fail..

		locale_restore_previous();

		$Plugins->trigger_event( 'AfterUserRegistration', array( 'User' => & $new_User ) );


		if( $Settings->get('newusers_mustvalidate') )
		{ // We want that the user validates his email address:
			if( $new_User->send_validate_email($redirect_to) )
			{
				$Messages->add( T_('An email has been sent to your email address. Please click on the link therein to validate your account.'), 'success' );
			}
			else
			{
				$Messages->add( T_('Sorry, the email with the link to validate and activate your password could not be sent.')
					.'<br />'.T_('Possible reason: the PHP mail() function may have been disabled on the server.'), 'error' );
				// fp> TODO: allow to enter a different email address (just in case it's that kind of problem)
			}
		}

		// Autologin the user. This is more comfortable for the user and avoids
		// extra confusion when account validation is required.
		$Session->set_User( $new_User );

		// Display confirmation screen:
		require $adminskins_path.'login/_reg_complete.main.php';

		exit();
		break;


	case 'disabled':
		/*
		 * Registration disabled:
		 */
		require $adminskins_path.'login/_reg_disabled.main.php';

		exit();
}


/*
 * Default: registration form:
 */
// Display reg form:
require $adminskins_path.'login/_reg_form.main.php';



?>