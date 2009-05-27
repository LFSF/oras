<?php
/**
 * This file implements the PluginS class.
 *
 * This is where you can plug in some {@link Plugin plugins} :D
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
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE - {@link http://fplanque.net/}
 * @author blueyed: Daniel HAHLER
 *
 * @version $Id: _plugins.class.php,v 1.4 2008/01/21 09:35:32 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('plugins/_plugin.class.php');


/**
 * Plugins Class
 *
 * This is where you can plug in some {@link Plugin plugins} :D
 *
 * @todo dh> Currently when a plugin goes into "broken" status (e.g. file not readable), it is "disabled" afterwards.
 *       This should rather remember the old status (e.g. "enabled") and make it enabled again.
 *
 * @package evocore
 */
class Plugins
{
	/**#@+
	 * @access private
	 */

	/**
	 * @var array of plugin_code => Plugin
	 */
	var $index_code_Plugins = array();

	/**
	 * @var array of plugin_ID => Plugin
	 */
	var $index_ID_Plugins = array();

	/**
	 * @see Plugins::load_events()
	 * @var array of event => plug_ID. IDs are sorted by priority.
	 */
	var $index_event_IDs = array();

	/**
	 * fp> does it cost that much to instantiate plugins right away, now that init is no longer in the constructor?
	 * @var array of plug_ID => DB row from T_plugins. Used to lazy-instantiate Plugins.
	 */
	var $index_ID_rows = array();

	/**
	 * fp> does it cost that much to instantiate plugins right away, now that init is no longer in the constructor?
	 * @var array of plug_code => plug_ID. Usedp to lazy-instantiate by code.
	 */
	var $index_code_ID = array();

	/**
	 * Cache Plugin codes by apply_rendering setting.
	 * @var array of apply_rendering => plug_code
	 */
	var $index_apply_rendering_codes = array();

	/**
	 * Path to plugins.
	 *
	 * The preferred method is to have a sub-directory for each plugin (named
	 * after the plugin's classname), but they can be supplied just in this
	 * directory.
	 */
	var $plugins_path;

	/**
	 * Have we loaded the plugins table (T_plugins)?
	 * @var boolean
	 */
	var $loaded_plugins_table = false;

	/**
	 * Current object index in {@link $sorted_IDs} array.
	 * @var integer
	 */
	var $current_idx = -1;

	/**
	 * List of IDs, sorted. This gets used to lazy-instantiate a Plugin.
	 *
	 * @var array
	 */
	var $sorted_IDs = array();

	/**
	 * The smallest internal/auto-generated Plugin ID.
	 * @var integer
	 */
	var $smallest_internal_ID = 0;

	/**#@-*/


	/**#@+
	 * @access protected
	 */

	/**
	 * SQL to use in {@link load_plugins_table()}. Gets overwritten for {@link Plugins_admin}.
	 * @var string
	 * @static
	 */
	var $sql_load_plugins_table = '
			SELECT plug_ID, plug_priority, plug_classname, plug_code, plug_name, plug_shortdesc, plug_apply_rendering, plug_status, plug_version, plug_spam_weight
			  FROM T_plugins
			 WHERE plug_status = \'enabled\'
			 ORDER BY plug_priority, plug_classname';

	/**#@-*/


	/**
	 * Errors associated to plugins (during loading), indexed by plugin_ID and
	 * error class ("register").
	 *
	 * @var array
	 */
	var $plugin_errors = array();


	/**
	 * Constructor. Sets {@link $plugins_path} and load events.
	 */
	function Plugins()
	{
		global $basepath, $plugins_subdir, $Timer;

		// Set plugin path:
		$this->plugins_path = $basepath.$plugins_subdir;

		$Timer->resume( 'plugin_init' );

		// Load events for enabled plugins:
		$this->load_events();

		$Timer->pause( 'plugin_init' );
	}


	/**
	 * Get a list of available Plugin groups.
	 *
	 * @return array
	 */
	function get_plugin_groups()
	{
		$result = array();

		foreach( $this->sorted_IDs as $plugin_ID )
		{
			$Plugin = & $this->get_by_ID( $plugin_ID );

			if( empty($Plugin->group) || in_array( $Plugin->group, $result ) )
			{
				continue;
			}

			$result[] = $Plugin->group;
		}

		return $result;
	}


	/**
	 * Will return an array that contents are references to plugins that have the same group, regardless of the sub_group.
	 *
	 * @return array
	 */
	function get_Plugins_in_group( $group )
	{
		$result = array();

		foreach( $this->sorted_IDs as $plugin_ID )
		{
			$Plugin = & $this->get_by_ID( $plugin_ID );
			if( $Plugin->group == $group )
			{
				$result[] = & $Plugin;
			}
		}

		return $result;
	}


	/**
	 * Will return an array that contents are references to plugins that have the same group and sub_group.
	 *
	 * @return array
	 */
	function get_Plugins_in_sub_group( $group, $sub_group = '' )
	{
		$result = array();

		foreach( $this->sorted_IDs as $plugin_ID )
		{
			$Plugin = & $this->get_by_ID( $plugin_ID );
			if( $Plugin->group == $group && $Plugin->sub_group == $sub_group )
			{
				$result[] = & $Plugin;
			}
		}

		return $result;
	}


	/**
	 * Sets the status of a Plugin in DB and registers it into the internal indices when "enabled".
	 * Otherwise it gets unregistered, but only when we're not in {@link Plugins_admin}, because we
	 * want to keep it in then in our indices.
	 *
	 * {@internal
	 * Note: this should probably always get called on the {@link $Plugins} object,
	 *       not {@link $admin_Plugins}.
	 * }}
	 *
	 * @param Plugin
	 * @param string New status ("enabled", "disabled", "needs_config", "broken")
	 */
	function set_Plugin_status( & $Plugin, $status )
	{
		global $DB, $Debuglog;

		$DB->query( "UPDATE T_plugins SET plug_status = '".$status."' WHERE plug_ID = '".$Plugin->ID."'" );

		if( $status == 'enabled' )
		{ // Reload plugins tables, which includes the plugin in further requests
			$this->loaded_plugins_table = false;
			$this->load_plugins_table();
			$this->load_events();
		}
		else
		{
			// Notify the plugin that it has been disabled:
			$Plugin->BeforeDisable();

			$this->unregister( $Plugin );
		}

		$Plugin->status = $status;

		$Debuglog->add( 'Set status for plugin #'.$Plugin->ID.' to "'.$status.'"!', 'plugins' );
	}


