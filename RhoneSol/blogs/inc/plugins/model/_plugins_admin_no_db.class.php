<?php
/**
 * This file implements the {@link Plugins_admin_no_DB} class, which gets used for administrative
 * handling of the {@link Plugin Plugins}, but without database.
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2006 by Daniel HAHLER - {@link http://daniel.hahler.de/}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * {@internal Open Source relicensing agreement:
 * Daniel HAHLER grants Francois PLANQUE the right to license
 * Daniel HAHLER's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package evocore
 *
 * @author blueyed: Daniel HAHLER
 *
 * @version $Id: _plugins_admin_no_db.class.php,v 1.2 2008/01/21 09:35:32 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


load_class('plugins/model/_plugins_admin.class.php');


/**
 * A sub-class of {@link Plugins_admin} which will not load any DB info (i-e: Plugins and Events).
 *
 * This is useful for displaying a list of available plugins which can be installed.
 * This is also useful during installation in order to have a global $Plugins object that does not interfere with the installation process.
 *
 * {@internal This is probably quicker and cleaner than using a member boolean in {@link Plugins_admin} itself.}}
 *
 * @package plugins
 */
class Plugins_admin_no_DB extends Plugins_admin
{
	/**
	 * No-operation.
	 */
	function load_plugins_table()
	{
	}

	/**
	 * No-operation.
	 */
	function load_events()
	{
	}
}



?>