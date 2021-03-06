<?php
/**
 * This file implements the UI controller for settings management.
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
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: settings.ctrl.php,v 1.2 2008/01/21 09:35:34 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


// Check minimum permission:
$current_User->check_perm( 'options', 'view', true );


$AdminUI->set_path( 'options', 'general' );

param( 'action', 'string' );
param( 'edit_locale', 'string' );
param( 'loc_transinfo', 'integer', 0 );

if( in_array( $action, array( 'update', 'reset', 'updatelocale', 'createlocale', 'deletelocale', 'extract', 'prioup', 'priodown' )) )
{ // We have an action to do..
	// Check permission:
	$current_User->check_perm( 'options', 'edit', true );

	// clear settings cache
	$cache_settings = '';

	// UPDATE general settings:

	param( 'newusers_canregister', 'integer', 0 );
	$Settings->set( 'newusers_canregister', $newusers_canregister );

	param( 'newusers_mustvalidate', 'integer', 0 );
	$Settings->set( 'newusers_mustvalidate', $newusers_mustvalidate );

	param( 'newusers_revalidate_emailchg', 'integer', 0 );
	$Settings->set( 'newusers_revalidate_emailchg', $newusers_revalidate_emailchg );

	param( 'newusers_grp_ID', 'integer', true );
	$Settings->set( 'newusers_grp_ID', $newusers_grp_ID );

	param_integer_range( 'newusers_level', 0, 9, T_('User level must be between %d and %d.') );
	$Settings->set( 'newusers_level', $newusers_level );

	param( 'default_blog_ID', 'integer', true );
	$Settings->set( 'default_blog_ID', $default_blog_ID );

	param_integer_range( 'user_minpwdlen', 1, 32, T_('Minimun password length must be between %d and %d.') );
	$Settings->set( 'user_minpwdlen', $user_minpwdlen );

	param( 'js_passwd_hashing', 'integer', 0 );
	$Settings->set( 'js_passwd_hashing', $js_passwd_hashing );


	// Session timeout
	$timeout_sessions = param( 'timeout_sessions', 'integer', $Settings->get_default('timeout_sessions') );
	if( $timeout_sessions < 300 )
	{ // lower than 5 minutes: not allowed
		param_error( 'timeout_sessions', sprintf( T_( 'You cannot set a session timeout below %d seconds.' ), 300 ) );
	}
	elseif( $timeout_sessions < 86400 )
	{ // lower than 1 day: notice/warning
		$Messages->add( sprintf( T_( 'Warning: your session timeout is just %d seconds. Your users may have to re-login often!' ), $timeout_sessions ), 'note' );
	}
	$Settings->set( 'timeout_sessions', $timeout_sessions );

	param_integer_range( 'reloadpage_timeout', 0, 99999, T_('Reload-page timeout must be between %d and %d.') );
	$Settings->set( 'reloadpage_timeout', $reloadpage_timeout );

	if( ! $Messages->count('error') )
	{
		if( $Settings->dbupdate() )
		{
			$Messages->add( T_('General settings updated.'), 'success' );
		}
	}

}


// Display <html><head>...</head> section! (Note: should be done early if actions do not redirect)
$AdminUI->disp_html_head();

// Display title, menu, messages, etc. (Note: messages MUST be displayed AFTER the actions)
$AdminUI->disp_body_top();

// Begin payload block:
$AdminUI->disp_payload_begin();

// Display VIEW:
$AdminUI->disp_view( 'settings/views/_general.form.php' );

// End payload block:
$AdminUI->disp_payload_end();

// Display body bottom, debug info and close </html>:
$AdminUI->disp_global_footer();


?>