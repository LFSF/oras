<?php
/**
 * This file implements the DataObjectCache class.
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 * Parts of this file are copyright (c)2004-2006 by Daniel HAHLER - {@link http://thequod.de/contact}.
 * Parts of this file are copyright (c)2005-2006 by PROGIDISTRI - {@link http://progidistri.com/}.
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
 *
 * PROGIDISTRI S.A.S. grants Francois PLANQUE the right to license
 * PROGIDISTRI S.A.S.'s contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _dataobjectcache.class.php,v 1.2 2008/01/21 09:35:24 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * Data Object Cache Class
 *
 * @todo dh> Provide iteration "interface"!
 *
 * @package evocore
 * @version beta
 */
class DataObjectCache
{
	var $dbtablename;
	var $dbprefix;
	var $dbIDname;

	/**
	 * Class name of objects in this cache:
	 */
	var $objtype;

	/**
	 * Object array by ID
	 */
	var $cache = array();

	/**
	 * Copy of previous object array
	 * @see DataObjectCache::clear()
	 */
	var $shadow_cache = NULL;

	/**
	 * NON indexed object array
	 * @var array of DataObjects
	 */
	var $DataObject_array = array();

  /**
	 * Index of current iteration
	 * @see DataObjectCache::get_next()
	 */
	var $current_idx = NULL;

	var $load_all = false;
	var $all_loaded = false;


	var $name_field;
	var $order_by;

	/**
	 * The text that gets used for the "None" option in the objects options list.
	 *
	 * This is especially useful for i18n, because there are several "None"s!
	 *
	 * @var string
	 */
	var $none_option_text;


	/**
	 * Constructor
	 *
	 * @param string Name of DataObject class we are cacheing
	 * @param boolean true if it's OK to just load all items!
	 * @param string Name of table in database
	 * @param string Prefix of fields in the table
	 * @param string Name of the ID field (including prefix)
	 * @param string Name of the name field (including prefix)
	 * @param string field names or NULL to use name field
	 * @param string The text that gets used for the "None" option in the objects options list (Default: T_('None')).
	 */
	function DataObjectCache( $objtype, $load_all, $tablename, $prefix = '', $dbIDname, $name_field = NULL, $order_by = '', $allow_none_text = NULL )
	{
		$this->objtype = $objtype;
		$this->load_all = $load_all;
		$this->dbtablename = $tablename;
		$this->dbprefix = $prefix;
		$this->dbIDname = $dbIDname;
		$this->name_field = $name_field;

		if( empty( $order_by ) )
		{
			if( empty( $name_field ) )
			{
				$this->order_by = $dbIDname;
			}
			else
			{
				$this->order_by = $name_field;
			}
		}
		else
		{
			$this->order_by = $order_by;
		}

		if( isset($allow_none_text) )
		{
			$this->none_option_text = $allow_none_text;
		}
		else
		{
			$this->none_option_text = /* TRANS: the default value for option lists where "None" is allowed */ T_('None');
		}
	}


	/**
	 * Instanciate a new object within this cache
	 */
	function & new_obj( $row = NULL )
	{
		$objtype = $this->objtype;

		// Instantiate a custom object
		$obj = new $objtype( $row ); // COPY !!

		return $obj;
	}


	/**
	 * Load the cache **extensively**
	 */
	function load_all()
	{
		/**
		 * @var DB
		 */
		global $DB;
		global $Debuglog;

		if( $this->all_loaded )
		{ // Already loaded
			return false;
		}

		$this->clear( true );

		$Debuglog->add( get_class($this).' - Loading <strong>'.$this->objtype.'(ALL)</strong> into cache', 'dataobjects' );
		$sql = 'SELECT *
							FROM '.$this->dbtablename.'
						 ORDER BY '.$this->order_by;

		foreach( $DB->get_results( $sql, OBJECT, 'Loading '.$this->objtype.'(ALL) into cache' ) as $row )
		{
			// Instantiate a custom object
			$this->instantiate( $row );
		}

		$this->all_loaded = true;

		return true;
	}


	/**
	 * Load a list of objects into the cache
	 *
	 * @param string list of IDs of objects to load
	 */
	function load_list( $req_list )
	{
		global $DB, $Debuglog;

		$Debuglog->add( "Loading <strong>$this->objtype($req_list)</strong> into cache", 'dataobjects' );

		if( empty( $req_list ) )
		{
			return false;
		}

		$sql = "SELECT *
		          FROM $this->dbtablename
		         WHERE $this->dbIDname IN ($req_list)";

		foreach( $DB->get_results( $sql ) as $row )
		{
			// Instantiate a custom object
			$this->instantiate( $row );
		}
	}


	/**
	 * Get an array of all (loaded) IDs.
	 *
	 * @return array
	 */
	function get_ID_array()
	{
		$IDs = array();

		foreach( $this->cache as $obj )
		{
			$IDs[] = $obj->ID;
		}

		return $IDs;
	}


