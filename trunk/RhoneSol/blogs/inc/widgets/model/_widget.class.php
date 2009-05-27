<?php
/**
 * This file implements the Widget class.
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
 * @version $Id: _widget.class.php,v 1.34 2008/02/08 22:24:46 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * ComponentWidget Class
 *
 * A ComponentWidget is a displayable entity that can be placed into a Container on a web page.
 *
 * @package evocore
 */
class ComponentWidget extends DataObject
{
	var $coll_ID;
	/**
	 * Container name
	 */
	var $sco_name;
	var $order;
	/**
	 * @var string Type of the plugin ("core" or "plugin")
	 */
	var $type;
	var $code;
	var $params;

	/**
	 * Array of params which have been customized for this widget instance
	 *
	 * This is saved to the DB as a serialized string ($params)
	 */
	var $param_array = NULL;

	/**
	 * Array of params used during display()
	 */
	var $disp_params;

	/**
	 * Lazy instantiated
	 * (false if this Widget is not handled by a Plugin)
	 * @see get_Plugin()
	 * @var Plugin
	 */
	var $Plugin;


	/**
	 * Constructor
	 *
	 * @param object data row from db
	 */
	function ComponentWidget( $db_row = NULL, $type = 'core', $code = NULL )
	{
		// Call parent constructor:
		parent::DataObject( 'T_widget', 'wi_', 'wi_ID' );

		if( is_null($db_row) )
		{	// We are creating an object here:
			$this->set( 'type', $type );
			$this->set( 'code', $code );
		}
		else
		{	// Wa are loading an object:
			$this->ID       = $db_row->wi_ID;
			$this->coll_ID  = $db_row->wi_coll_ID;
			$this->sco_name = $db_row->wi_sco_name;
			$this->type     = $db_row->wi_type;
			$this->code     = $db_row->wi_code;
			$this->params   = $db_row->wi_params;
			$this->order    = $db_row->wi_order;
		}
	}


	/**
	 * Get ref to Plugin handling this Widget
	 *
	 * @return Plugin
	 */
	function & get_Plugin()
	{
		global $Plugins;

		if( is_null( $this->Plugin ) )
		{
			if( $this->type != 'plugin' )
			{
				$this->Plugin = false;
			}
			else
			{
				$this->Plugin = & $Plugins->get_by_code( $this->code );
			}
		}

		return $this->Plugin;
	}


	/**
	 * Load params
	 */
	function load_from_Request()
	{
		load_funcs('plugins/_plugin.funcs.php');

		// Loop through all widget params:
		foreach( $this->get_param_definitions( array('for_editing'=>true) ) as $parname => $parmeta )
		{
			autoform_set_param_from_request( $parname, $parmeta, $this, 'Widget' );
		}

		// SPECIAL treatments:
		if( empty($this->param_array['widget_name']) )
		{	// Default name, don't store:
			$this->set( 'widget_name', $this->get_name() );
		}
	}


	/**
	 * Get name of widget
	 *
	 * Should be overriden by core widgets
	 */
	function get_name()
	{
		if( $this->type == 'plugin' )
		{
			// Make sure Plugin is loaded:
			if( $this->get_Plugin() )
			{
				return $this->Plugin->name;
			}
			return T_('Inactive / Uninstalled plugin');
		}

		return T_('Unknown');
	}


	/**
	 * Get a very short desc. Used in the widget list.
	 *
	 * MAY be overriden by core widgets. Example: menu link widget.
	 */
	function get_short_desc()
	{
		return $this->get_name();
	}


	/**
	 * Get desc of widget
	 *
	 * Should be overriden by core widgets
	 */
	function get_desc()
	{
		if( $this->type == 'plugin' )
		{
			// Make sure Plugin is loaded:
			if( $this->get_Plugin() )
			{
				return $this->Plugin->short_desc;
			}
			return T_('Inactive / Uninstalled plugin');
		}

		return T_('Unknown');
	}


	/**
	 * Get definitions for editable params
	 *
	 * @see Plugin::GetDefaultSettings()
	 * @param local params like 'for_editing' => true
	 */
	function get_param_definitions( $params )
	{
		$r = array(
				'widget_name' => array(
					'label' => T_( 'Name' ),
					'size' => 20,
					'note' => T_( 'Name displayed on your widget list.'),
					'defaultvalue' => $this->get_name(),
				),
				'widget_css_class' => array(
					'label' => T_( 'CSS Class' ),
					'size' => 20,
					'note' => T_( 'Replaces $wi_class$ in your skins containers.'),
				),
				'widget_ID' => array(
					'label' => T_( 'DOM ID' ),
					'size' => 20,
					'note' => T_( 'Replaces $wi_ID$ in your skins containers.'),
				),
			);

		if( $this->type == 'plugin' )
		{
			// Make sure Plugin is loaded:
			if( $this->get_Plugin() )
			{
				$r = array_merge( $r, $this->Plugin->get_widget_param_definitions( $params ) );
			}
		}
		return $r;
	}


