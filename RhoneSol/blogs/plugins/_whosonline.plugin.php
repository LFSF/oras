<?php
/**
 * This file implements the Whosonline plugin.
 *
 * This file is part of the b2evolution project - {@link http://b2evolution.net/}
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
 * @package plugins
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE - {@link http://fplanque.net/}
 * @author jeffbearer: Jeff BEARER - {@link http://www.jeffbearer.com/}.
 *
 * @version $Id: _whosonline.plugin.php,v 1.3 2008/01/21 09:35:41 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * Calendar Plugin
 *
 * This plugin displays
 */
class whosonline_plugin extends Plugin
{
	/**
	 * Variables below MUST be overriden by plugin implementations,
	 * either in the subclass declaration or in the subclass constructor.
	 */

	var $name = 'Who\'s online Widget';
	var $code = 'evo_WhosOnline';
	var $priority = 96;
	var $version = '2.0';
	var $author = 'The b2evo Group';
	var $group = 'widget';


	/**
	 * Init
	 */
	function PluginInit( & $params )
	{
		$this->short_desc = T_('This skin tag displays a list of whos is online.');
		$this->long_desc = T_('All logged in users and guest users who have requested a page in the last 5 minutes are listed.');
	}


  /**
   * Get definitions for widget specific editable params
   *
	 * @see Plugin::GetDefaultSettings()
	 * @param local params like 'for_editing' => true
	 */
	function get_widget_param_definitions( $params )
	{
		$r = array(
			'contacticons' => array(
				'label' => T_('Contact icons'),
				'note' => T_('Display contact icons allowing to send private messages to logged in users.'),
				'type' => 'checkbox',
				'defaultvalue' => true,
			),
		);
		return $r;
	}


	/**
	 * Event handler: SkinTag (widget)
	 *
	 * @param array Associative array of parameters.
	 * @return boolean did we display?
	 */
	function SkinTag( $params )
	{
		global $generating_static, $Plugins;

		if( ! empty($generating_static) || $Plugins->trigger_event_first_true('CacheIsCollectingContent') )
		{ // We're not generating static pages nor is a caching plugin collecting the content, so we can display this block
			return false;
		}

		echo $params['block_start'];

		echo $params['block_title_start'];
		echo T_('Who\'s Online?');
		echo $params['block_title_end'];

		$OnlineSessions = new OnlineSessions();

		$OnlineSessions->display_onliners( $params );

		echo $params['block_end'];

		return true;
	}
}


/**
 * This tracks who is online
 *
 * @todo dh> I wanted to add a MySQL INDEX on the sess_lastseen field, but this "plugin"
 *       is the only real user of this. So, when making this a plugin, this should
 *       add the index perhaps.
 * @package evocore
 */
class OnlineSessions
{
	/**
	 * Number of guests (and users that want to be anonymous)
	 *
	 * Gets lazy-filled when needed, through {@link init()}.
	 *
	 * @access protected
	 */
	var $_count_guests;


	/**
	 * List of registered users.
	 *
	 * Gets lazy-filled when needed, through {@link init()}.
	 *
	 * @access protected
	 */
	var $_registered_Users;


	var $_initialized = false;


	/**
	 * Get an array of registered users and guests.
	 *
	 * @return array containing number of registered users and guests ('registered' and 'guests')
	 */
	function init()
	{
		if( $this->_initialized )
		{
			return true;
		}
		global $DB, $localtimenow, $timeout_online_user;

		$this->_count_guests = 0;
		$this->_registered_Users = array();

		$timeout_YMD = date( 'Y-m-d H:i:s', ($localtimenow - $timeout_online_user) );

		$UserCache = & get_Cache( 'UserCache' );

		// We get all sessions that have been seen in $timeout_YMD and that have a session key.
		// NOTE: we do not use DISTINCT here, because guest users are all "NULL".
		foreach( $DB->get_results( "
			SELECT sess_user_ID
			  FROM T_sessions
			 WHERE sess_lastseen > '".$timeout_YMD."'
			   AND sess_key IS NOT NULL", OBJECT, 'Sessions: get list of relevant users.' ) as $row )
		{
			if( !empty( $row->sess_user_ID )
					&& ( $User = & $UserCache->get_by_ID( $row->sess_user_ID ) ) )
			{
				// assign by ID so that each user is only counted once (he could use multiple user agents at the same time)
				$this->_registered_Users[ $User->ID ] = & $User;

				if( !$User->showonline )
				{
					$this->_count_guests++;
				}
			}
			else
			{
				$this->_count_guests++;
			}
		}

		$this->_initialized = true;
	}


	/**
	 * Get the number of guests.
	 *
	 * @param boolean display?
	 */
	function number_of_guests( $display = true )
	{
		if( !isset($this->_count_guests) )
		{
			$this->init();
		}

		if( $display )
		{
			echo $this->_count_guests;
		}
		return $this->_count_guests;
	}


	/**
	 * Template function: Display onliners, both registered users and guests.
	 *
	 * @todo get class="" out of here (put it into skins)
	 */
	function display_onliners( $params )
	{
		$this->display_online_users( $params );
		$this->display_online_guests( $params );
	}

	/**
	 * Template function: Display the registered users who are online
	 *
	 * @todo get class="" out of here (put it into skins)
	 *
	 * @param array
	 */
	function display_online_users( $params )
	{
		global $DB, $Blog;
		global $generating_static;
		if( isset($generating_static) ) { return; }

		if( !isset($this->_registered_Users) )
		{
			$this->init();
		}

		// Note: not all users want to appear online, so we might have an empty list.
		$r = '';

		foreach( $this->_registered_Users as $User )
		{
			if( $User->showonline )
			{
				if( empty($r) )
				{ // first user
					$r .= $params['list_start'];
				}

				$r .= $params['item_start'];
				$r .= $User->dget('preferredname');
				if( $params['contacticons'] )
				{	// We want contact icons:
					$r .= $User->get_msgform_link();
				}
				$r .= $params['item_end'];
			}
		}

		if( !empty($r) )
		{ // we need to close the list
			$r .= $params['list_end'];;
		}

		echo $r;
	}


	/**
	 * Template function: Display number of online guests.
	 */
	function display_online_guests( $params )
	{
		global $generating_static;
		if( isset($generating_static) ) { return; }

		if( !isset($this->_count_guests) )
		{
			$this->init();
		}

		$r = $params['list_start'];
		$r .= $params['item_start'];
		$r .= T_('Guest Users:').' ';
		$r .= $this->_count_guests;
		$r .= $params['item_end'];
		$r .= $params['list_end'];;

		echo $r;
	}
}



?>