	/**
	 * Add a dataobject to the cache
	 */
	function add( & $Obj )
	{
		global $Debuglog;

		if( is_null($Obj->ID) )	// value 0 is used by item preview
		{
			$Debuglog->add( 'No object to add!', 'dataobjects' );
			return false;
		}

		// fplanque: I don't want an extra (and expensive) comparison here. $this->cache[$Obj->ID] === $Obj.
		// If you need this you're probably misusing the cache.
		if( isset($this->cache[$Obj->ID]) )
		{
			$Debuglog->add( $this->objtype.': Object with ID '.$Obj->ID.' is already cached', 'dataobjects' );
			return false;
		}

		// If the object is valid and not already cached:
		// Add object to cache:
		$this->cache[$Obj->ID] = & $Obj;
		// Add a reference in the object list:
		$this->DataObject_array[] = & $Obj;

		return true;
	}


	/**
	 * Instantiate a DataObject from a table row and then cache it.
	 *
	 * @param Object Database row
	 * @return Object
	 */
	function & instantiate( & $db_row )
	{
		// Get ID of the object we'ere preparing to instantiate...
		$obj_ID = $db_row->{$this->dbIDname};

		if( is_null($obj_ID) )	// value 0 is used for item preview
		{
			$Obj = NULL;
			return $Obj;
		}

		if( isset( $this->cache[$obj_ID] ) )
		{ // Already in cache, do nothing!
		}
		elseif( isset( $this->shadow_cache[$obj_ID] ) )
		{	// Already in shadow, recycle object:
			// echo "adding shadow {$this->objtype} $obj_ID ";
			$this->add( $this->shadow_cache[$obj_ID] );
		}
		else
		{ // Not already cached, add new object:
			// echo "adding new {$this->objtype} $obj_ID ";
			$this->add( $this->new_obj( $db_row ) );
		}

		return $this->cache[$obj_ID];
	}


	/**
	 * Clear the cache **extensively**
	 *
	 */
	function clear( $keep_shadow = false )
	{
		if( $keep_shadow )
		{	// Keep copy of cache in case we try to re instantiate previous object:
			$this->shadow_cache = $this->cache;
		}
		else
		{
			$this->shadow_cache = NULL;
		}

		$this->cache = array();
		$this->DataObject_array = array();
		$this->all_loaded = false;
		$this->current_idx = NULL;
	}


  /**
	 * This provides a simple interface for looping over the contents of the Cache.
	 *
	 * This should only be used for basic enumeration.
	 * If you need complex filtering of the cache contents, you should probablt use a DataObjectList instead.
	 *
	 * @see DataObject::get_next()
	 *
	 * @return DataObject
	 */
	function & get_first()
	{
		$this->load_all();

		$this->current_idx = -1;
		return $this->get_next();
	}


  /**
	 * This provides a simple interface for looping over the contents of the Cache.
	 *
	 * This should only be used for basic enumeration.
	 * If you need complex filtering of the cache contents, you should probablt use a DataObjectList instead.
	 *
	 * @see DataObject::get_first()
	 *
	 * @return DataObject
	 */
	function & get_next()
	{
		$this->current_idx++;
		// echo 'getting idx:'.$this->current_idx;

		if( ! isset( $this->DataObject_array[$this->current_idx] ) )
		{
			$this->current_idx = NULL;
			$r = NULL;
			return $r;
		}

		return $this->DataObject_array[$this->current_idx];
	}


	/**
	 * Get an object from cache by ID
	 *
	 * Load the cache if necessary (all at once if allowed).
	 *
	 * @param integer ID of object to load
	 * @param boolean true if function should die on error
	 * @param boolean true if function should die on empty/null
	 * @return DataObject reference on cached object
	 */
	function & get_by_ID( $req_ID, $halt_on_error = true, $halt_on_empty = true )
	{
		global $DB, $Debuglog;

		if( empty($req_ID) )
		{
			if($halt_on_empty)
			{
				debug_die( "Requested $this->objtype from $this->dbtablename without ID!" );
			}
			$r = NULL;
			return $r;
		}

		if( !empty( $this->cache[ $req_ID ] ) )
		{ // Already in cache
			// $Debuglog->add( "Accessing $this->objtype($req_ID) from cache", 'dataobjects' );
			return $this->cache[ $req_ID ];
		}
		elseif( !$this->all_loaded )
		{ // Not in cache, but not everything is loaded yet
			if( $this->load_all )
			{ // It's ok to just load everything:
				$this->load_all();
			}
			else
			{ // Load just the requested object:
				$Debuglog->add( "Loading <strong>$this->objtype($req_ID)</strong> into cache", 'dataobjects' );
				// Note: $req_ID MUST be an unsigned integer. This is how DataObject works.
				$sql = "SELECT *
				          FROM $this->dbtablename
				         WHERE $this->dbIDname = $req_ID";
				if( $row = $DB->get_row( $sql, OBJECT, 0, 'DataObjectCache::get_by_ID()' ) )
				{
					if( ! $this->instantiate( $row ) )
					{
						$Debuglog->add( 'Could not add() object to cache!', 'dataobjects' );
					}
				}
				else
				{
					$Debuglog->add( 'Could not get DataObject by ID. Query: '.$sql, 'dataobjects' );
				}
			}
		}

		if( empty( $this->cache[ $req_ID ] ) )
		{ // Requested object does not exist
			// $Debuglog->add( 'failure', 'dataobjects' );
			if( $halt_on_error )
			{
				debug_die( "Requested $this->objtype does not exist!" );
			}
			$r = false;
			return $r;
		}

		return $this->cache[ $req_ID ];
	}