	/**
	 * Load param array
	 */
	function load_param_array()
	{
		if( is_null( $this->param_array ) )
		{	// Param array has not been loaded yet
			$this->param_array = @unserialize( $this->params );

			if( empty( $this->param_array ) )
			{	// No saved param values were found:
				$this->param_array = array();
			}
		}
	}


	/**
 	 * param value
 	 *
	 */
	function get_param( $parname )
	{
		$this->load_param_array();
		if( isset( $this->param_array[$parname] ) )
		{	// We have a value for this param:
			return $this->param_array[$parname];
		}

		// Try default values:
		$params = $this->get_param_definitions( NULL );
		if( isset( $params[$parname]['defaultvalue'] ) )
		{	// We ahve a default value:
			return $params[$parname]['defaultvalue'] ;
		}

		return NULL;
	}


	/**
	 * Set param value
	 *
	 * @param string parameter name
	 * @param mixed parameter value
	 * @return boolean true, if a value has been set; false if it has not changed
	 */
	function set( $parname, $parvalue )
	{
		$params = $this->get_param_definitions( NULL );

		if( isset( $params[$parname] ) )
		{	// This is a widget specific param:
			$this->param_array[$parname] = $parvalue;
			// This is what'll be saved to the DB:
			$this->set_param( 'params', 'string', serialize($this->param_array) );
			return;
		}

		switch( $parname )
		{
			default:
				return parent::set_param( $parname, 'string', $parvalue );
		}
	}


	/**
	 * Prepare display params
	 *
	 * @todo Document default params and default values.
	 *       This might link to a wiki page, too.
	 *
	 * @param array
	 */
	function init_display( $params )
	{
		// Generate widget defaults array:
		$widget_defaults = array();
		$defs = $this->get_param_definitions( array() );
		foreach( $defs as $parname => $parmeta )
		{
			if( isset( $parmeta['defaultvalue'] ) )
			{
				$widget_defaults[ $parname ] = $parmeta['defaultvalue'];
			}
			else
			{
				$widget_defaults[ $parname ] = NULL;
			}
		}

		// Load DB configuration:
		$this->load_param_array();

		// Merge basic defaults < widget defaults < container params < DB params
		// note: when called with skin_widget it falls back to basic defaults < widget defaults < calltime params < array()
		$params = array_merge( array(
					'block_start' => '<div class="$wi_class$">',
					'block_end' => '</div>',
					'block_display_title' => true,
					'block_title_start' => '<h3>',
					'block_title_end' => '</h3>',
					'collist_start' => '',
					'collist_end' => '',
					'coll_start' => '<h4>',
					'coll_end' => '</h4>',
					'list_start' => '<ul>',
					'list_end' => '</ul>',
					'item_start' => '<li>',
					'item_end' => '</li>',
					'link_default_class' => 'default',
					'item_text_start' => '',
					'item_text_end' => '',
					'item_selected_start' => '<li class="selected">',
					'item_selected_end' => '</li>',
					'link_selected_class' => 'selected',
					'link_type' => 'canonic',		// 'canonic' | 'context' (context will regenrate URL injecting/replacing a single filter)
					'item_selected_text_start' => '',
					'item_selected_text_end' => '',
					'group_start' => '<ul>',
					'group_end' => '</ul>',
					'notes_start' => '<div class="notes">',
					'notes_end' => '</div>',
					'tag_cloud_start' => '<p class="tag_cloud">',
					'tag_cloud_end' => '</p>',
				), $widget_defaults, $params, $this->param_array );

		// Customize params to the current widget:
		// add additional css classes if required
		$widget_css_class = 'widget_'.$this->type.'_'.$this->code.( empty( $params[ 'widget_css_class' ] ) ? '' : ' '.$params[ 'widget_css_class' ] );
		// add custom id if required, default to generic id for validation purposes
		$widget_ID = ( !empty($params[ 'widget_ID' ]) ? $params[ 'widget_ID' ] : 'widget_'.$this->type.'_'.$this->code.'_'.$this->ID );
		// replace the values
		$this->disp_params = str_replace( array( '$wi_ID$', '$wi_class$' ), array( $widget_ID, $widget_css_class ), $params );
	}


	/**
	 * Display the widget!
	 *
	 * Should be overriden by core widgets
	 *
	 * @todo fp> handle custom params for each widget
	 *
	 * @param array MUST contain at least the basic display params
	 */
	function display( $params )
	{
		global $Blog;
		global $Plugins;
		global $rsc_url;

		$this->init_display( $params );

		switch( $this->type )
		{
			case 'plugin':
				// Call plugin (will return false if Plugin is not enabled):
				if( $Plugins->call_by_code( $this->code, $this->disp_params ) )
				{
					return true;
				}
				// Plugin failed (happens when a plugin has been disabled for example):
				return false;
		}

		echo "Widget $this->type : $this->code did not provide a display() method! ";

		return false;
	}


