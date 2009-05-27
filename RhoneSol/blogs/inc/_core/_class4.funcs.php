<?php
/**
 * Function for handling Classes in PHP 4.
 *
 * Note: in PHP 5, another file should be included. It shoudl handle clone for example.
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
 * @package evocore
 *
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _class4.funcs.php,v 1.5 2008/01/21 09:35:23 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * Load class file
 */
function load_class( $class_path, $require = true )
{
	global $inc_path;
	if( ! $require && ! file_exists( $inc_path.$class_path ) )
	{
		return false;
	}
	require_once $inc_path.$class_path;
	return true;
}


/**
 * Load functions file
 */
function load_funcs( $funcs_path )
{
	global $inc_path;
	require_once $inc_path.$funcs_path;
}


/**
 * @todo fp> split into 1 function per case. (typed @return values)
 *
 * @return DataObjectCache
 */
function & get_Cache( $objectName )
{
	global $Plugins;
	global $$objectName;

	if( isset( $$objectName ) )
	{	// Cache already exists:
		return $$objectName;
	}

	switch( $objectName )
	{
		case 'BlogCache':
			load_class( 'collections/model/_blogcache.class.php' );
			$BlogCache = new BlogCache(); // COPY (FUNC)
			return $BlogCache;

		case 'ChapterCache':
			load_class( 'chapters/model/_chaptercache.class.php' );
			$ChapterCache = new ChapterCache(); // COPY (FUNC)
			return $ChapterCache;

		case 'FileCache':
			load_class( 'files/model/_filecache.class.php' );
			$FileCache = new FileCache(); // COPY (FUNC)
			return $FileCache;

		case 'FileRootCache':
			load_class( 'files/model/_filerootcache.class.php' );
			$Plugins->get_object_from_cacheplugin_or_create( 'FileRootCache' );
			return $FileRootCache;

		case 'FiletypeCache':
			load_class( 'files/model/_filetypecache.class.php' );
			$Plugins->get_object_from_cacheplugin_or_create( 'FiletypeCache' );
			return $FiletypeCache;

		case 'GroupCache':
			$Plugins->get_object_from_cacheplugin_or_create( 'GroupCache', 'new DataObjectCache( \'Group\', true, \'T_groups\', \'grp_\', \'grp_ID\', \'grp_name\', \'\', T_(\'No group\') )' );
			return $GroupCache;

		case 'ItemCacheLight';
			$ItemCacheLight = new DataObjectCache( 'ItemLight', false, 'T_items__item', 'post_', 'post_ID' ); // COPY (FUNC)
			return $ItemCacheLight;

		case 'ItemCache';
			load_class( 'items/model/_itemcache.class.php' );
			$ItemCache = new ItemCache(); // COPY (FUNC)
			return $ItemCache;

		case 'ItemStatusCache':
			$Plugins->get_object_from_cacheplugin_or_create( 'ItemStatusCache', 'new GenericCache( \'GenericElement\', true, \'T_items__status\', \'pst_\', \'pst_ID\', NULL, \'\', T_(\'No status\') )' );
			return $ItemStatusCache;

		case 'ItemTypeCache':
			load_class( 'items/model/_itemtypecache.class.php' );
			$Plugins->get_object_from_cacheplugin_or_create( 'ItemTypeCache', 'new ItemTypeCache( \'ptyp_\', \'ptyp_ID\' )' );
			return $ItemTypeCache;

		case 'LinkCache':
			load_class( 'items/model/_linkcache.class.php' );
			$LinkCache = new LinkCache(); // COPY (FUNC)
			return $LinkCache;

		case 'Plugins_admin':
			load_class('plugins/model/_plugins_admin.class.php');
			$Plugins_admin = new Plugins_admin(); // COPY (FUNC)
			return $Plugins_admin;

		case 'SkinCache':
			load_class( 'skins/model/_skincache.class.php' );
			$SkinCache = new SkinCache(); // COPY (FUNC)
			return $SkinCache;

		case 'UserCache':
			load_class( 'users/model/_usercache.class.php' );
			$UserCache = new UserCache(); // COPY (FUNC)
			return $UserCache;

		case 'WidgetCache':
			load_class( 'widgets/model/_widgetcache.class.php' );
			$WidgetCache = new WidgetCache(); // COPY (FUNC)
			return $WidgetCache;

		default:
			debug_die( 'getCache(): Unknown Cache type:'.$objectName );
	}
}


?>