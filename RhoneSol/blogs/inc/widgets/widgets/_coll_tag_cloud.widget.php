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
 * @version $Id: _coll_tag_cloud.widget.php,v 1.8 2008/01/21 09:35:37 fplanque Exp $
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
class coll_tag_cloud_Widget extends ComponentWidget
{
	/**
	 * Constructor
	 */
	function coll_tag_cloud_Widget( $db_row = NULL )
	{
		// Call parent constructor:
		parent::ComponentWidget( $db_row, 'core', 'coll_tag_cloud' );
	}


  /**
	 * Load params
	 */
	function load_from_Request()
	{
		parent::load_from_Request();

		// SPECIAL treatments:
		if( empty($this->param_array['tag_separator']) )
		{	// Default name, don't store:
			$this->set( 'tag_separator', ' ' );
		}
	}


	/**
	 * Get name of widget
	 */
	function get_name()
	{
		return T_('Tag cloud');
	}


  /**
	 * Get short description
	 */
	function get_desc()
	{
		return T_('Cloud of all tags; click filters blog on selected tag.');
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
					'type' => 'text',
					'label' => T_('Block title'),
					'defaultvalue' => T_('Tag cloud'),
					'maxlength' => 100,
				),
			'max_tags' => array(
					'type' => 'integer',
					'label' => T_('Max # of tags'),
					'size' => 4,
					'defaultvalue' => 50,
				),
			'tag_separator' => array(
					'type' => 'text',
					'label' => T_('Tag separator'),
					'defaultvalue' => ' ',
					'maxlength' => 100,
				),
			'tag_min_size' => array(
					'type' => 'integer',
					'label' => T_('Min size'),
					'size' => 3,
					'defaultvalue' => 8,
				),
			'tag_max_size' => array(
					'type' => 'integer',
					'label' => T_('Max size'),
					'size' => 3,
					'defaultvalue' => 22,
				),
			), parent::get_param_definitions( $params )	);

		// add limit default 100

		return $r;

	}


	/**
	 * Display the widget!
	 *
	 * @param array MUST contain at least the basic display params
	 */
	function display( $params )
	{
		$this->init_display( $params );

		global $Blog;

		if( empty($Blog) )
		{	// Nothing to display
			return;
		}

		global $DB;

		$sql = 'SELECT LOWER(tag_name) AS tag_name, COUNT(itag_itm_ID) AS tag_count
						  FROM T_items__tag INNER JOIN T_items__itemtag ON itag_tag_ID = tag_ID
					  				INNER JOIN T_postcats ON itag_itm_ID = postcat_post_ID
					  				INNER JOIN T_categories ON postcat_cat_ID = cat_ID
						 WHERE cat_blog_ID = '.$Blog->ID.'
						 GROUP BY tag_name
						 ORDER BY tag_count DESC
						 LIMIT '.$this->disp_params['max_tags'];

		$results = $DB->get_results( $sql, OBJECT, 'Get tags' );

		// pre_dump( $results );

		if( empty($results) )
		{	// No tags!
			return;
		}

		$max_count = $results[0]->tag_count;
		$min_count = $results[count($results)-1]->tag_count;
		$count_span = max( 1, $max_count - $min_count );
		$max_size = $this->disp_params['tag_max_size'];
		$min_size = $this->disp_params['tag_min_size'];
		$size_span = $max_size - $min_size;

		function tag_cloud_cmp($a, $b)
		{
			if ($a->tag_name == $b->tag_name)
			{
				return 0;
			}
			return ($a->tag_name < $b->tag_name) ? -1 : 1;
		}

		usort($results, 'tag_cloud_cmp');

		echo $this->disp_params['block_start'];

		$this->disp_title();

		echo $this->disp_params['tag_cloud_start'];
		$count = 0;
		foreach( $results as $row )
		{
			if( $count > 0 )
			{
				echo $this->disp_params['tag_separator'];
			}
			$size = floor( $row->tag_count * $size_span / $count_span + $min_size );
			echo '<a href="'.$Blog->gen_tag_url( $row->tag_name ).'" style="font-size: '.$size.'pt;" title="'
						.sprintf( T_('%d posts'), $row->tag_count ).'">'.format_to_output($row->tag_name).'</a>';
			$count++;
		}
		echo $this->disp_params['tag_cloud_end'];

		echo $this->disp_params['block_end'];

		return true;
	}
}



?>