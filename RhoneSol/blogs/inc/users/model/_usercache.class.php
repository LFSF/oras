<?php
/**
 * This file implements the UserCache class.
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
 * @author fplanque: Francois PLANQUE
 * @author blueyed: Daniel HAHLER
 *
 * @version $Id: _usercache.class.php,v 1.2 2008/01/21 09:35:36 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('_core/model/dataobjects/_dataobjectcache.class.php');

/**
 * Blog Cache Class
 *
 * @package evocore
 */
class UserCache extends DataObjectCache
{
	/**
	 * Cache for login -> User object reference. "login" is transformed to lowercase.
	 * @access private
	 * @var array
	 */
	var $cache_login = array();


	/**
	 * Remember special cache loads.
	 * @access protected
	 */
	var $alreadyCached = array();


	/**
	 * Constructor
	 */
	function UserCache()
	{
		parent::DataObjectCache( 'User', false, 'T_users', 'user_', 'user_ID', NULL, '',
			/* TRANS: "None" select option */ T_('No user') );
	}

	/* this is for debugging only:
	function & get_by_ID( $req_ID, $halt_on_error = true )
	{
		$obj = parent::get_by_ID( $req_ID, $halt_on_error );
			pre_dump($obj);
		return $obj;
	}
	*/


	/**
	 * Get a user object by login.
	 *
	 * Does not halt on error.
	 *
	 * @return false|User Reference to the user object or false if not found
	 */
	function & get_by_login( $login )
	{
		// Make sure we have a lowercase login:
		// We want all logins to be lowercase to guarantee uniqueness regardless of the database case handling for UNIQUE indexes.
		$login = strtolower( $login );

		if( !isset( $this->cache_login[$login] ) )
		{
			global $DB;

			if( $row = $DB->get_row( "
					SELECT *
					  FROM T_users
					 WHERE user_login = '".$DB->escape($login)."'", 0, 0, 'Get User login' ) )
			{
				$this->add( new User( $row ) );
			}
			else
			{
				$this->cache_login[$login] = false;
			}
		}

		return $this->cache_login[$login];
	}


	/**
	 * Get a user object by login, only if password matches.
	 *
	 * @param string Login
	 * @param string Password
	 * @param boolean Password is MD5()'ed
	 * @return false|User
	 */
	function & get_by_loginAndPwd( $login, $pass, $pass_is_md5 = true )
	{
		if( !($User =& $this->get_by_login( $login )) )
		{
			return false;
		}

		if( !$pass_is_md5 )
		{
			$pass = md5($pass);
		}

		if( $User->pass != $pass )
		{
			return false;
		}

		return $User;
	}


	/**
	 * Overload parent's function to also maintain the login cache.
	 *
	 * @param User
	 * @return boolean
	 */
	function add( & $Obj )
	{
		if( parent::add( $Obj ) )
		{
			$this->cache_login[ strtolower($Obj->login) ] = & $Obj;

			return true;
		}

		return false;
	}


	/**
	 * Load members of a given blog
	 *
	 * @todo make a UNION query when we upgrade to MySQL 4
	 * @param integer blog ID to load members for
	 */
	function load_blogmembers( $blog_ID )
	{
		global $DB, $Debuglog;

		if( isset( $this->alreadyCached['blogmembers'] ) && isset( $this->alreadyCached['blogmembers'][$blog_ID] ) )
		{
			$Debuglog->add( "Already loaded <strong>$this->objtype(Blog #$blog_ID members)</strong> into cache", 'dataobjects' );
			return false;
		}

		// Remember this special load:
		$this->alreadyCached['blogmembers'][$blog_ID] = true;

		$Debuglog->add( "Loading <strong>$this->objtype(Blog #$blog_ID members)</strong> into cache", 'dataobjects' );

		// User perms:
		$sql = 'SELECT T_users.*
					    FROM T_users INNER JOIN T_coll_user_perms ON user_ID = bloguser_user_ID
				     WHERE bloguser_blog_ID = '.$blog_ID.'
					     AND bloguser_ismember <> 0';
		foreach( $DB->get_results( $sql ) as $row )
		{
			if( !isset($this->cache[$row->user_ID]) )
			{	// Save reinstatiating User if it's already been added
				$this->add( new User( $row ) );
			}
		}

		// Group perms:
		$sql = 'SELECT T_users.*
					    FROM T_users LEFT JOIN T_coll_group_perms ON user_grp_ID = bloggroup_group_ID
					   WHERE bloggroup_blog_ID = '.$blog_ID.'
					     AND bloggroup_ismember  <> 0';
		foreach( $DB->get_results( $sql ) as $row )
		{
			if( !isset($this->cache[$row->user_ID]) )
			{	// Save reinstatiating User if it's already been added
				$this->add( new User( $row ) );
			}
		}

		return true;
	}


	/**
	 * Loads cache with blog memeber, then display form option list with cache contents
	 *
	 * Optionally, also adds default choice to the cache.
	 *
	 * @param integer blog ID
	 * @param integer selected ID
	 * @param boolean provide a choice for "none" with ID 0
	 */
	function get_blog_member_option_list( $blog_ID, $default = 0, $allow_none = false, $always_load_default = false )
	{
		if( $blog_ID )
		{ // Load requested blog members:
			$this->load_blogmembers( $blog_ID );

			// Make sure current user is in list:
			if( $default && $always_load_default )
			{
				// echo '<option>getting default';
				$this->get_by_ID( $default );
			}
		}
		else
		{ // No blog specified: load ALL members:
			$this->load_all();
		}

		return parent::get_option_list( $default, $allow_none, 'get_preferred_name' );
	}


	/**
	 * Clear our caches.
	 */
	function clear( $keep_shadow = false )
	{
		$this->alreadyCached = array();
		$this->cache_login = array();

		return parent::clear($keep_shadow);
	}

	/**
	 * Handle our login cache.
	 */
	function remove_by_ID( $reg_ID )
	{
		if( isset($this->cache[$req_ID]) )
		{
			unset( $this->cache_login[ $this->cache[$req_ID] ] );
		}
		parent::remove_by_ID($req_ID);
	}
}



?>