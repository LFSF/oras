<?php
/**
 * This file implements the xyz Widget class.
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
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _user_tools.widget.php,v 1.3 2008/01/21 09:35:37 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class( 'widgets/model/_widget.class.php' );

/**
 * ComponentWidget Class
 *
 * A ComponentWidget is a displayable entity that can be placed into a Container on a web page.
 *
 * @package evocore
 */
class user_tools_Widget extends ComponentWidget
{
	/**
	 * Constructor
	 */
	function user_tools_Widget( $db_row = NULL )
	{
		// Call parent constructor:
		parent::ComponentWidget( $db_row, 'core', 'user_tools' );
	}


  /**
   * Get definitions for editable params
   *
	 * @see Plugin::GetDefaultSettings()
	 * @param local params like 'for_editing' => true
	 */
	function get_param_definitions( $params )
	{
		$r = array_merge( array(
			'title' => array(
				'label' => t_('Block title'),
				'note' => T_( 'Title to display in your skin.' ),
				'size' => 40,
				'defaultvalue' => T_('User tools'),
			),
			'user_login_link' => array(
				'label' => T_( 'Login link'),
				'size' => 40,
				'note' => T_( 'Link text to display' ),
				'type' => 'text',
				'defaultvalue' => T_( 'Login' ),
			),
			'user_logout_link' => array(
				'label' => T_( 'Logout link'),
				'size' => 40,
				'note' => T_( 'Link text to display' ),
				'type' => 'text',
				'defaultvalue' => T_( 'Logout' ),
			),
			'user_profile_link' => array(
				'label' => T_( 'Profile link'),
				'size' => 40,
				'note' => T_( 'Link text to display' ),
				'type' => 'text',
				'defaultvalue' => T_( 'Profile' ),
			),
			'user_subs_link' => array(
				'label' => T_( 'Subscriptions link'),
				'size' => 40,
				'note' => T_( 'Link text to display' ),
				'type' => 'text',
				'defaultvalue' => T_( 'Subscriptions' ),
			),
			'user_admin_link' => array(
				'label' => T_( 'Admin link'),
				'size' => 40,
				'note' => T_( 'Link text to display' ),
				'type' => 'text',
				'defaultvalue' => T_( 'Admin' ),
			),
			'user_register_link' => array(
				'label' => T_( 'Register link'),
				'size' => 40,
				'note' => T_( 'Link text to display' ),
				'type' => 'text',
				'defaultvalue' => T_( 'Register' ),
			),
		), parent::get_param_definitions( $params )	);

		return $r;
	}

	/**
	 * Get name of widget
	 */
	function get_name()
	{
		return T_('User Tools');
	}


  /**
	 * Get short description
	 */
	function get_desc()
	{
		return T_('Display user tools: Log in, Admin, Profile, Subscriptions, Log out');
	}


	/**
	 * Display the widget!
	 *
	 * @param array MUST contain at least the basic display params
	 */
	function display( $params )
	{
		$this->init_display( $params );

		// User tools:
		echo $this->disp_params['block_start'];

		echo $this->disp_params['block_title_start'];
		echo T_('User tools');
		echo $this->disp_params['block_title_end'];

		echo $this->disp_params['list_start'];
		user_login_link( $this->disp_params['item_start'], $this->disp_params['item_end'], $this->disp_params[ 'user_login_link' ] );
		user_register_link( $this->disp_params['item_start'], $this->disp_params['item_end'], $this->disp_params[ 'user_register_link' ] );
		user_admin_link( $this->disp_params['item_start'], $this->disp_params['item_end'], $this->disp_params[ 'user_admin_link' ] );
		user_profile_link( $this->disp_params['item_start'], $this->disp_params['item_end'], $this->disp_params[ 'user_profile_link' ] );
		user_subs_link( $this->disp_params['item_start'], $this->disp_params['item_end'], $this->disp_params[ 'user_subs_link' ] );
		user_logout_link( $this->disp_params['item_start'], $this->disp_params['item_end'], $this->disp_params[ 'user_logout_link' ] );
		echo $this->disp_params['list_end'];

		echo $this->disp_params['block_end'];
	}
}



?>