	/**
	 * Note: a container can prevent display of titles with 'block_display_title'
	 * This is useful for the lists in the headers
	 * fp> I'm not sur if this param should be overridable by widgets themselves (priority problem)
	 * Maybe an "auto" setting.
	 *
	 * @protected
	 */
	function disp_title( $title = NULL )
	{
		if( is_null($title) )
		{
			$title = & $this->disp_params['title'];
		}

		if( $this->disp_params['block_display_title'] && !empty( $title ) )
		{
			echo $this->disp_params['block_title_start'];
			echo format_to_output( $title );
			echo $this->disp_params['block_title_end'];
		}
	}


	/**
	 * List of items
	 *
	 * @param string 'pages' or 'posts'
	 */
	function disp_item_list( $what )
	{
		global $Blog;
		global $timestamp_min, $timestamp_max;

		$blogCache = get_Cache( 'BlogCache' );
		// TODO: dh> does it make sense to die in $blogCache, in case the blog does not exist anymore?
		$listBlog = ( $this->disp_params[ 'blog_ID' ] ? $blogCache->get_by_ID( $this->disp_params[ 'blog_ID' ] ) : $Blog );

		// Create ItemList
		// Note: we pass a widget specific prefix in order to make sure to never interfere with the mainlist
		$limit = $this->disp_params[ 'limit' ];
		$ItemList = & new ItemListLight( $listBlog, $timestamp_min, $timestamp_max, $limit, 'ItemCacheLight', $this->code.'_' );
		// Filter list:
		if( $what == 'pages' )
		{
			$ItemList->set_filters( array(
					'types' => '1000',					// Restrict to type 1000 (pages)
					'orderby' => 'title',
					'order' => ( $this->disp_params[ 'disp_order' ] ? $this->disp_params[ 'disp_order' ] : 'ASC' ),
					'unit' => 'posts',
				), false );
		}
		else
		{	// post list
			$ItemList->set_filters( array(
					'order' => ( $this->disp_params[ 'disp_order' ] ? $this->disp_params[ 'disp_order' ] : 'DESC' ),
					'unit' => 'posts',						// We want to advertise all items (not just a page or a day)
				) );
		}
		// Run the query:
		$ItemList->query();

		if( ! $ItemList->result_num_rows )
		{	// Nothing to display:
			return;
		}

		echo $this->disp_params['block_start'];

		$title = sprintf( ( $this->disp_params[ 'title_link' ] ? '<a href="'.$listBlog->gen_blogurl().'" rel="nofollow">%s</a>' : '%s' ), $this->disp_params[ 'title' ] );

		$this->disp_title( $title );

		echo $this->disp_params['list_start'];

		while( $Item = & $ItemList->get_item() )
		{
			echo $this->disp_params['item_start'];
			$Item->title( array(
					'link_type' => 'permalink',
				) );
			if( $this->disp_params[ 'disp_excerpt' ] )
				echo '<p>'.$Item->dget( 'excerpt', 'htmlbody' ).'</p>';// no formatting in excerpts

			echo $this->disp_params['item_end'];
		}

		echo $this->disp_params['list_end'];

		echo $this->disp_params['block_end'];
	}