	/**
	 * Get an object from cache by name
	 *
	 * Load the cache if necessary (all at once if allowed).
	 *
	 * @param integer ID of object to load
	 * @param boolean true if function should die on error
	 * @param boolean true if function should die on empty/null
	 * @return reference on cached object
	 */
	function & get_by_name( $req_name, $halt_on_error = true, $halt_on_empty = true )
	{
		global $DB, $Debuglog;

		if( empty( $this->name_field ) )
		{
			debug_die( 'DataObjectCache::get_by_name() : No name field to query on' );
		}

		if( empty($req_name) )
		{
			if($halt_on_empty) { debug_die( "Requested $this->objtype from $this->dbtablename without name!" ); }
			$r = NULL;
			return $r;
		}

		// Load just the requested object:
		$Debuglog->add( "Loading <strong>$this->objtype($req_name)</strong>", 'dataobjects' );
		$sql = "SELECT *
						  FROM $this->dbtablename
						 WHERE $this->name_field = ".$DB->quote($req_name);

		if( $db_row = $DB->get_row( $sql, OBJECT, 0, 'DataObjectCache::get_by_name()' ) )
		{
			$resolved_ID = $db_row->{$this->dbIDname};
			$Debuglog->add( 'success; ID = '.$resolved_ID, 'dataobjects' );
			if( ! isset( $this->cache[$resolved_ID] ) )
			{	// Object is not already in cache:
				$Debuglog->add( 'Adding to cache...', 'dataobjects' );
				//$Obj = new $this->objtype( $row ); // COPY !!
				//if( ! $this->add( $this->new_obj( $db_row ) ) )
				if( ! $this->add( $this->new_obj( $db_row ) ) )
				{	// could not add
					$Debuglog->add( 'Could not add() object to cache!', 'dataobjects' );
				}
			}
			return $this->cache[$resolved_ID];
		}
		else
		{
			$Debuglog->add( 'Could not get DataObject by name.', 'dataobjects' );
			if( $halt_on_error )
			{
				debug_die( "Requested $this->objtype does not exist!" );
			}
			$r = NULL;
			return $r;
		}
	}


	/**
	 * Remove an object from cache by ID
	 *
	 * @param integer ID of object to remove
	 */
	function remove_by_ID( $req_ID )
	{
		unset( $this->cache[$req_ID] );
	}


	/**
	 * Delete an object from DB by ID.
	 *
	 * @param integer ID of object to delete
	 * @return boolean
	 */
	function dbdelete_by_ID( $req_ID )
	{
		if( isset( $this->cache[$req_ID] ) )
		{
			// Delete from db
			$this->cache[$req_ID]->dbdelete();

			// Remove from cache
			$this->remove_by_ID( $req_ID );

			return true;
		}
		else
		{
			return false;
		}
	}


	/**
	 * Returns form option list with cache contents
	 *
	 * Load the cache if necessary
	 *
	 * @param integer selected ID
	 * @param boolean provide a choice for "none" with ID ''
	 * @param string Callback method name
	 * @return string
	 */
	function get_option_list( $default = 0, $allow_none = false, $method = 'get_name' )
	{
		if( (! $this->all_loaded) && $this->load_all )
		{ // We have not loaded all items so far, but we're allowed to... so let's go:
			$this->load_all();
		}

		$r = '';

		if( $allow_none )
		{
			$r .= '<option value=""';
			if( empty($default) ) $r .= ' selected="selected"';
			$r .= '>'.format_to_output($this->none_option_text).'</option>'."\n";
		}

		foreach( $this->cache as $loop_Obj )
		{
			$r .=  '<option value="'.$loop_Obj->ID.'"';
			if( $loop_Obj->ID == $default ) $r .= ' selected="selected"';
			$r .= '>';
			$r .= format_to_output( $loop_Obj->$method(), 'htmlbody' );
			$r .=  '</option>'."\n";
		}

		return $r;
	}

}



?>