	/**
	 * Register a plugin.
	 *
	 * This handles the indexes, dynamically unregisters a Plugin that does not exist (anymore)
	 * and instantiates the Plugin's (User)Settings.
	 *
	 * @access protected
	 * @param string name of plugin class to instantiate and register
	 * @param int ID in database (0 if not installed)
	 * @param int Priority in database (-1 to keep default)
	 * @param array When should rendering apply? (NULL to keep default)
	 * @param string Path of the .php class file of the plugin.
	 * @param boolean Must the plugin exist (classfile_path and classname)?
	 *                This is used internally to be able to unregister a non-existing plugin.
	 * @return Plugin Plugin ref to newly created plugin; string in case of error
	 */
	function & register( $classname, $ID = 0, $priority = -1, $apply_rendering = NULL, $classfile_path = NULL, $must_exists = true )
	{
		global $Debuglog, $Messages, $Timer;

		if( $ID && isset($this->index_ID_Plugins[$ID]) )
		{
			debug_die( 'Tried to register already registered Plugin (ID '.$ID.')' ); // should never happen!
		}

		$Timer->resume( 'plugins_register' );

		if( empty($classfile_path) )
		{
			$plugin_filename = '_'.str_replace( '_plugin', '.plugin', $classname ).'.php';
			// Try <plug_classname>/<plug_classname>.php (subfolder) first
			$classfile_path = $this->plugins_path.$classname.'/'.$plugin_filename;

			if( ! is_readable( $classfile_path ) )
			{ // Look directly in $plugins_path
				$classfile_path = $this->plugins_path.$plugin_filename;
			}
		}

		$Debuglog->add( 'register(): '.$classname.', ID: '.$ID.', priority: '.$priority.', classfile_path: ['.$classfile_path.']', 'plugins' );

		if( ! is_readable( $classfile_path ) )
		{ // Plugin file not found!
			if( $must_exists )
			{
				$r = 'Plugin class file ['.rel_path_to_base($classfile_path).'] is not readable!';
				$Debuglog->add( $r, array( 'plugins', 'error' ) );

				// Get the Plugin object (must not exist)
				$Plugin = & $this->register( $classname, $ID, $priority, $apply_rendering, $classfile_path, false );
				$this->plugin_errors[$ID]['register'] = $r;
				$this->set_Plugin_status( $Plugin, 'broken' );

				// unregister:
				if( $this->unregister( $Plugin ) )
				{
					$Debuglog->add( 'Unregistered plugin ['.$classname.']!', array( 'plugins', 'error' ) );
				}
				else
				{
					$Plugin->name = $Plugin->classname; // use the classname instead of "unnamed plugin"
					$Timer->pause( 'plugins_register' );
					return $Plugin;
				}

				$Timer->pause( 'plugins_register' );
				return $r;
			}
		}
		elseif( ! class_exists($classname) ) // If there are several copies of one plugin for example..
		{
			$Debuglog->add( 'Loading plugin class file: '.$classname, 'plugins' );
			require_once $classfile_path;
		}

		if( ! class_exists( $classname ) )
		{ // the given class does not exist
			if( $must_exists )
			{
				$r = sprintf( 'Plugin class for &laquo;%s&raquo; in file &laquo;%s&raquo; not defined.', $classname, rel_path_to_base($classfile_path) );
				$Debuglog->add( $r, array( 'plugins', 'error' ) );

				// Get the Plugin object (must not exist)    fp> why is this recursive?
				$Plugin = & $this->register( $classname, $ID, $priority, $apply_rendering, $classfile_path, false );
				$this->plugin_errors[$ID]['register'] = $r;
				$this->set_Plugin_status( $Plugin, 'broken' );

				// unregister:
				if( $this->unregister( $Plugin ) )
				{
					$Debuglog->add( 'Unregistered plugin ['.$classname.']!', array( 'plugins', 'error' ) );
				}
				else
				{
					$Plugin->name = $Plugin->classname; // use the classname instead of "unnamed plugin"
					$Timer->pause( 'plugins_register' );
					return $Plugin;
				}

				$Timer->pause( 'plugins_register' );
				return $r;
			}
			else
			{
				$Plugin = new Plugin;	// COPY !
				$Plugin->code = NULL;
				$Plugin->apply_rendering = 'never';
			}
		}
		else
		{
			$Plugin = new $classname;	// COPY !
		}

		$Plugin->classfile_path = $classfile_path;

		// Tell him his ID :)
		if( $ID == 0 )
		{
			$Plugin->ID = --$this->smallest_internal_ID;
		}
		else
		{
			$Plugin->ID = $ID;

			if( $ID > 0 )
			{ // Properties from T_plugins
				// Code
				$Plugin->code = $this->index_ID_rows[$Plugin->ID]['plug_code'];
				// Status
				$Plugin->status = $this->index_ID_rows[$Plugin->ID]['plug_status'];
			}
		}
		// Tell him his name :)
		$Plugin->classname = $classname;
		// Tell him his priority:
		if( $priority > -1 ) { $Plugin->priority = $priority; }

		if( isset($apply_rendering) )
		{
			$Plugin->apply_rendering = $apply_rendering;
		}

		if( empty($Plugin->name) )
		{
			$Plugin->name = $Plugin->classname;
		}

		// Memorizes Plugin in code hash array:
		if( ! empty($this->index_code_ID[ $Plugin->code ]) && $this->index_code_ID[ $Plugin->code ] != $Plugin->ID )
		{ // The plugin's default code is already in use!
			$Plugin->code = NULL;
		}
		else
		{
			$this->index_code_Plugins[ $Plugin->code ] = & $Plugin;
			$this->index_code_ID[ $Plugin->code ] = & $Plugin->ID;
		}
		$this->index_ID_Plugins[ $Plugin->ID ] = & $Plugin;

		if( ! in_array( $Plugin->ID, $this->sorted_IDs ) ) // TODO: check if this extra check is required..
		{ // not in our sort index yet
			$this->sorted_IDs[] = & $Plugin->ID;
		}

		// Stuff only for real/existing Plugins (which exist in DB):
		if( $Plugin->ID > 0 )
		{
			// Instantiate the Plugins (User)Settings members:
			$this->init_settings( $Plugin );

			$tmp_params = array( 'db_row' => $this->index_ID_rows[$Plugin->ID], 'is_installed' => true );
			if( $Plugin->PluginInit( $tmp_params ) === false && $this->unregister( $Plugin ) )
			{
				$Debuglog->add( 'Unregistered plugin, because PluginInit returned false.', 'plugins' );
				$Plugin = '';
			}
			// Version check:
			elseif( $Plugin->version != $this->index_ID_rows[$Plugin->ID]['plug_version'] && $must_exists )
			{ // Version has changed since installation or last update
				$db_deltas = array();

				// Tell the Plugin that we've detected a version change:
				$tmp_params = array( 'old_version'=>$this->index_ID_rows[$Plugin->ID]['plug_version'], 'db_row'=>$this->index_ID_rows[$Plugin->ID] );

				if( $this->call_method( $Plugin->ID, 'PluginVersionChanged', $tmp_params ) === false )
				{
					$Debuglog->add( 'Set plugin status to "needs_config", because PluginVersionChanged returned false.', 'plugins' );
					$this->set_Plugin_status( $Plugin, 'needs_config' );
					if( $this->unregister( $Plugin ) )
					{ // only unregister the Plugin, if it's not the admin list's class:
						$Plugin = '';
					}
				}
				else
				{
					// Check if there are DB deltas required (also when downgrading!), without excluding any query type:
					load_class('_core/model/db/_upgrade.funcs.php');
					$db_deltas = db_delta( $Plugin->GetDbLayout() );

					if( empty($db_deltas) )
					{ // No DB changes needed, update (bump or decrease) the version
						global $DB;
						$Plugins_admin = & get_Cache('Plugins_admin');

						// Update version in DB:
						$DB->query( '
								UPDATE T_plugins
								   SET plug_version = '.$DB->quote($Plugin->version).'
								 WHERE plug_ID = '.$Plugin->ID );

						// Update "plug_version" in indexes:
						$this->index_ID_rows[$Plugin->ID]['plug_version'] = $Plugin->version;
						if( isset($Plugins_admin->index_ID_rows[$Plugin->ID]) )
						{
							$Plugins_admin->index_ID_rows[$Plugin->ID]['plug_version'] = $Plugin->version;
						}

						// Remove any prerenderered content for the Plugins renderer code:
						if( ! empty($Plugin->code) )
						{
							$DB->query( '
									DELETE FROM T_items__prerendering
									 WHERE itpr_renderers REGEXP "^(.*\.)?'.$DB->escape($Plugin->code).'(\..*)?$"' );
						}

						// Detect new events (and delete obsolete ones - in case of downgrade):
						if( $Plugins_admin->save_events( $Plugin, array() ) )
						{
							$this->load_events(); // re-load for the current request
						}

						$Debuglog->add( 'Version for '.$Plugin->classname.' changed from '.$this->index_ID_rows[$Plugin->ID]['plug_version'].' to '.$Plugin->version, 'plugins' );
					}
					else
					{ // If there are DB schema changes needed, set the Plugin status to "needs_config"

						// TODO: automatic upgrade in some cases (e.g. according to query types)?

						$this->set_Plugin_status( $Plugin, 'needs_config' );
						$Debuglog->add( 'Set plugin status to "needs_config", because version DB schema needs upgrade.', 'plugins' );

						if( $this->unregister( $Plugin ) )
						{ // only unregister the Plugin, if it's not the admin list's class:
							$Plugin = '';
						}
					}
				}
			}

			if( $Plugin && isset($this->index_ID_rows[$Plugin->ID]) ) // may have been unregistered above
			{
				if( $this->index_ID_rows[$Plugin->ID]['plug_name'] !== NULL )
				{
					$Plugin->name = $this->index_ID_rows[$Plugin->ID]['plug_name'];
				}
				if( $this->index_ID_rows[$Plugin->ID]['plug_shortdesc'] !== NULL )
				{
					$Plugin->short_desc = $this->index_ID_rows[$Plugin->ID]['plug_shortdesc'];
				}
			}
		}
		else
		{ // This gets called for non-installed Plugins:
			// Instantiate the Plugins (User)Settings members:
			$this->init_settings( $Plugin );

			$tmp_params = array( 'db_row' => array(), 'is_installed' => false );
			if( $Plugin->PluginInit( $tmp_params ) === false && $this->unregister( $Plugin ) )
			{
				$Debuglog->add( 'Unregistered plugin, because PluginInit returned false.', 'plugins' );
				$Plugin = '';
			}
		}

		$Timer->pause( 'plugins_register' );

		return $Plugin;
	}


	/**
	 * Un-register a plugin.
	 *
	 * This does not un-install it from DB, just from the internal indexes.
	 *
	 * @param Plugin
	 * @param boolean Force unregistering (ignored here, but used in Plugins_admin)
	 * @return boolean True, if unregistered
	 */
	function unregister( & $Plugin, $force = false )
	{
		global $Debuglog;

		$this->forget_events( $Plugin->ID );

		// Unset apply-rendering index:
		if( isset( $this->index_apply_rendering_codes[ $Plugin->apply_rendering ] ) )
		{
			while( ( $key = array_search( $Plugin->code, $this->index_apply_rendering_codes[$Plugin->apply_rendering] ) ) !== false )
			{
				unset( $this->index_apply_rendering_codes[$Plugin->apply_rendering][$key] );
			}
		}

		unset( $this->index_code_Plugins[ $Plugin->code ] );
		unset( $this->index_ID_Plugins[ $Plugin->ID ] );

		if( isset($this->index_ID_rows[ $Plugin->ID ]) )
		{ // It has an associated DB row (load_plugins_table() was called)
			unset($this->index_ID_rows[ $Plugin->ID ]);
		}

		$sort_key = array_search( $Plugin->ID, $this->sorted_IDs );
		if( $sort_key === false )
		{ // this may happen if a Plugin has unregistered itself
			$Debuglog->add( 'Tried to unregister not-installed plugin (not in $sorted_IDs)!', 'plugins' );
			return false;
		}
		unset( $this->sorted_IDs[$sort_key] );
		$this->sorted_IDs = array_values( $this->sorted_IDs );

		if( $this->current_idx >= $sort_key )
		{ // We have removed a file before or at the $sort_key'th position
			$this->current_idx--;
		}

		return true;
	}


	/**
	 * Forget the events a Plugin has registered.
	 *
	 * This gets used when {@link unregister() unregistering} a Plugin or if
	 * {@link Plugin::PluginInit()} returned false, which means
	 * "do not use it for subsequent events in the request".
	 *
	 * @param integer Plugin ID
	 */
	function forget_events( $plugin_ID )
	{
		// Forget events:
		foreach( array_keys($this->index_event_IDs) as $l_event )
		{
			while( ($key = array_search( $plugin_ID, $this->index_event_IDs[$l_event] )) !== false )
			{
				unset( $this->index_event_IDs[$l_event][$key] );
			}
		}
	}


	/**
	 * Init {@link Plugin::$Settings} and {@link Plugin::$UserSettings}, either by
	 * unsetting them for PHP5's overloading or instantiating them for PHP4.
	 *
	 * @param Plugin
	 */
	function init_settings( & $Plugin )
	{
		if( version_compare( PHP_VERSION, '5.1', '>=' ) )
		{ // we use overloading for PHP5, therefor the member has to be unset:
			// Note: this is somehow buggy at least in PHP 5.0.5, therefor we use it from 5.1 on.
			//       see http://forums.b2evolution.net/viewtopic.php?p=49031#49031
			unset( $Plugin->Settings );
			unset( $Plugin->UserSettings );

			// Nothing to do here, will get called through Plugin::__get() when accessed
			return;
		}

		// PHP < 5.1: instantiate now:
		$this->instantiate_Settings( $Plugin, 'Settings' );
		$this->instantiate_Settings( $Plugin, 'UserSettings' );
	}


	/**
	 * Instantiate Settings object (class {@link PluginSettings}) for the given plugin.
	 *
	 * The plugin must provide setting definitions (through {@link Plugin::GetDefaultSettings()}
	 * OR {@link Plugin::GetDefaultUserSettings()}).
	 *
	 * @param Plugin
	 * @param string settings type: "Settings" or "UserSettings"
	 * @return boolean NULL, if no Settings
	 */
	function instantiate_Settings( & $Plugin, $set_type )
	{
		global $Debuglog, $Timer;

		$Timer->resume( 'plugins_inst_'.$set_type );

		// call Plugin::GetDefaultSettings() or Plugin::GetDefaultUserSettings():
		$defaults = $this->call_method( $Plugin->ID, 'GetDefault'.$set_type, $params = array('for_editing'=>false) );

		if( empty($defaults) )
		{	// No settings, no need to instantiate.
			$Timer->pause( 'plugins_inst_'.$set_type );
			return NULL;
		}

		if( ! is_array($defaults) )
		{	// invalid data
			$Debuglog->add( $Plugin->classname.'::GetDefault'.$set_type.'() did not return array!', array('plugins', 'error') );
			return NULL; // fp> correct me if I'm wrong.
		}

		if( $set_type == 'UserSettings' )
		{	// User specific settings:
			load_class('plugins/model/_pluginusersettings.class.php');

			$Plugin->UserSettings = new PluginUserSettings( $Plugin->ID );

			$set_Obj = & $Plugin->UserSettings;
		}
		else
		{	// Global settings:
			load_class('plugins/model/_pluginsettings.class.php');

			$Plugin->Settings = new PluginSettings( $Plugin->ID );

			$set_Obj = & $Plugin->Settings;
		}

		// Register default values:
		foreach( $defaults as $l_name => $l_meta )
		{
			if( isset($l_meta['layout']) )
			{ // Skip non-value entries
				continue;
			}

			// Register settings as _defaults into Settings:
			if( isset($l_meta['defaultvalue']) )
			{
				$set_Obj->_defaults[$l_name] = $l_meta['defaultvalue'];
			}
			elseif( isset( $l_meta['type'] ) && $l_meta['type'] == 'array' )
			{
				$set_Obj->_defaults[$l_name] = array();
			}
			else
			{
				$set_Obj->_defaults[$l_name] = '';
			}
		}

		$Timer->pause( 'plugins_inst_'.$set_type );

		return true;
	}


	/**
	 * Load plugins table and rewind iterator used by {@link get_next()}.
	 */
	function restart()
	{
		$this->load_plugins_table();

		$this->current_idx = -1;
	}


	/**
	 * Get next plugin in the list.
	 *
	 * NOTE: You'll have to call {@link restart()} or {@link load_plugins_table()}
	 * before using it.
	 *
	 * @return Plugin (false if no more plugin).
	 */
	function & get_next()
	{
		global $Debuglog;

		++$this->current_idx;

		$Debuglog->add( 'get_next() ('.$this->current_idx.')..', 'plugins' );

		if( isset($this->sorted_IDs[$this->current_idx]) )
		{
			$Plugin = & $this->get_by_ID( $this->sorted_IDs[$this->current_idx] );

			if( ! $Plugin )
			{ // recurse until we've been through whole $sorted_IDs!
				return $this->get_next();
			}

			$Debuglog->add( 'return: '.$Plugin->classname.' ('.$Plugin->ID.')', 'plugins' );
			return $Plugin;
		}
		else
		{
			$Debuglog->add( 'return: false', 'plugins' );
			--$this->current_idx;
			$r = false;
			return $r;
		}
	}


	/**
	 * Stop propagation of events to next plugins in {@link trigger_event()}.
	 */
	function stop_propagation()
	{
		$this->_stop_propagation = true;
	}


	/**
	 * Call all plugins for a given event.
	 *
	 * @param string event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @return boolean True, if at least one plugin has been called.
	 */
	function trigger_event( $event, $params = array() )
	{
		global $Debuglog;

		$Debuglog->add( 'Trigger event '.$event, 'plugins' );

		if( empty($this->index_event_IDs[$event]) )
		{ // No events registered
			$Debuglog->add( 'No registered plugins.', 'plugins' );
			return false;
		}

		$Debuglog->add( 'Registered plugin IDs: '.implode( ', ', $this->index_event_IDs[$event]), 'plugins' );

		foreach( $this->index_event_IDs[$event] as $l_plugin_ID )
		{
			$this->call_method( $l_plugin_ID, $event, $params );

			if( ! empty($this->_stop_propagation) )
			{	// A plugin has requested to stop propagation.
				$this->_stop_propagation = false;
				break;
			}
		}
		return true;
	}


	/**
	 * Call all plugins for a given event, until the first one returns true.
	 *
	 * @param string event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @return array The (modified) params array with key "plugin_ID" set to the last called plugin;
	 *               Empty array if no Plugin returned true or no Plugin has this event registered.
	 */
	function trigger_event_first_true( $event, $params = NULL )
	{
		global $Debuglog;

		$Debuglog->add( 'Trigger event '.$event.' (first true)', 'plugins' );

		if( empty($this->index_event_IDs[$event]) )
		{ // No events registered
			$Debuglog->add( 'No registered plugins.', 'plugins' );
			return array();
		}

		$Debuglog->add( 'Registered plugin IDs: '.implode( ', ', $this->index_event_IDs[$event]), 'plugins' );
		foreach( $this->index_event_IDs[$event] as $l_plugin_ID )
		{
			$r = $this->call_method( $l_plugin_ID, $event, $params );
			if( $r === true )
			{
				$Debuglog->add( 'Plugin ID '.$l_plugin_ID.' returned true!', 'plugins' );
				$params['plugin_ID'] = & $l_plugin_ID;
				return $params;
			}
		}
		return array();
	}


	/**
	 * Call all plugins for a given event, until the first one returns false.
	 *
	 * @param string event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @return array The (modified) params array with key "plugin_ID" set to the last called plugin;
	 *               Empty array if no Plugin returned true or no Plugin has this event registered.
	 */
	function trigger_event_first_false( $event, $params = NULL )
	{
		global $Debuglog;

		$Debuglog->add( 'Trigger event '.$event.' (first false)', 'plugins' );

		if( empty($this->index_event_IDs[$event]) )
		{ // No events registered
			$Debuglog->add( 'No registered plugins.', 'plugins' );
			return array();
		}

		$Debuglog->add( 'Registered plugin IDs: '.implode( ', ', $this->index_event_IDs[$event]), 'plugins' );
		foreach( $this->index_event_IDs[$event] as $l_plugin_ID )
		{
			$r = $this->call_method( $l_plugin_ID, $event, $params );
			if( $r === false )
			{
				$Debuglog->add( 'Plugin ID '.$l_plugin_ID.' returned false!', 'plugins' );
				$params['plugin_ID'] = & $l_plugin_ID;
				return $params;
			}
		}
		return array();
	}


	/**
	 * Call all plugins for a given event, until the first one returns a value
	 * (not NULL) (and $search is fulfilled, if given).
	 *
	 * @param string event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array|NULL Associative array of parameters for the Plugin
	 * @param array|NULL If provided, the return value gets checks against this criteria.
	 *        Can be:
	 *         - ( 'in_array' => 'needle' )
	 * @return array The (modified) params array with key "plugin_ID" set to the last called plugin
	 *               and 'plugin_return' set to the return value;
	 *               Empty array if no Plugin returned true or no Plugin has this event registered.
	 */
	function trigger_event_first_return( $event, $params = NULL, $search = NULL )
	{
		global $Debuglog;

		$Debuglog->add( 'Trigger event '.$event.' (first return)', 'plugins' );

		if( empty($this->index_event_IDs[$event]) )
		{ // No events registered
			$Debuglog->add( 'No registered plugins.', 'plugins' );
			return array();
		}

		$Debuglog->add( 'Registered plugin IDs: '.implode( ', ', $this->index_event_IDs[$event]), 'plugins' );
		foreach( $this->index_event_IDs[$event] as $l_plugin_ID )
		{
			$r = $this->call_method( $l_plugin_ID, $event, $params );
			if( isset($r) )
			{
				if( isset($search) )
				{ // Apply $search:
					foreach( $search as $k => $v )
					{ // Check search criterias and continue if it does not match:
						switch( $k )
						{
							case 'in_array':
								if( ! in_array( $v, $r ) )
								{
									continue 3; // continue in main foreach loop
								}
								break;
							default:
								debug_die('Invalid search criteria in Plugins::trigger_event_first_return / '.$k);
						}
					}
				}
				$Debuglog->add( 'Plugin ID '.$l_plugin_ID.' returned '.( $r ? 'true' : 'false' ).'!', 'plugins' );
				$params['plugin_return'] = $r;
				$params['plugin_ID'] = & $l_plugin_ID;
				return $params;
			}
		}
		return array();
	}


	/**
	 * Trigger an event and return an index of params.
	 *
	 * This is handy to collect return values from all plugins hooking an event.
	 *
	 * @param string Event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @param string Index of $params that should get returned
	 * @return mixed The requested index of $params
	 */
	function get_trigger_event( $event, $params = NULL, $get = 'data' )
	{
		$params[$get] = & $params[$get]; // make it a reference, so it can get changed

		$this->trigger_event( $event, $params );

		return $params[$get];
	}


	/**
	 * The same as {@link get_trigger_event()}, but stop when the first Plugin returns true.
	 *
	 * @param string Event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @param string Index of $params that should get returned
	 * @return mixed The requested index of $params
	 */
	function get_trigger_event_first_true( $event, $params = NULL, $get = 'data' )
	{
		$params[$get] = & $params[$get]; // make it a reference, so it can get changed

		$this->trigger_event_first_true( $event, $params );

		return $params[$get];
	}


	/**
	 * Trigger an event and return the first return value of a plugin.
	 *
	 * @param string Event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @return mixed NULL if no Plugin returned something or the return value of the first Plugin
	 */
	function get_trigger_event_first_return( $event, $params = NULL )
	{
		$r = $this->trigger_event_first_return( $event, $params );

		if( ! isset($r['plugin_return']) )
		{
			return NULL;
		}

		return $r['plugin_return'];
	}


	/**
	 * Trigger an event and return an array of all return values of the
	 * relevant plugins.
	 *
	 * @param string Event name, see {@link Plugins_admin::get_supported_events()}
	 * @param array Associative array of parameters for the Plugin
	 * @param boolean Ignore {@link empty() empty} return values?
	 * @return array List of return values, indexed by Plugin ID
	 */
	function trigger_collect( $event, $params = NULL, $ignore_empty = true )
	{
		if( empty($this->index_event_IDs[$event]) )
		{
			return array();
		}

		$r = array();
		foreach( $this->index_event_IDs[$event] as $p_ID )
		{
			$sub_r = $this->call_method_if_active( $p_ID, $event, $params );

			if( $ignore_empty && empty($sub_r) )
			{
				continue;
			}

			$r[$p_ID] = $sub_r;
		}

		return $r;
	}


	/**
	 * Trigger a karma collecting event in order to get Karma percentage.
	 *
	 * @param string Event
	 * @param array Params to the event
	 * @return integer|NULL Spam Karma (-100 - 100); "100" means "absolutely spam"; NULL if no plugin gave us a karma value
	 */
	function trigger_karma_collect( $event, $params )
	{
		global $Debuglog;

		$karma_abs = NULL;
		$karma_divider = 0; // total of the "spam detection relevance weight"

		$Debuglog->add( 'Trigger karma collect event '.$event, 'plugins' );

		if( empty($this->index_event_IDs[$event]) )
		{ // No events registered
			$Debuglog->add( 'No registered plugins.', 'plugins' );
			return NULL;
		}

		$this->load_plugins_table(); // We need index_ID_rows below

		$Debuglog->add( 'Registered plugin IDs: '.implode( ', ', $this->index_event_IDs[$event]), 'plugins' );

		$count_plugins = 0;
		foreach( $this->index_event_IDs[$event] as $l_plugin_ID )
		{
			$plugin_weight = $this->index_ID_rows[$l_plugin_ID]['plug_spam_weight'];

			if( $plugin_weight < 1 )
			{
				$Debuglog->add( 'Skipping plugin #'.$l_plugin_ID.', because is has weight '.$plugin_weight.'.', 'plugins' );
				continue;
			}

			$params['cur_karma'] = ( $karma_divider ? round($karma_abs / $karma_divider) : NULL );
			$params['cur_karma_abs'] = $karma_abs;
			$params['cur_karma_divider'] = $karma_divider;
			$params['cur_count_plugins'] = $count_plugins;

			// Call the plugin:
			$plugin_karma = $this->call_method( $l_plugin_ID, $event, $params );

			if( ! is_numeric( $plugin_karma ) )
			{
				continue;
			}

			$count_plugins++;

			if( $plugin_karma > 100 )
			{
				$plugin_karma = 100;
			}
			elseif( $plugin_karma < -100 )
			{
				$plugin_karma = -100;
			}

			$karma_abs += ( $plugin_karma * $plugin_weight );
			$karma_divider += $plugin_weight;

			if( ! empty($this->_stop_propagation) )
			{
				$this->_stop_propagation = false;
				break;
			}
		}

		if( ! $karma_divider )
		{
			return NULL;
		}

		$karma = round($karma_abs / $karma_divider);

		if( $karma > 100 )
		{
			$karma = 100;
		}
		elseif( $karma < -100 )
		{
			$karma = -100;
		}

		return $karma;
	}


	/**
	 * Call a method on a Plugin.
	 *
	 * This makes sure that the Timer for the Plugin gets resumed.
	 *
	 * @param integer Plugin ID
	 * @param string Method name.
	 * @param array Params (by reference).
	 * @return NULL|mixed Return value of the plugin's method call or NULL if no such method.
	 */
	function call_method( $plugin_ID, $method, & $params )
	{
		global $Timer, $debug, $Debuglog;

		$Plugin = & $this->get_by_ID( $plugin_ID );

		if( ! method_exists( $Plugin, $method ) )
		{
			return NULL;
		}

		if( $debug )
		{
			/*
			// Note: this is commented out, because $debug_params gets not dumped anymore (last line of this block)
			// Hide passwords from Debuglog!
			// Clone/copy (references!):
			$debug_params = array();
			foreach( $params as $k => $v )
			{
				$debug_params[$k] = $v;
			}
			if( isset($debug_params['pass']) )
			{
				$debug_params['pass'] = '-hidden-';
			}
			if( isset($debug_params['pass_md5']) )
			{
				$debug_params['pass_md5'] = '-hidden-';
			}
			$Debuglog->add( 'Calling '.$Plugin->classname.'(#'.$Plugin->ID.')->'.$method.'( '.htmlspecialchars(var_export( $debug_params, true )).' )', 'plugins' );
			*/
			$Debuglog->add( 'Calling '.$Plugin->classname.'(#'.$Plugin->ID.')->'.$method.'( )', 'plugins' );
		}

		$Timer->resume( $Plugin->classname.'_(#'.$Plugin->ID.')' );
		$r = $Plugin->$method( $params );
		$Timer->pause( $Plugin->classname.'_(#'.$Plugin->ID.')' );

		return $r;
	}


	/**
	 * Call a method on a Plugin if it is not deactivated.
	 *
	 * This is a wrapper around {@link call_method()}.
	 *
	 * fp> why doesn't call_method always check if it's deactivated?
	 *
	 * @param integer Plugin ID
	 * @param string Method name.
	 * @param array Params (by reference).
	 * @return NULL|mixed Return value of the plugin's method call or NULL if no such method (or inactive).
	 */
	function call_method_if_active( $plugin_ID, $method, & $params )
	{
		if( ! $this->has_event($plugin_ID, $method) )
		{
			return NULL;
		}

		return $this->call_method( $plugin_ID, $method, $params );
	}


	/**
	 * Call a specific plugin by its code.
	 *
	 * This will call the {@link Plugin::SkinTag()} event handler.
	 *
	 * @param string plugin code
	 * @param array Associative array of parameters (gets passed to the plugin)
	 * @return boolean
	 */
	function call_by_code( $code, $params = array() )
	{
		$Plugin = & $this->get_by_code( $code );

		if( ! $Plugin )
		{
			global $Debuglog;
			$Debuglog->add( 'No plugin available for code ['.$code.']!', array('plugins', 'error') );
			return false;
		}

		$this->call_method_if_active( $Plugin->ID, 'SkinTag', $params );

		return true;
	}


	/**
	 * Render the content of an item by calling the relevant renderer plugins.
	 *
	 * @param string content to render (by reference)
	 * @param array renderer codes to use for opt-out, opt-in and lazy
	 * @param string Output format, see {@link format_to_output()}. Only 'htmlbody',
	 *        'entityencoded', 'xml' and 'text' are supported.
	 * @param array Additional params to the Render* methods (e.g. "Item" for items).
	 *              Do not use "data" or "format" here, because it gets used internally.
	 * @return string rendered content
	 */
	function render( & $content, $renderers, $format, $params, $event_prefix = 'Render' )
	{
		// echo implode(',',$renderers);

		$params['data'] = & $content;
		$params['format'] = $format;

		if( $format == 'htmlbody' || $format == 'entityencoded' )
		{
			$event = $event_prefix.'ItemAsHtml'; // 'RenderItemAsHtml'/'DisplayItemAsHtml'
		}
		elseif( $format == 'xml' )
		{
			$event = $event_prefix.'ItemAsXml'; // 'RenderItemAsXml'/'DisplayItemAsXml'
		}
		elseif( $format == 'text' )
		{
			$event = $event_prefix.'ItemAsText'; // 'RenderItemAsText'/'DisplayItemAsText'
		}
		else debug_die( 'Unexpected format in Plugins::render(): '.var_export($format, true) );

		$renderer_Plugins = $this->get_list_by_event( $event );

		foreach( $renderer_Plugins as $loop_RendererPlugin )
		{ // Go through whole list of renders
			// echo ' ',$loop_RendererPlugin->code, ':';

			switch( $loop_RendererPlugin->apply_rendering )
			{
				case 'stealth':
				case 'always':
					// echo 'FORCED ';
					$this->call_method( $loop_RendererPlugin->ID, $event, $params );
					break;

				case 'opt-out':
				case 'opt-in':
				case 'lazy':
					if( in_array( $loop_RendererPlugin->code, $renderers ) )
					{ // Option is activated
						// echo 'OPT ';
						$this->call_method( $loop_RendererPlugin->ID, $event, $params );
					}
					// else echo 'NOOPT ';
					break;

				case 'never':
					// echo 'NEVER ';
					break;	// STOP, don't render, go to next renderer
			}
		}

		return $content;
	}


	/**
	 * Quick-render a string with a single plugin and format it for output.
	 *
	 * @todo rename
	 *
	 * @param string Plugin code (must have render() method)
	 * @param array
	 *   'data': Data to render
	 *   'format: format to output, see {@link format_to_output()}
	 * @return string Rendered string
	 */
	function quick( $plugin_code, $params )
	{
		global $Debuglog;

		if( !is_array($params) )
		{
			$params = array( 'format' => 'htmlbody', 'data' => $params );
		}
		else
		{
			$params = $params; // copy
		}

		$Plugin = & $this->get_by_code( $plugin_code );
		if( $Plugin )
		{
			// Get the most appropriate handler:
			$events = $this->get_enabled_events( $Plugin->ID );
			$event = false;
			if( $params['format'] == 'htmlbody' || $params['format'] == 'htmlentityencoded' )
			{
				if( in_array( 'RenderItemAsHtml', $events ) )
				{
					$event = 'RenderItemAsHtml';
				}
			}
			elseif( $params['format'] == 'xml' )
			{
				if( in_array( 'RenderItemAsXml', $events ) )
				{
					$event = 'RenderItemAsXml';
				}
			}

			if( $event )
			{
				$this->call_method( $Plugin->ID, $event, $params );
			}
			else
			{
				$Debuglog->add( $Plugin->classname.'(ID '.$Plugin->ID.'): failed to quick-render (tried method '.$event.')!', array( 'plugins', 'error' ) );
			}
			return format_to_output( $params['data'], $params['format'] );
		}
		else
		{
			$Debuglog->add( 'Plugins::quick() - failed to instantiate Plugin by code ['.$plugin_code.']!', array( 'plugins', 'error' ) );
			return format_to_output( $params['data'], $params['format'] );
		}
	}


	/**
	 * Load Plugins data from T_plugins (only once), ordered by priority.
	 *
	 * This fills the needed indexes to lazy-instantiate a Plugin when requested.
	 */
	function load_plugins_table()
	{
		if( $this->loaded_plugins_table )
		{
			return;
		}
		global $Debuglog, $DB;

		$Debuglog->add( 'Loading plugins table data.', 'plugins' );

		$this->index_ID_rows = array();
		$this->index_code_ID = array();
		$this->index_apply_rendering_codes = array();
		$this->sorted_IDs = array();

		foreach( $DB->get_results( $this->sql_load_plugins_table, ARRAY_A ) as $row )
		{ // Loop through installed plugins:
			$this->index_ID_rows[$row['plug_ID']] = $row; // remember the rows to instantiate the Plugin on request
			if( ! empty( $row['plug_code'] ) )
			{
				$this->index_code_ID[$row['plug_code']] = $row['plug_ID'];
			}
			$this->index_apply_rendering_codes[$row['plug_apply_rendering']][] = $row['plug_code'];

			$this->sorted_IDs[] = $row['plug_ID'];
		}

		$this->loaded_plugins_table = true;
	}


	/**
	 * Get a specific plugin by its ID.
	 *
	 * This is the workhorse when it comes to lazy-instantiating a Plugin.
	 *
	 * @param integer plugin ID
	 * @return Plugin (false in case of error)
	 */
	function & get_by_ID( $plugin_ID )
	{
		global $Debuglog;

		if( ! isset($this->index_ID_Plugins[ $plugin_ID ]) )
		{ // Plugin is not instantiated yet
			$Debuglog->add( 'get_by_ID(): Instantiate Plugin (ID '.$plugin_ID.').', 'plugins' );

			$this->load_plugins_table();

			#pre_dump( 'get_by_ID(), index_ID_rows', $this->index_ID_rows );

			if( ! isset( $this->index_ID_rows[$plugin_ID] ) || ! $this->index_ID_rows[$plugin_ID] )
			{ // no plugin rows cached
				#debug_die( 'Cannot instantiate Plugin (ID '.$plugin_ID.') without DB information.' );
				$Debuglog->add( 'get_by_ID(): Plugin (ID '.$plugin_ID.') not registered/enabled in DB!', array( 'plugins', 'error' ) );
				$r = false;
				return $r;
			}

			$row = & $this->index_ID_rows[$plugin_ID];

			// Register the plugin:
			$Plugin = & $this->register( $row['plug_classname'], $row['plug_ID'], $row['plug_priority'], $row['plug_apply_rendering'] );

			if( is_string( $Plugin ) )
			{
				$Debuglog->add( 'Requested plugin [#'.$plugin_ID.'] not found!', 'plugins' );
				$r = false;
				return $r;
			}

			$this->index_ID_Plugins[ $plugin_ID ] = & $Plugin;
		}

		return $this->index_ID_Plugins[ $plugin_ID ];
	}


	/**
	 * Get a plugin by its classname.
	 *
	 * @param string
	 * @return Plugin (false in case of error)
	 */
	function & get_by_classname( $classname )
	{
		$this->load_plugins_table(); // We use index_ID_rows (no own index yet)

		foreach( $this->index_ID_rows as $plug_ID => $row )
		{
			if( $row['plug_classname'] == $classname )
			{
				return $this->get_by_ID($plug_ID);
			}
		}

		$r = false;
		return $r;
	}


	/**
	 * Get a specific Plugin by its code.
	 *
	 * @param string plugin code
	 * @return Plugin (false in case of error)
	 */
	function & get_by_code( $plugin_code )
	{
		global $Debuglog;

		$r = false;

		if( ! isset($this->index_code_Plugins[ $plugin_code ]) )
		{ // Plugin is not registered yet
			$this->load_plugins_table();

			if( ! isset($this->index_code_ID[ $plugin_code ]) )
			{
				$Debuglog->add( 'Requested plugin ['.$plugin_code.'] is not registered/enabled!', 'plugins' );
				return $r;
			}

			if( ! $this->get_by_ID( $this->index_code_ID[$plugin_code] ) )
			{
				$Debuglog->add( 'Requested plugin ['.$plugin_code.'] could not get instantiated!', 'plugins' );
				return $r;
			}
		}

		return $this->index_code_Plugins[ $plugin_code ];
	}


	/**
	 * Get a list of Plugins for a given event.
	 *
	 * @param string Event name
	 * @return array plugin_ID => & Plugin
	 */
	function get_list_by_event( $event )
	{
		$r = array();

		if( isset($this->index_event_IDs[$event]) )
		{
			foreach( $this->index_event_IDs[$event] as $l_plugin_ID )
			{
				if( $Plugin = & $this->get_by_ID( $l_plugin_ID ) )
				{
					$r[ $l_plugin_ID ] = & $Plugin;
					unset($Plugin); // so that we do not overwrite the reference in the next loop
				}
			}
		}

		return $r;
	}


	/**
	 * Get a list of Plugins for a list of events. Every Plugin is only once in this list.
	 *
	 * @param array Array of events
	 * @return array plugin_ID => & Plugin
	 */
	function get_list_by_events( $events )
	{
		$r = array();

		foreach( $events as $l_event )
		{
			foreach( array_keys($this->get_list_by_event( $l_event )) as $l_plugin_ID )
			{
				if( $Plugin = & $this->get_by_ID( $l_plugin_ID ) )
				{
					$r[ $l_plugin_ID ] = & $Plugin;
					unset($Plugin); // so that we do not overwrite the reference in the next loop
				}
			}
		}

		return $r;
	}


	/**
	 * Get a list of plugins that provide all given events.
	 *
	 * @return array plugin_ID => & Plugin
	 */
	function get_list_by_all_events( $events )
	{
		$candidates = array();

		foreach( $events as $l_event )
		{
			if( empty($this->index_event_IDs[$l_event]) )
			{
				return array();
			}

			if( empty($candidates) )
			{
				$candidates = $this->index_event_IDs[$l_event];
			}
			else
			{
				$candidates = array_intersect( $candidates, $this->index_event_IDs[$l_event] );
				if( empty($candidates) )
				{
					return array();
				}
			}
		}

		$r = array();
		foreach( $candidates as $plugin_ID )
		{
			$Plugin = & $this->get_by_ID( $plugin_ID );
			if( $Plugin )
			{
				$r[ $plugin_ID ] = & $Plugin;
				unset($Plugin); // so that we do not overwrite the reference in the next loop
			}
		}

		return $r;
	}


	/**
	 * Get a list of (enabled) events for a given Plugin ID.
	 *
	 * @param integer Plugin ID
	 * @return array
	 */
	function get_enabled_events( $plugin_ID )
	{
		$r = array();
		foreach( $this->index_event_IDs as $l_event => $l_plugin_IDs )
		{
			if( in_array( $plugin_ID, $l_plugin_IDs ) )
			{
				$r[] = $l_event;
			}
		}
		return $r;
	}


	/**
	 * Has a plugin a specific event registered/enabled?
	 *
	 * @todo fp> The plugin should discover its events itself / This question should be asked to the Plugin itself.
	 *
	 * @param integer
	 * @param string
	 * @return boolean
	 */
	function has_event( $plugin_ID, $event )
	{
		return isset($this->index_event_IDs[$event])
			&& in_array( $plugin_ID, $this->index_event_IDs[$event] );
	}


	/**
	 * Check if the requested list of events is provided by any or one plugin.
	 *
	 * @param array|string A single event or a list thereof
	 * @param boolean Make sure there's at least one plugin that provides them all?
	 *                This is useful for event pairs like "CaptchaPayload" and "CaptchaValidated", which
	 *                should be served by the same plugin.
	 * @return boolean
	 */
	function are_events_available( $events, $require_all_in_same_plugin = false )
	{
		if( ! is_array($events) )
		{
			$events = array($events);
		}

		if( $require_all_in_same_plugin )
		{
			return (bool)$this->get_list_by_all_events( $events );
		}

		return (bool)$this->get_list_by_events( $events );
	}


	/**
	 * (Re)load Plugin Events for enabled (normal use) or all (admin use) plugins.
	 */
	function load_events()
	{
		global $Debuglog, $DB;

		$this->index_event_IDs = array();

		$Debuglog->add( 'Loading plugin events.', 'plugins' );
		foreach( $DB->get_results( '
				SELECT pevt_plug_ID, pevt_event
					FROM T_pluginevents INNER JOIN T_plugins ON pevt_plug_ID = plug_ID
				 WHERE pevt_enabled > 0
				   AND plug_status = \'enabled\'
				 ORDER BY plug_priority, plug_classname', OBJECT, 'Loading plugin events' ) as $l_row )
		{
			$this->index_event_IDs[$l_row->pevt_event][] = $l_row->pevt_plug_ID;
		}
	}


	/**
	 * Load an object from a Cache plugin or create a new one if we have a
	 * cache miss or no caching plugins.
	 *
	 * It registers a shutdown function, that refreshes the data to the cache plugin
	 * which is not optimal, but we have no hook to see if data retrieved from
	 * a {@link DataObjectCache} derived class has changed.
	 * @param string object name
	 * @param string eval this to create the object. Default is to create an object
	 *               of class $objectName.
	 * @return boolean True, if retrieved from cache; false if not
	 */
	function get_object_from_cacheplugin_or_create( $objectName, $eval_create_object = NULL )
	{
		$get_return = $this->trigger_event_first_true( 'CacheObjects',
			array( 'action' => 'get', 'key' => 'object_'.$objectName ) );

		if( isset( $get_return['plugin_ID'] ) )
		{
			if( is_object($get_return['data']) )
			{
				$GLOBALS[$objectName] = $get_return['data']; // COPY! (get_Cache() uses $$objectName instead of $GLOBALS - no deal for PHP5 anyway)

				$Plugin = & $this->get_by_ID( $get_return['plugin_ID'] );
				register_shutdown_function( array(&$Plugin, 'CacheObjects'),
					array( 'action' => 'set', 'key' => 'object_'.$objectName, 'data' => & $GLOBALS[$objectName] ) );

				return true;
			}
		}

		// Cache miss, create it:
		if( empty($eval_create_object) )
		{
			$GLOBALS[$objectName] = new $objectName(); // COPY (FUNC)
		}
		else
		{
			eval( '$GLOBALS[\''.$objectName.'\'] = '.$eval_create_object.';' );
		}

		// Try to set in cache:
		$set_return = $this->trigger_event_first_true( 'CacheObjects',
			array( 'action' => 'set', 'key' => 'object_'.$objectName, 'data' => & $GLOBALS[$objectName] ) );

		if( isset( $set_return['plugin_ID'] ) )
		{ // success, register a shutdown function to save this data on shutdown
			$Plugin = & $this->get_by_ID( $set_return['plugin_ID'] );
			register_shutdown_function( array(&$Plugin, 'CacheObjects'),
				array( 'action' => 'set', 'key' => 'object_'.$objectName, 'data' => & $GLOBALS[$objectName] ) );
		}

		return false;
	}


	/**
	 * Callback, which gets used for {@link Results}.
	 *
	 * @return Plugin (false in case of error)
	 */
	function & instantiate( $row )
	{
		return $this->get_by_ID( $row->plug_ID );
	}


	// Deprecated stubs: {{{

	/**
	 * @deprecated since EVO_NEXT_VERSION by Plugins_admin::count_regs()
	 */
	function count_regs( $classname )
	{
		global $Debuglog;
		$Debuglog->add('Call to deprecated method Plugins::count_regs()', 'deprecated');
		$Plugins_admin = & get_Cache('Plugins_admin');
		return $Plugins_admin->count_regs($classname);
	}


	/**
	 * Set the apply_rendering value for a given Plugin ID.
	 *
	 * It makes sure that the index is handled and writes it to DB.
	 *
	 * @deprecated since EVO_NEXT_VERSION by Plugins_admin::set_apply_rendering()
	 * @return boolean true if set to new value, false in case of error or if already set to same value
	 */
	function set_apply_rendering( $plugin_ID, $apply_rendering )
	{
		$Plugins_admin = & get_Cache('Plugins_admin');
		return $Plugins_admin->set_apply_rendering($plugin_ID, $apply_rendering);
	}


	/**
	 * Validate renderer list.
	 *
	 * @deprecated since EVO_NEXT_VERSION by Plugins_admin::validate_renderer_list()
	 * @param array renderer codes ('default' will include all "opt-out"-ones)
	 * @return array validated array of renderer codes
	 */
	function validate_list( $renderers = array('default') )
	{
		global $Debuglog;
		$Debuglog->add('Call to deprecated method Plugins::validate_list()', 'deprecated');
		$Plugins_admin = & get_Cache('Plugins_admin');
		return $Plugins_admin->validate_renderer_list($renderers);
	}


	// }}}
}



?>