	/**
	 * List of items by category
	 *
	 * @param array MUST contain at least the basic display params
	 */
	function disp_cat_item_list( $link_type = 'linkto_url' )
	{
		global $BlogCache, $Blog;
		global $timestamp_min, $timestamp_max;

		$linkblog = $this->disp_params[ 'linkblog_ID' ];

		if( ! $linkblog )
		{	// No linkblog blog requested for this blog
			return;
		}

		// Load the linkblog blog:
		$link_Blog = & $BlogCache->get_by_ID( $linkblog, false );

		if( empty($link_Blog) )
		{
			echo $this->disp_params['block_start'];
			echo T_('The requested Blog doesn\'t exist any more!');
  		echo $this->disp_params['block_end'];
			return;
		}


		# This is the list of categories to restrict the linkblog to (cats will be displayed recursively)
		# Example: $linkblog_cat = '4,6,7';
		$linkblog_cat = '';

		# This is the array if categories to restrict the linkblog to (non recursive)
		# Example: $linkblog_catsel = array( 4, 6, 7 );
		$linkblog_catsel = array();

		// Compile cat array stuff:
		$linkblog_cat_array = array();
		$linkblog_cat_modifier = '';
		compile_cat_array( $linkblog_cat, $linkblog_catsel, /* by ref */ $linkblog_cat_array, /* by ref */  $linkblog_cat_modifier, $linkblog );

		$limit = ( $this->disp_params[ 'linkblog_limit' ] ? $this->disp_params[ 'linkblog_limit' ] : 1000 ); // Note: 1000 will already kill the display

		$LinkblogList = & new ItemListLight( $link_Blog, $timestamp_min, $timestamp_max, $limit );

		$LinkblogList->set_filters( array(
				'cat_array' => $linkblog_cat_array,
				'cat_modifier' => $linkblog_cat_modifier,
				'orderby' => 'main_cat_ID title',
				'order' => 'ASC',
				'unit' => 'posts',
			), false ); // we don't want to memorise these params

		// Run the query:
		$LinkblogList->query();

		if( ! $LinkblogList->get_num_rows() )
		{ // empty list:
			return;
		}

		echo $this->disp_params['block_start'];

 		$this->disp_title( $this->disp_params[ 'title' ] );

		echo $this->disp_params['list_start'];

		/**
		 * @var ItemLight
		 */
		while( $Item = & $LinkblogList->get_category_group() )
		{
			// Open new cat:
			echo $this->disp_params['item_start'];
			$Item->main_category();
			echo $this->disp_params['group_start'];

			while( $Item = & $LinkblogList->get_item() )
			{
				echo $this->disp_params['item_start'];

				$Item->title( array(
						'link_type' => $link_type,
					) );

				/*
				$Item->content_teaser( array(
						'before'      => '',
						'after'       => ' ',
						'disppage'    => 1,
						'stripteaser' => false,
					) );

				$Item->more_link( array(
						'before'    => '',
						'after'     => '',
						'link_text' => T_('more').' &raquo;',
					) );
				*/


				echo $this->disp_params['item_end'];
			}

			// Close cat
			echo $this->disp_params['group_end'];
			echo $this->disp_params['item_end'];
		}

		// Close the global list
		echo $this->disp_params['list_end'];

		echo $this->disp_params['block_end'];
	}


	/**
	 * List of collections/blogs
	 *
	 * @param array MUST contain at least the basic display params
	 */
	function disp_coll_list( $filter = 'public' )
	{
		/**
		 * @var Blog
		 */
		global $Blog;

		echo $this->disp_params['block_start'];

		$this->disp_title( T_('Blogs') );

		echo $this->disp_params['list_start'];

		/**
		 * @var BlogCache
		 */
		$BlogCache = & get_Cache( 'BlogCache' );

		if( $filter == 'owner' )
		{	// Load blogs of same owner
			$blog_array = $BlogCache->load_owner_blogs( $Blog->owner_user_ID, 'ID' );
		}
		else
		{	// Load all public blogs
			$blog_array = $BlogCache->load_public( 'ID' );
		}

		foreach( $blog_array as $l_blog_ID )
		{	// Loop through all public blogs:

			$l_Blog = & $BlogCache->get_by_ID( $l_blog_ID );

			if( $Blog && $l_blog_ID == $Blog->ID )
			{ // This is the blog being displayed on this page:
  			echo $this->disp_params['item_selected_start'];
				$link_class = $this->disp_params['link_selected_class'];
			}
			else
			{
				echo $this->disp_params['item_start'];
				$link_class = $this->disp_params['link_default_class'];;
			}

			echo '<a href="'.$l_Blog->gen_blogurl().'" class="'.$link_class.'" title="'
										.$l_Blog->dget( 'name', 'htmlattr' ).'">';

			if( $Blog && $l_blog_ID == $Blog->ID )
			{ // This is the blog being displayed on this page:
				echo $this->disp_params['item_selected_text_start'];
				echo $l_Blog->dget( 'shortname', 'htmlbody' );
				echo $this->disp_params['item_selected_text_end'];
				echo '</a>';
				echo $this->disp_params['item_selected_end'];
			}
			else
			{
				echo $this->disp_params['item_text_start'];
				echo $l_Blog->dget( 'shortname', 'htmlbody' );
				echo $this->disp_params['item_text_end'];
				echo '</a>';
				echo $this->disp_params['item_end'];
			}
		}

		echo $this->disp_params['list_end'];

		echo $this->disp_params['block_end'];
	}


	/**
	 * Insert object into DB based on previously recorded changes.
	 *
	 * @return boolean true on success
	 */
	function dbinsert()
	{
		global $DB;

		if( $this->ID != 0 ) die( 'Existing object cannot be inserted!' );

		$DB->begin();

		$order_max = $DB->get_var(
			'SELECT MAX(wi_order)
				 FROM T_widget
				WHERE wi_coll_ID = '.$this->coll_ID.'
					AND wi_sco_name = '.$DB->quote($this->sco_name), 0, 0, 'Get current max order' );

		$this->set( 'order', $order_max+1 );

		$res = parent::dbinsert();

		$DB->commit();

		return $res;
	}
}



?>