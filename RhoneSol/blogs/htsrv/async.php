<?php
/**
 * This is the handler for asynchronous 'AJAX' calls.
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
 * @package evocore
 *
 * @version $Id: async.php,v 1.26 2008/01/21 09:35:23 fplanque Exp $
 */


/**
 * Do the MAIN initializations:
 */
require_once dirname(__FILE__).'/../conf/_config.php';

/**
 * HEAVY :(
 *
 * @todo dh> refactor _main.inc.php to be able to include small parts
 *           (e.g. $current_User, charset init, ...) only..
 *           It worked already for $DB (_connect_db.inc.php).
 * fp> I think I'll try _core_main.inc , _evo_main.inc , _blog_main.inc ; this file would only need _core_main.inc
 */
require_once $inc_path.'_main.inc.php';

param( 'action', 'string', '' );

// Check global permission:
if( empty($current_User) || ! $current_User->check_perm( 'admin', 'any' ) )
{	// No permission to access admin...
	require $adminskins_path.'_access_denied.main.php';
}




// fp> Does the following have an HTTP fallback when Javascript/AJ is not available?
// dh> yes, but not through this file..
// dh> IMHO it does not make sense to let the "normal controller" handle the AJAX call
//     if there's something lightweight like calling "$UserSettings->param_Request()"!
//     Hmm.. bad example (but valid). Better example: something like the actions below, which
//     output only a small part of what the "real controller" does..
switch( $action )
{
	case 'add_plugin_sett_set':
		// Add a Plugin(User)Settings set (for "array" type settings):
		header('Content-type: text/html; charset='.$io_charset);

		param( 'plugin_ID', 'integer', true );

		$admin_Plugins = & get_Cache('Plugins_admin'); // use Plugins_admin, because a plugin might be disabled
		$Plugin = & $admin_Plugins->get_by_ID($plugin_ID);
		if( ! $Plugin )
		{
			bad_request_die('Invalid Plugin.');
		}
		param( 'set_type', 'string', '' ); // "Settings" or "UserSettings"
		if( $set_type != 'Settings' /* && $set_type != 'UserSettings' */ )
		{
			bad_request_die('Invalid set_type param!');
		}
		param( 'set_path', '/^\w+(?:\[\w+\])+$/', '' );

		load_funcs('plugins/_plugin.funcs.php');

		// Init the new setting set:
		_set_setting_by_path( $Plugin, $set_type, $set_path, array() );

		$r = get_plugin_settings_node_by_path( $Plugin, $set_type, $set_path, /* create: */ false );

		$Form = new Form(); // fake Form
		autoform_display_field( $set_path, $r['set_meta'], $Form, $set_type, $Plugin, NULL, $r['set_node'] );
		exit;

	case 'del_plugin_sett_set':
		// TODO: may use validation here..
		echo 'OK';
		exit;

	case 'admin_blogperms_set_layout':
		// Save blog permission tab layout into user settings. This gets called on JS-toggling.
		$UserSettings->param_Request( 'layout', 'blogperms_layout', 'string', $debug ? 'all' : 'default' );  // table layout mode
		exit;

}



/**
 * Call the handler/dispatcher (it is a common handler for asynchronous calls -- both AJax calls and HTTP GET fallbacks)
 */
require_once $inc_path.'_async.inc.php';


// Debug info:
echo '-expand='.$expand;
echo '-collapse='.$collapse;


?>