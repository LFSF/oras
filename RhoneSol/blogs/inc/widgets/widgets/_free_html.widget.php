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
 * @version $Id: _free_html.widget.php,v 1.8 2008/01/21 09:35:37 fplanque Exp $
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
class free_html_Widget extends ComponentWidget
{
	/**
	 * Constructor
	 */
	function free_html_Widget( $db_row = NULL )
	{
		// Call parent constructor:
		parent::ComponentWidget( $db_row, 'core', 'free_html' );
	}


	/**
	 * Get name of widget
	 */
	function get_name()
	{
		$title = T_( 'Free HTML' );
		return $title;
	}


  /**
	 * Get short description
	 */
	function get_desc()
	{
		return T_('Custom text/HTML of your choice.');
	}


  /**
   * Get definitions for editable params
   *
	 * @see Plugin::GetDefaultSettings()
	 * @param local params like 'for_editing' => true
	 */
	function get_param_definitions( $params )
	{
		// Demo data:
		$r = array_merge( array(
				'title' => array(
					'label' => 'Block title',
					'size' => 60,
				),
				'content' => array(
					'type' => 'html_textarea',
					'label' => T_('Block content'),
					'rows' => 10,
				),
			), parent::get_param_definitions( $params )	);

		return $r;

	}


	/**
	 * Display the widget!
	 *
	 * @param array MUST contain at least the basic display params
	 */
	function display( $params )
	{
		global $Blog;

		$this->init_display( $params );

		// Collection common links:
		echo $this->disp_params['block_start'];

		$this->disp_title( $this->disp_params['title'] );

		echo format_to_output( $this->disp_params['content'] );

		echo $this->disp_params['block_end'];

		return true;
	}
}



?>