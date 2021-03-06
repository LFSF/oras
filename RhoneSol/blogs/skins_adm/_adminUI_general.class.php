<?php
/**
 * This file implements the Admin UI class.
 * Admin skins should derive from this class and override {@link get_template()}
 * for example.
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2005 by Daniel HAHLER - {@link http://thequod.de/contact}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * {@internal Open Source relicensing agreement:
 * Daniel HAHLER grants Francois PLANQUE the right to license
 * Daniel HAHLER's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER
 * @author fplanque: Francois PLANQUE.
 *
 * @todo Refactor to allow easier contributions! (blueyed)
 *
 * @version $Id: _adminUI_general.class.php,v 1.80.2.1 2008/02/13 06:57:03 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


load_funcs( '_core/ui/_uiwidget.class.php' );


/**
 * The general Admin UI class. It provides functions to handle the UI part of the
 * Backoffice.
 *
 * Admin skins should derive from this class and override {@link get_template()}
 * for example.
 *
 * @package admin
 * @todo CODE DOCUMENTATION!!!
 */
class AdminUI_general extends Widget
{
	/**
	 * Visual path seperator (used in html title, ..)
	 *
	 * @var string
	 */
	var $pathSeparator = ' &rsaquo; ';

	/*-------------------------------------------------------------------*/
	/*- The members below should not get overridden in a derived class. -*/

	/**
	 * The menus.
	 *
	 * Use {@link add_menu_entries()} to add them here.
	 *
	 * @access protected
	 * @var array
	 */
	var $_menus = array();

	/**
	 * The path of the current selected menu entry.
	 * Array of strings.
	 * The top level entry is at position 0. Selected submenu entries follow.
	 *
	 * Use {@link get_path()} or {@link get_path_range()} to access it.
	 * Use {@link set_path()}, {@link append_path_level()} or {@link set_path_level()} to set it.
	 *
	 * @access protected
	 * @var array
	 */
	var $path = array();

	/**
	 * The properties of the path entries.
	 * Numbered Array of arrays.
	 * The top level entry is at position 0. Selected submenu entries follow.
	 *
	 * Use {@link get_prop_for_path()} or {@link get_properties_for_path()} to access it
	 * Use {@link set_path()}, {@link append_path_level()} or {@link set_path_level()} to set it.
	 *
	 * @access protected
	 * @var array
	 */
	var $pathProps = array();

	/**
	 * The explicit title for the page.
	 * @var string
	 */
	var $title;

	/**
	 * The explicit title for the titlearea (<h1>).
	 * @var string
	 */
	var $title_titlearea;
	var $title_titlearea_appendix = '';

  /**
   * Collection List buttons: title for 'all' button
	 * @var string
	 */
	var $coll_list_all_title = NULL;
  /**
   * Collection List buttons: url for 'all' button
	 * @var string
	 */
	var $coll_list_all_url = '';
  /**
   * Collection List buttons: permission name to test on to decide wether or not to display buttons
	 * @var string
	 */
	var $coll_list_permname = NULL;
  /**
   * Collection List buttons: minimum level required to display button
	 * @var mixed
	 */
	var $coll_list_permlevel = 1;
  /**
   * Collection List buttons: params of the url used for the buttons
	 * @var array
	 */
	var $coll_list_url_params = array();
  /**
   * Collection List buttons: javascript to execute on click of a button
	 * @var string
	 */
	var $coll_list_onclick = NULL;


	/**
	 * Constructor.
	 */
	function AdminUI_general()
	{
		global $mode; // TODO: make it a real property
		global $htsrv_url, $baseurl;

		$this->mode = $mode;

		$this->init_templates();
	}


	/**
	 * This function should init the templates - like adding Javascript through the {@link add_headline()} method.
	 */
	function init_templates()
	{
	}


	/**
	 * Add menu entries to the list of entries for a given path.
	 *
	 * @param NULL|string|array The path to add the entries to. See {@link get_node_by_path()}.
	 * @param array Menu entries to add (key (string) => entry (array)).
	 *   An entry can have the following keys:
	 *     'text': Text/Caption for this entry.
	 *     'href': The link for this entry.
	 *     'style': CSS style for this entry.
	 *     'onclick': onclick property for this entry.
	 *     'name': name attribute of the link/entry.
	 *     'entries': array of sub-entries
	 */
	function add_menu_entries( $path, $entries )
	{
		// Get a reference to the node in the menu list.
		$node = & $this->get_node_by_path( $path, true );

		/*
		if( !is_array($node) )
		{
			debug_die( 'add_menu_entries() with non-existing path!' );
		}
		*/

		foreach( $entries as $l_key => $l_menu_props )
		{
			$node['entries'][$l_key] = $l_menu_props;
		}
	}


	/**
	 * Add menu entries to the beginning of the list for given path.
	 *
	 * @param NULL|string|array The path to add the entries to.
	 * @param array Menu entries to add (key (string) => entry (array)).
	 * @uses add_menu_entries()
	 */
	function unshift_menu_entries( $path, $entries )
	{
		// Get a reference to the node in the menu list.
		$node = & $this->get_node_by_path( $path, true );

		$node['entries'] = array_reverse( $node['entries'] );

		$this->add_menu_entries( $path, $entries );

		$node['entries'] = array_reverse( $node['entries'] );
	}


	/**
	 * Get the <title> of the page.
	 *
	 * This is either {@link $title} or will be constructed from title/text properties
	 * of the path entries.
	 *
	 * @param boolean If true, the fallback will be in reversed order
	 * @return string
	 */
	function get_title( $reversedDefault = false )
	{
		if( isset($this->title) )
		{ // Explicit title has been set:
			return $this->title;
		}
		else
		{ // Fallback: implode title/text properties of the path
			$titles = $this->get_properties_for_path( $this->path, array( 'title', 'text' ) );
			if( $reversedDefault )
			{ // We have asked for reverse order of the path elements:
				$titles = array_reverse($titles);
			}
			return implode( $this->pathSeparator, $titles );
		}
	}


	/**
	 * Get the title for the titlearea (<h1>).
	 *
	 * This is the current path in the site structure
	 *
	 * @return string
	 */
	function get_title_for_titlearea()
	{
		if( ! isset( $this->title_titlearea ) )
		{ // Construct path:
			$titles = array();
			foreach( $this->path as $i => $lPath )
			{
				if( false !== ($title_text = $this->get_prop_for_path( $i, array( 'title', 'text' ) )) )
				{
					$titles[] = '<a href="'.$this->get_prop_for_path( $i, array( 'href' ) ).'">'.$title_text.'</a>';
				}
			}

			$this->title_titlearea = implode( $this->pathSeparator, $titles );
		}

		return $this->title_titlearea.$this->title_titlearea_appendix;
	}


	/**
	 * Append a string at the end of the existing titlearea.
	 *
	 * We actually keep the appended stuff separate from the main title, because the main title
	 * might in some occasions not be known immediately.
	 *
	 * @param string What to append to the titlearea
	 */
	function append_to_titlearea( $string )
	{
		$this->title_titlearea_appendix .= $this->pathSeparator.$string;
	}


	/**
	 * Get the title for HTML <title> tag.
	 *
	 * If no explicit title has been specified, auto construct one from path.
	 *
	 * @return string
	 */
	function get_html_title()
	{
		global $app_shortname;

		$r = $app_shortname.$this->pathSeparator;

		if( $htmltitle = $this->get_prop_for_node( $this->path, array( 'htmltitle' ) ) )
		{ // Explicit htmltitle set:
			$r .= $htmltitle;
		}
		else
		{	// No explicit title set, construct Title from path
			$r .= #preg_replace( '/:$/', '',
						$this->get_title()
						#)
						;
		}

		return $r;
	}


	/**
	 * Get a list of properties for a given path for a set of property names to check.
	 * The result is a list of properties for each node down the path.
	 *
	 * The property names must be given in $prop_by_ref, ordered by preference.
	 *
	 * @param string|array The path. See {@link get_node_by_path()}.
	 * @param array Alternative names of the property to receive (ordered by priority).
	 * @return array List of the properties.
	 */
	function get_properties_for_path( $path, $prop_by_pref )
	{
		if( !is_array($path) )
		{
			$path = array( $path );
		}
		$r = array();

		$prevPath = array();
		foreach( $path as $i => $lPath )
		{
			if( false !== ($prop = $this->get_prop_for_path( $i, $prop_by_pref )) )
			{
				$r[] = $prop;
			}

			$prevPath[] = $lPath;
		}

		return $r;
	}


	/**
	 * Get a property of a node, given by path.
	 *
	 * @param string|array The path. See {@link get_node_by_path()}.
	 * @param array Alternative names of the property to receive (ordered by priority).
	 * @return mixed|false False if property is not set for the node, otherwise its value.
	 */
	function get_prop_for_node( $path, $prop_by_pref )
	{
		$node = & $this->get_node_by_path( $path );

		foreach( $prop_by_pref as $lProp )
		{
			if( isset($node[$lProp]) )
			{
				return $node[$lProp];
			}
		}

		return false;
	}


	/**
	 * Get a property for a specific path entry.
	 *
	 * @param int The numeric index of the path entry to query (0 is first).
	 * @param array A list of properties to check, ordered by priority.
	 * @return mixed|false The first found property or false if it does not exist
	 */
	function get_prop_for_path( $depth, $prop_by_pref )
	{
		if( $pathWithProps = $this->get_path( $depth, true ) )
		{
			foreach( $prop_by_pref as $lProp )
			{
				if( isset($pathWithProps['props'][$lProp]) )
				{
					// echo "<br>path depth $depth property $lProp = ".$pathWithProps['props'][$lProp];
					return $pathWithProps['props'][$lProp];
				}
			}
		}

		return false;
	}


	/**
	 * Get a menu, any level.
	 *
	 * @param NULL|string|array The path. See {@link get_node_by_path()}.
	 * @param string The template name, see {@link get_template()}.
	 */
	function get_html_menu( $path = NULL, $template = 'main' )
	{
		/* debug:
		$r = ' dispMenu-BEGIN ';
		$r .= $this->get_html_menu_entries( $path, $template );
		$r .= ' dispMenu-END ';
		return $r;
		*/
		return $this->get_html_menu_entries( $path, $template );
	}


	/**
	 * Display doctype + <head>...</head> section
	 */
	function disp_html_head()
	{
		global $adminskins_path;
		require $adminskins_path.'_html_header.inc.php';
	}


	/**
	 * Dsiplay the top of the HTML <body>...
	 *
	 * Typically includes title, menu, messages, etc.
	 */
	function disp_body_top()
	{
		global $skins_path;

    /**
		 * @var Hit
		 */
		global $Hit;

		// #body_win and .body_firefox (for example) can be used to customize CSS per plaform/browser
		echo '<body id="body_'.$Hit->agent_platform.'" class="body_'.$Hit->agent_name.'">'."\n";

		require $skins_path.'_toolbar.inc.php';


		echo "\n";
		if( is_logged_in() )
		{
			echo '<div id="skin_wrapper" class="skin_wrapper_loggedin">';
		}
		else
		{
			echo '<div id="skin_wrapper" class="skin_wrapper_anonymous">';
		}
		echo "\n<!-- Start of skin_wrapper -->\n";

		echo $this->get_body_top();
	}

	/**
	 * Display body bottom, debug info and close </html>
	 */
	function disp_global_footer()
	{
		global $adminskins_path;

		require $adminskins_path.'_html_footer.inc.php';
	}


	/**
	 * Display the start of a payload block
	 *
	 * Note: it is possible to display several payload blocks on a single page.
	 *       The first block uses the "sub" template, the others "block".
	 *
	 * @see disp_payload_end()
	 * @todo check if the plugin event is appropriate. Maybe it should rather go as 'AdminAfterBodyTop' or sth like this.
	 */
	function disp_payload_begin()
	{
		global $Plugins;

		if( empty($this->displayed_sub_begin) )
		{
			$Plugins->trigger_event( 'AdminBeginPayload' );

			// Display submenu (this also opens a div class="panelblock" or class="panelblocktabs")

			//echo ' disp_submenu-BEGIN ';
			$path = array( $this->get_path(0) );
			$r = $this->get_html_menu( $path, 'sub' );

			echo $this->replace_vars( $r );
			//echo ' disp_submenu-END ';

			$this->displayed_sub_begin = 1;
		}
		else
		{
			$template = $this->get_template( 'block' );

			echo $template['begin'];
		}

	}


	/**
	 * Display the end of a payload block
	 *
	 * Note: it is possible to display several payload blocks on a single page.
	 *       The first block uses the "sub" template, the others "block".
	 * @see disp_payload_begin()
	 */
	function disp_payload_end()
	{
		if( empty($this->displayed_sub_end) )
		{
			$name = 'sub';
			$this->displayed_sub_end = 1;
		}
		else
		{
			$name = 'block';
		}

		$template = $this->get_template( $name );

		echo $template['end'];
	}


	/**
	 * Display a view
	 *
	 * Note: doing the require inside of a function has the side effect of forcing the view
	 * to declare any global object it wants to use. This can be a little tedious but on the
	 * other hand it has the advantage of clearly showing what objects are used and makes it
	 * easier to audit the views in order to determine if they include more business logic
	 * than they ought to.
	 *
	 * @param string
	 * @param array params to be used in the view (optional)
	 */
	function disp_view( $view_name, $view_params = array() )
	{
		global $inc_path;

		// THESE ARE THE GLOBALS WE WANT TO MAKE AVAILABLE TO ALL VIEWS:
		global $action;
		global $ctrl;

		global $DB;	// Note: not sure it's agood idea to let the views hit on the db...

		global $current_User;


		require $inc_path.$view_name;
	}


	/**
	 * Set params for blog list.
	 *
	 * @param string name of required permission needed to display the blog in the list
	 * @param string level of required permission needed to display the blog in the list
	 * @param string Url format string for elements, with %d for blog number.
	 * @param string Title for "all" button
	 * @param string URL for "all" button
	 * @param string onclick attribute format string, with %s for blog number. (NOTE: %s so that we can use this.value when selected through list)
	 */
	function set_coll_list_params( $permname = 'blog_ismember', $permlevel = 1, $url_params = array(),
							$all_title = NULL, $all_url = '', $onclick = NULL )
	{
		$this->coll_list_all_title = $all_title;
		$this->coll_list_all_url = $all_url;
		$this->coll_list_permname = $permname;
		$this->coll_list_permlevel = $permlevel;
		$this->coll_list_url_params = $url_params;
		$this->coll_list_onclick = $onclick;
	}


	/**
	 * Returns list of buttons for available Collections (aka Blogs) to work on.
	 *
	 * @return string HTML
	 */
	function get_bloglist_buttons( $title = '' )
	{
		global $current_User, $blog, $pagenow;

		$max_buttons = 7;

		if( empty( $this->coll_list_permname ) )
		{	// We have not requested a list of blogs to be displayed
			return;
		}

		// Prepare url params:
		$url_params = '?';
		$form_params = '';
		foreach( $this->coll_list_url_params as $name => $value )
		{
			$url_params .= $name.'='.$value.'&amp;';
			$form_params .= '<input type="hidden" name="'.$name.'" value="'.$value.'" />';
		}

		$template = $this->get_template( 'CollectionList' );

		$BlogCache = & get_Cache( 'BlogCache' );

		$blog_array = $BlogCache->load_user_blogs( $this->coll_list_permname, $this->coll_list_permlevel );


		$buttons = '';
		$select_options = '';
		$count = 0;
		$current_is_displayed = false;

		foreach( $blog_array as $l_blog_ID )
		{	// Loop through all blogs that match the requested permission:

			$l_Blog = & $BlogCache->get_by_ID( $l_blog_ID );

			$count++;

			if( $count < $max_buttons
					|| ($current_is_displayed && $count == $max_buttons )
					|| $l_blog_ID == $blog )
			{	// Not too many yet OR current blog, add blog as a button:
				$buttons .= $template[ $l_blog_ID == $blog ? 'beforeEachSel' : 'beforeEach' ];

				$buttons .= '<a href="'.$url_params.'blog='.$l_blog_ID
							.'" class="'.( $l_blog_ID == $blog ? 'CurrentBlog' : 'OtherBlog' ).'"';

				if( !is_null($this->coll_list_onclick) )
				{	// We want to include an onclick attribute:
					$buttons .= ' onclick="'.sprintf( $this->coll_list_onclick, $l_blog_ID ).'"';
				}

				$buttons .= '>'.$l_Blog->dget( 'shortname', 'htmlbody' ).'</a> ';

				if( $l_blog_ID == $blog )
				{
   				$current_is_displayed = true;
					$buttons .= $template['afterEachSel'];
				}
				else
				{
					$buttons .= $template['afterEach'];
				}
			}

			// Add item select list:
			$select_options .= '<option value="'.$l_blog_ID.'"';
			if( $l_blog_ID == $blog )
			{
				$select_options .= ' selected="selected"';
			}
			$select_options .= '>'.$l_Blog->dget( 'shortname', 'formvalue' ).'</option>';
		}

		$r = $template['before'];

		$r .= $title;

		if( !empty($this->coll_list_all_title) )
		{	// We want to add an "all" button
			$r .= $template[ $blog == 0 ? 'beforeEachSel' : 'beforeEach' ];
			$r .= '<a href="'.$this->coll_list_all_url
						.'" class="'.( $blog == 0 ? 'CurrentBlog' : 'OtherBlog' ).'">'
						.$this->coll_list_all_title.'</a> ';
			$r .= $template[ $blog == 0 ? 'afterEachSel' : 'afterEach' ];
		}

		$r .= $template['buttons_start'];
		$r .= $buttons;
		$r .= $template['buttons_end'];


		$r .= $template['select_start'];
		if( $count > $max_buttons )
		{	// We could not display all blogs as buttons
			$r .= '<form action="'.$pagenow.'" method="get">';
			$r .= $form_params;
			$r .= '<select name="blog" onchange="';
			if( empty( $this->coll_list_onclick ) )
			{	// Just submit...
				$r .= 'this.form.submit();';
			}
			else
			{
				$r .= sprintf( $this->coll_list_onclick, 'this.value' );
			}
			$r .= '">'.$select_options.'</select>';
			$r .= '<noscript><input type="submit" value="Go" /></noscript></form>';
		}
		$r .= $template['select_end'];


		$r .= $template['after'];

		return $r;
	}


	/**
	 * Get the HTML for the menu entries of a specific path.
	 *
	 * @param NULL|string|array The path. See {@link get_node_by_path()}.
	 * @param string Template name, see {@link get_template()}.
	 * @param int Depth (recursion)
	 * @return string The HTML for the menu.
	 */
	function get_html_menu_entries( $path, $template, $depth = 0 )
	{
		global $current_User;

		$r = '';

		$templateForLevel = $this->get_template( $template, $depth );

		if( !( $menuEntries = $this->get_menu_entries($path) ) )
		{	// No menu entries at this level
			if( isset($templateForLevel['empty']) )
			{
				$r .= $templateForLevel['empty'];
			}
		}
		else
		{	// There are entries to display:
			$r .= $templateForLevel['before'];

			$selected = $this->get_selected($path);

			foreach( $menuEntries as $loop_key => $loop_details )
			{
				$anchor = '<a href="';

				if( isset( $loop_details['href'] ) )
				{
					$anchor .= $loop_details['href'];
				}
				elseif( !empty($loop_details['href_eval']) )
				{ // Useful for passing dynamic context vars (fp>> I AM using it)
					$anchor .= eval( $loop_details['href_eval'] );
				}
				else
				{
					$anchor .= regenerate_url( 'tab', 'tab='.$loop_key );
				}
				$anchor .= '"';
				if( isset($loop_details['style']) )
				{
					$anchor .= ' style="'.$loop_details['style'].'"';
				}
				if( isset($loop_details['onclick']) )
				{
					$anchor .= ' onclick="'.$loop_details['onclick'].'"';
				}
				if( isset($loop_details['name']) )
				{
					$anchor .= ' name="'.$loop_details['name'].'"';
				}

				$anchor .= '>'.format_to_output( $loop_details['text'], 'htmlbody' )."</a>";

				if( $loop_key == $selected )
				{ // Highlight selected entry
					if( !empty( $templateForLevel['_props']['recurseSelected'] )
							&& ( $recursePath = array_merge( $path, $loop_key ) )
							&& ($this->get_menu_entries($recursePath) ) )
					{
						$r .= isset($templateForLevel['beforeEachSelWithSub'])
							? $templateForLevel['beforeEachSelWithSub']
							: $templateForLevel['beforeEachSel'];
						$r .= $anchor;

						// Recurse:
						$r .= $this->get_html_menu_entries( $recursePath, $template, $depth+1 );

						$r .= isset($templateForLevel['afterEachSelWithSub'])
							? $templateForLevel['afterEachSelWithSub']
							: $templateForLevel['afterEachSel'];
					}
					else
					{
						$r .= $templateForLevel['beforeEachSel'];
						$r .= $anchor;
						$r .= $templateForLevel['afterEachSel'];
					}
				}
				else
				{
					$r .= $templateForLevel['beforeEach'];
					$r .= $anchor;
					$r .= $templateForLevel['afterEach'];
				}
			}
			$r .= $templateForLevel['after'];
		}

		return $r;
	}


	/**
	 * Get menu entries for a given path.
	 *
	 * @param NULL|string|array The path. See {@link get_node_by_path()}.
	 * @return array The menu entries (may be empty).
	 */
	function get_menu_entries( $path )
	{
		$node = & $this->get_node_by_path( $path );

		return isset( $node['entries'] ) ? $node['entries'] : array();
	}


	/**
	 * Get the key of a selected entry for a path.
	 *
	 * @param NULL|string|array The path. See {@link get_node_by_path()}.
	 * @return string|false
	 */
	function get_selected( $path )
	{
		$node = & $this->get_node_by_path($path);

		if( isset($node['selected']) )
		{
			return $node['selected'];
		}

		return false;
	}


	/**
	 * Get the reference of a node from the menu entries using a path.
	 *
	 * @param array|string|NULL The path. NULL means root, string means child of root,
	 *                          array means path below root.
	 *                          (eg <code>array('options', 'general')</code>).
	 * @param boolean Should the node be created if it does not exist already?
	 * @return array|false The node as array or false, if the path does not exist (and we do not $createIfNotExisting).
	 */
	function & get_node_by_path( $path, $createIfNotExisting = false )
	{
		if( is_null($path) )
		{ // root element
			$path = array();
		}
		elseif( ! is_array($path) )
		{
			$path = array($path);
		}

		$node = & $this->_menus;
		foreach( $path as $lStep )
		{
			if( ! isset($node['entries'][$lStep]) )
			{
				if( $createIfNotExisting )
				{
					$node['entries'][$lStep] = array();
				}
				else
				{
					$r = false;
					return $r;
				}
			}
			$node = & $node['entries'][$lStep];
		}

		return $node;
	}


	/**
	 * Get a template by name and depth.
	 *
	 * Templates can handle multiple depth levels
	 *
	 * This is a method (and not a member array) to allow dynamic generation and T_()
	 *
	 * @param string Name of the template ('main', 'sub')
	 * @param integer Nesting level (start at 0)
	 * @return array Associative array which defines layout and optionally properties.
	 */
	function get_template( $name, $depth = 0 )
	{
		switch( $name )
		{
			case 'main':
				switch( $depth )
				{
					case 0:
						// main level
						global $app_shortname, $app_version;

						return array(
							'before' => '<div id="mainmenu"><ul>',
							'after' => '</ul></div>',
							'beforeEach' => '<li>',
							'afterEach' => '</li>',
							'beforeEachSel' => '<li class="current">',
							'afterEachSel' => '</li>',
							'beforeEachSelWithSub' => '<li class="parent">',
							'afterEachSelWithSub' => '</li>',
							'_props' => array(
								/**
								 * @todo Move to new skin (recurse for subentries if an entry is selected)
								'recurseSelected' => true,
								*/
							),
						);

					default:
						// any sublevel
						return array(
							'before' => '<ul class="submenu">',
							'after' => '</ul>',
							'beforeEach' => '<li>',
							'afterEach' => '</li>',
							'beforeEachSel' => '<li class="current">',
							'afterEachSel' => '</li>',
						);
				}

				break;


			case 'sub':
				// a payload block with embedded submenu
				return array(
						'before' => '<div class="pt">'
							."\n".'<ul class="hack">'
							."\n<li><!-- Yes, this empty UL is needed! It's a DOUBLE hack for correct CSS display --></li>"
							// TODO: this hack MAY NOT be needed when not using pixels instead of decimal ems or exs in the CSS
							."\n</ul>"
							."\n".'<div class="panelblocktabs">'
							."\n".'<ul class="tabs">',
						'after' => "</ul>\n"
							.'<span style="float:right">$global_icons$</span>'
							."</div>\n</div>"
							."\n".'<div class="tabbedpanelblock">',
						'empty' => '<div class="panelblock">',
						'beforeEach' => '<li>',
						'afterEach'  => '</li>',
						'beforeEachSel' => '<li class="current">',
						'afterEachSel' => '</li>',
						'end' => '</div>', // used to end payload block that opened submenu
					);


			case 'block':
				// an additional payload block, anywhere after the one with the submenu. Used by disp_payload_begin()/disp_payload_end()
				return array(
						'begin' => '<div class="panelblock">',
						'end' => "\n</div>",
					);


			case 'CollectionList':
				// Template for a list of Collections (Blogs)
				return array(
						'before' => '<div id="coll_list"><ul>',
						'after' => '</ul></div>',
						'buttons_start' => '',
						'buttons_end' => '',
						'beforeEach' => '<li>',
						'afterEach' => '</li>',
						'beforeEachSel' => '<li class="current">',
						'afterEachSel' => '</li>',
						'select_start' => '<li class="collection_select">',
						'select_end' => '</li>',
					);


			case 'Results':
				// Results list:
				return array(
					'page_url' => '', // All generated links will refer to the current page
					'before' => '<div class="results">',
					'header_start' => '<div class="results_nav">',
						'header_text' => '<strong>'.T_('Pages').'</strong>: $prev$ $first$ $list_prev$ $list$ $list_next$ $last$ $next$',
						'header_text_single' => '',
					'header_end' => '</div>',
					'list_start' => '<table class="grouped" cellspacing="0">'."\n\n",
						'head_start' => "<thead>\n",
							'head_title' => '<tr><th colspan="$nb_cols$" class="title"><span style="float:right">$global_icons$</span>$title$</th>'
							                ."\n</tr>\n",
							'filters_start' => '<tr class="filters"><td colspan="$nb_cols$">',
							'filters_end' => '</td></tr>',
							'line_start_head' => '<tr>',  // TODO: fusionner avec colhead_start_first; mettre a jour admin_UI_general; utiliser colspan="$headspan$"
							'colhead_start' => '<th $class_attrib$>',
							'colhead_start_first' => '<th class="firstcol $class$">',
							'colhead_start_last' => '<th class="lastcol $class$">',
							'colhead_end' => "</th>\n",
							'sort_asc_off' => '<img src="../admin/img/grey_arrow_up.gif" alt="A" title="'.T_('Ascending order')
							                    .'" height="12" width="11" />',
							'sort_asc_on' => '<img src="../admin/img/black_arrow_up.gif" alt="A" title="'.T_('Ascending order')
							                    .'" height="12" width="11" />',
							'sort_desc_off' => '<img src="../admin/img/grey_arrow_down.gif" alt="D" title="'.T_('Descending order')
							                    .'" height="12" width="11" />',
							'sort_desc_on' => '<img src="../admin/img/black_arrow_down.gif" alt="D" title="'.T_('Descending order')
							                    .'" height="12" width="11" />',
							'basic_sort_off' => '',
							'basic_sort_asc' => get_icon( 'ascending' ),
							'basic_sort_desc' => get_icon( 'descending' ),
						'head_end' => "</thead>\n\n",
						'tfoot_start' => "<tfoot>\n",
						'tfoot_end' => "</tfoot>\n\n",
						'body_start' => "<tbody>\n",
							'line_start' => '<tr class="even">'."\n",
							'line_start_odd' => '<tr class="odd">'."\n",
							'line_start_last' => '<tr class="even lastline">'."\n",
							'line_start_odd_last' => '<tr class="odd lastline">'."\n",
								'col_start' => '<td $class_attrib$>',
								'col_start_first' => '<td class="firstcol $class$">',
								'col_start_last' => '<td class="lastcol $class$">',
								'col_end' => "</td>\n",
							'line_end' => "</tr>\n\n",
							'grp_line_start' => '<tr class="group">'."\n",
							'grp_line_start_odd' => '<tr class="odd">'."\n",
							'grp_line_start_last' => '<tr class="lastline">'."\n",
							'grp_line_start_odd_last' => '<tr class="odd lastline">'."\n",
										'grp_col_start' => '<td $class_attrib$ $colspan_attrib$>',
										'grp_col_start_first' => '<td class="firstcol $class$" $colspan_attrib$>',
										'grp_col_start_last' => '<td class="lastcol $class$" $colspan_attrib$>',
								'grp_col_end' => "</td>\n",
							'grp_line_end' => "</tr>\n\n",
						'body_end' => "</tbody>\n\n",
						'total_line_start' => '<tr class="total">'."\n",
							'total_col_start' => '<td $class_attrib$>',
							'total_col_start_first' => '<td class="firstcol $class$">',
							'total_col_start_last' => '<td class="lastcol $class$">',
							'total_col_end' => "</td>\n",
						'total_line_end' => "</tr>\n\n",
					'list_end' => "</table>\n\n",
					'footer_start' => '<div class="results_nav">',
					'footer_text' => '<strong>'.T_('Pages').'</strong>: $prev$ $first$ $list_prev$ $list$ $list_next$ $last$ $next$'
					                  /* T_('Page $scroll_list$ out of $total_pages$   $prev$ | $next$<br />'. */
					                  /* '<strong>$total_pages$ Pages</strong> : $prev$ $list$ $next$' */
					                  /* .' <br />$first$  $list_prev$  $list$  $list_next$  $last$ :: $prev$ | $next$') */,
					'footer_text_single' => '',
					'footer_text_no_limit' => '', // Text if theres no LIMIT and therefor only one page anyway
						'prev_text' => T_('Previous'),
						'next_text' => T_('Next'),
						'no_prev_text' => '',
						'no_next_text' => '',
						'list_prev_text' => T_('...'),
						'list_next_text' => T_('...'),
						'list_span' => 11,
						'scroll_list_range' => 5,
					'footer_end' => "</div>\n\n",
					'no_results_start' => '<table class="grouped" cellspacing="0">'."\n\n"
								                .'<th class="title"><span style="float:right">$global_icons$</span>'
								                .'$title$</th></tr>'."\n"
								                .'<tr class="lastline"><td class="firstcol lastcol">',
					'no_results_end'   => '</td></tr>'
								                .'</table>'."\n\n",
				'after' => '</div>',
				'sort_type' => 'basic'
				);

			case 'blockspan_form':
				// blockspan Form settings:
				return array(
					'layout' => 'blockspan',		// Temporary dirty hack
					'formstart' => '',
					'title_fmt' => '$title$'."\n", // TODO: icons
					'no_title_fmt' => '',          //           "
					'fieldstart' => '<span class="block" $ID$>',
					'labelstart' => '',
					'labelend' => "\n",
					'labelempty' => '',
					'inputstart' => '',
					'infostart' => '',
					'inputend' => "\n",
					'fieldend' => '</span>'.get_icon( 'pixel' )."\n",
					'buttonsstart' => '',
					'buttonsend' => "\n",
					'formend' => '',
				);

			case 'compact_form':
			case 'Form':
				// Default Form settings:
				return array(
					'layout' => 'fieldset',
					'formstart' => '',
					'title_fmt' => '<span style="float:right">$global_icons$</span><h2>$title$</h2>'."\n",
					'no_title_fmt' => '<span style="float:right">$global_icons$</span>'."\n",
					'fieldset_begin' => '<fieldset $fieldset_attribs$>'."\n"
															.'<legend $title_attribs$>$fieldset_title$</legend>'."\n",
					'fieldset_end' => '</fieldset>'."\n",
					'fieldstart' => '<fieldset $ID$>'."\n",
					'labelstart' => '<div class="label">',
					'labelend' => "</div>\n",
					'labelempty' => '<div class="label"></div>', // so that IE6 aligns DIV.input correcctly
					'inputstart' => '<div class="input">',
					'infostart' => '<div class="info">',
					'inputend' => "</div>\n",
					'fieldend' => "</fieldset>\n\n",
					'buttonsstart' => '<fieldset><div class="input">',
					'buttonsend' => "</div></fieldset>\n\n",
					'formend' => '',
				);

			case 'file_browser':
				return array(
						'block_start' => '<div class="block_item">
															<h3><span style="float:right">$global_icons$</span>$title$</h3>',
						'block_end' => '</div>',
					);

			case 'block_item':
				return array(
						'block_start' => '<div class="block_item">
															<h3><span style="float:right">$global_icons$</span>$title$</h3>',
						'block_end' => '</div>',
					);

			case 'side_item':
				return array(
						'block_start' => '<div class="browse_side_item">
															<h3><span style="float:right">$global_icons$</span>$title$</h3>',
						'block_end' => '</div>',
					);

			default:
				debug_die( 'Unknown $name for AdminUI::get_template(): '.var_export($name, true) /* PHP 4.2 ! */ );
		}
	}


	/**
	 * Get a path key by numeric key. Starts with 0.
	 *
	 * @param integer The numeric index of the path (0 is first).
	 * @param boolean Also return properties?
	 * @return string|array|false (depends on $withProps)
	 */
	function get_path( $which, $withProps = false )
	{
		if( $which === 'last' )
		{
			$which = count($this->path)-1;
		}
		if( !isset($this->path[$which]) )
		{
			return false;
		}

		if( $withProps )
		{
			return array(
				'path' => $this->path[$which],
				'props' => isset( $this->pathProps[$which] ) ? $this->pathProps[$which] : array(),
			);
		}

		return $this->path[$which];
	}


	/**
	 * Get tghe list of path keys in a given range.
	 *
	 * @param integer start index
	 * @param integer|NULL end index (NULL means same as start index)
	 * @return array List of path keys.
	 */
	function get_path_range( $start, $end = NULL )
	{
		if( is_null($end) )
		{
			$end = $start;
		}

		$r = array();
		for( $i = $start; $i <= $end; $i++ )
		{
			$r[] = isset($this->path[$i]) ? $this->path[$i] : NULL;
		}

		return $r;
	}


	/**
	 * Set a specific path level (specific depth).
	 *
	 * First level is 0, then the first subpath/submenu is level 1, etc.
	 *
	 * E.g., if plugins.php gets called, there could be a call to
	 * $AdminUI->set_path_level( 0, 'plugins' ), which selects this entry from the menu.
	 * If a specific tab is called inside of plugins.php, there could be a call to
	 * $AdminUI->set_path_level( 1, $tab )
	 *
	 * Though, it is recommended to call the wrapper functions:
	 *  - {@link append_path_level()}
	 *  - {@link set_path()}
	 *
	 * This also marks the parent node as selected and checks for permissions.
	 *
	 * @param integer Path level to set (starts at 0)
	 * @param array Either the key of the path or an array(keyname, propsArray).
	 * @param array Properties for this path entry.
	 * @return boolean DEPRECATED True if perm granted, false if not (and we're not exiting).
	 */
	function set_path_level( $level, $pathKey, $pathProps = array() )
	{
		// Get the parent node (the level above this one):
		if( $level == 0 )
		{ // first level in menu-path: parent node is NULL
			$parentNode = & $this->get_node_by_path( NULL );
		}
		else
		{ // parent node is the trunk from root to previous level
			$parentNode = & $this->get_node_by_path( $this->get_path_range( 0, $level-1 ) );
		}
		if( ! $parentNode )
		{ // parent node does not exist:
			return false;
		}

		// Store the selected entry name in the parent node:
		$parentNode['selected'] = $pathKey;

		$this->path[$level] = $pathKey;
		$this->pathProps[$level] = $pathProps;
		// FP> WHY ON EARTH would we want to do that? $this->pathProps[$level] = array_merge( $parentNode, $pathProps );

		// pre_dump( 'set_path_level: ', $level, $pathKey, $this->pathProps[$level] );

		return true;
	}


	/**
	 * Append a selected menu entry to the current path of selected entries.
	 *
	 * @param string|array Either the key of the path or an array(keyname, propsArray).
	 */
	function append_path_level( $path, $pathProps = array() )
	{
		$search_path = $this->path;
		$search_path[] = $path;
		// auto-detect path props from menu entries
		if( $node = & $this->get_node_by_path( $search_path ) )
		{
			$pathProps = array_merge( $node, $pathProps );
		}

		// Set the path level right after the last existing one:
		return $this->set_path_level( count($this->path), $path, $pathProps );
	}


	/**
	 * Set the full selected path.
	 *
	 * For example, this selects the tab/submenu 'plugins' in the main menu 'options':
	 * <code>
	 * set_path( 'options', 'plugins' );
	 * </code>
	 *
	 * Use {@link append_path_level()} to append a single path element.
	 *
	 * This is an easy stub for {@link set_path_level()}.
	 *
	 * @param string|array,... VARIABLE NUMBER OF ARGUMENTS. Each is either the key of a path entry or an array(keyname, propsArray).
	 */
	function set_path(        )
	{
		$args = func_get_args();

		$i = 0;
		$prevPath = array();  // Remember the path we have walked through

		// Loop though all path levels to set:
		foreach( $args as $arg )
		{
			if( is_array($arg) )
			{ // Path name and properties given
				list( $pathName, $pathProps ) = $arg;
			}
			else
			{ // Just the path name
				$pathName = $arg;
				$pathProps = array();
			}

			$this->init_menus();

			if( $node = & $this->get_node_by_path( array_merge( $prevPath, array($pathName) ) ) )
			{ // the node exists in the menu entries: merge the properties
				$pathProps = array_merge( $node, $pathProps );
			}

			if( ! $this->set_path_level( $i++, $pathName, $pathProps ) )
			{
				return false;
			}

			$prevPath[] = $pathName;
		}

		return true;
	}


  /**
	 * Init the menus.
	 *
	 * Do this as late as possible. Especially after determining the blog ID we work on.
	 * This allows to check for proper permissions and build correct cross navigation links.
	 */
	function init_menus()
	{
		global $Plugins;
		global $blog, $loc_transinfo, $ctrl;
		global $Settings;
    /**
		 * @var User
		 */
		global $current_User;
		global $Blog;

		if( !empty($this->_menus) )
		{	// Already initialized!
			return;
		}


		$this->add_menu_entries(
				NULL, // root
				array(
					'dashboard' => array(
						'text' => T_('Dashboard'),
						'href' => 'admin.php?ctrl=dashboard&amp;blog='.$blog,
						'style' => 'font-weight: bold;'
						),

					'items' => array(
						'text' => T_('Posts / Comments'),
						'href' => 'admin.php?ctrl=items&amp;blog='.$blog.'&amp;filter=restore',
						// Controller may add subtabs
						),
					) );


		if( $Settings->get( 'fm_enabled' ) && $current_User->check_perm( 'files', 'view' ) )
		{	// FM enabled and permission to view files:
			$this->add_menu_entries( NULL, array(
						'files' => array(
							'text' => T_('Files'),
							'title' => T_('File management'),
							'href' => 'admin.php?ctrl=files',
							// Controller may add subtabs
						),
					) );

		}


		if( $current_User->check_perm( 'stats', 'list' ) )
		{	// Permission to view stats for user's blogs:
			if( $current_User->check_perm( 'stats', 'view' ) )
			{	// We have permission to view all stats,
				// we'll assume that we want to view th aggregate stats and not the current blog stats
				// fp> TODO: it might be useful to have a user pref for [View aggregate stats by default] vs [View current blog stats by default]
				$default = 'admin.php?ctrl=stats&amp;blog=0';
			}
			else
			{
				$default = 'admin.php?ctrl=stats';
			}
			$this->add_menu_entries(
					NULL, // root
					array(
						'stats' => array(
							'text' => T_('Stats'),
							'href' => $default,
							'entries' => array(
								'summary' => array(
									'text' => T_('Hit summary'),
									'href' => 'admin.php?ctrl=stats&amp;tab=summary&amp;blog='.$blog ),
								'browserhits' => array(
									'text' => T_('Browser hits'),
									'href' => 'admin.php?ctrl=stats&amp;tab=browserhits&amp;blog='.$blog ),
								'refsearches' => array(
									'text' => T_('Search B-hits'),
									'href' => 'admin.php?ctrl=stats&amp;tab=refsearches&amp;blog='.$blog ),
								'referers' => array(
									'text' => T_('Referered B-hits'),
									'href' => 'admin.php?ctrl=stats&amp;tab=referers&amp;blog='.$blog ),
								'other' => array(
									'text' => T_('Direct B-hits'),
									'href' => 'admin.php?ctrl=stats&amp;tab=other&amp;blog='.$blog ),
								'robots' => array(
									'text' => T_('Robot hits'),
									'href' => 'admin.php?ctrl=stats&amp;tab=robots&amp;blog='.$blog ),
								'syndication' => array(
									'text' => T_('XML hits'),
									'href' => 'admin.php?ctrl=stats&amp;tab=syndication&amp;blog='.$blog ),
								'useragents' => array(
									'text' => T_('User agents'),
									'href' => 'admin.php?ctrl=stats&amp;tab=useragents&amp;blog='.$blog ),
								'domains' => array(
									'text' => T_('Referring domains'),
									'href' => 'admin.php?ctrl=stats&amp;tab=domains&amp;blog='.$blog ),
							)
						),
					) );
		}

		if( $blog == 0 && $current_User->check_perm( 'stats', 'view' ) )
		{	// Viewing aggregate + Permission to view stats for ALL blogs:
			$this->add_menu_entries(
					'stats',
					array(
						'sessions' => array(
							'text' => T_('Sessions'),
							'href' => 'admin.php?ctrl=stats&amp;tab=sessions&amp;blog='.$blog ),
						)
				);
		}


		// BLOG SETTINGS:
		if( $ctrl == 'collections' )
		{ // We are viewing the blog list, nothing fancy involved:
			$this->add_menu_entries(
					NULL, // root
					array(
						'blogs' => array(
							'text' => T_('Blog settings'),
							'href' => 'admin.php?ctrl=collections',
						),
					) );
		}
		else
		{	// We're on any other page, we may have a direct destination
		  // + we have subtabs (fp > maybe the subtabs should go into the controller as for _items ?)

			// What perms do we have?
			$coll_settings_perm = $current_User->check_perm( 'blog_properties', 'any', false, $blog );
			$coll_chapters_perm = $current_User->check_perm( 'blog_cats', '', false, $blog );

			// Determine default page based on permissions:
			if( $coll_settings_perm )
			{	// Default: show General Blog Settings
				$default_page = 'admin.php?ctrl=coll_settings&amp;tab=general&amp;blog='.$blog;
			}
			elseif( $coll_chapters_perm )
			{	// Default: show categories
				$default_page = 'admin.php?ctrl=chapters&amp;blog='.$blog;
			}
			else
			{	// Default: Show list of blogs
				$default_page = 'admin.php?ctrl=collections';
			}

			$this->add_menu_entries(
					NULL, // root
					array(
						'blogs' => array(
							'text' => T_('Blog settings'),
							'href' => $default_page,
							),
						) );

			if( $coll_settings_perm )
			{
				$this->add_menu_entries( 'blogs',	array(
							'general' => array(
								'text' => T_('General'),
								'href' => 'admin.php?ctrl=coll_settings&amp;tab=general&amp;blog='.$blog, ),
							'features' => array(
								'text' => T_('Features'),
								'href' => 'admin.php?ctrl=coll_settings&amp;tab=features&amp;blog='.$blog, ),
							'skin' => array(
								'text' => T_('Skin'),
								'href' => 'admin.php?ctrl=coll_settings&amp;tab=skin&amp;blog='.$blog, ),
							'widgets' => array(
								'text' => T_('Widgets'),
								'href' => 'admin.php?ctrl=widgets&amp;blog='.$blog, ),
						) );
			}

			if( $coll_chapters_perm )
			{
				$this->add_menu_entries( 'blogs',	array(
							'chapters' => array(
								'text' => T_('Categories'),
								'href' => 'admin.php?ctrl=chapters&amp;blog='.$blog ),
						) );
			}

			if( $coll_settings_perm )
			{
				$this->add_menu_entries( 'blogs',	array(
							'urls' => array(
								'text' => T_('URLs'),
								'href' => 'admin.php?ctrl=coll_settings&amp;tab=urls&amp;blog='.$blog, ),
							'seo' => array(
								'text' => T_('SEO'),
								'href' => 'admin.php?ctrl=coll_settings&amp;tab=seo&amp;blog='.$blog, ),
							'advanced' => array(
								'text' => T_('Advanced'),
								'href' => 'admin.php?ctrl=coll_settings&amp;tab=advanced&amp;blog='.$blog, ),
						) );

				if( $Blog && $Blog->advanced_perms )
				{
					$this->add_menu_entries( 'blogs',	array(
								'perm' => array(
									'text' => T_('User perms'), // keep label short
									'href' => 'admin.php?ctrl=coll_settings&amp;tab=perm&amp;blog='.$blog, ),
								'permgroup' => array(
									'text' => T_('Group perms'), // keep label short
									'href' => 'admin.php?ctrl=coll_settings&amp;tab=permgroup&amp;blog='.$blog, ),
							) );
				}
			}
		}


		if( $current_User->check_perm( 'options', 'view' ) )
		{	// Permission to view settings:
			$this->add_menu_entries( NULL, array(
						'options' => array(
							'text' => T_('Global settings'),
							'href' => 'admin.php?ctrl=settings',
							'entries' => array(
								'general' => array(
									'text' => T_('General'),
									'href' => 'admin.php?ctrl=settings' ),
								'features' => array(
									'text' => T_('Features'),
									'href' => 'admin.php?ctrl=features' ),
								'skins' => array(
									'text' => T_('Skins install'),
									'href' => 'admin.php?ctrl=skins'),
								'plugins' => array(
									'text' => T_('Plugins install'),
									'href' => 'admin.php?ctrl=plugins'),
								'antispam' => array(
									'text' => T_('Antispam'),
									'href' => 'admin.php?ctrl=set_antispam'),
								'regional' => array(
									'text' => T_('Regional'),
									'href' => 'admin.php?ctrl=locales'.( (isset($loc_transinfo) && $loc_transinfo) ? '&amp;loc_transinfo=1' : '' ) ),
								'files' => array(
									'text' => T_('Files'),
									'href' => 'admin.php?ctrl=fileset' ),
								'filetypes' => array(
									'text' => T_('File types'),
									'href' => 'admin.php?ctrl=filetypes' ),
								'types' => array(
									'text' => T_('Post types'),
									'title' => T_('Post types management'),
									'href' => 'admin.php?ctrl=itemtypes'),
								'statuses' => array(
									'text' => T_('Post statuses'),
									'title' => T_('Post statuses management'),
									'href' => 'admin.php?ctrl=itemstatuses'),
							)
						),
					) );
		}


		if( $current_User->check_perm( 'users', 'view' ) )
		{	// Permission to view users:
			$this->add_menu_entries( NULL, array(
						'users' => array(
						'text' => T_('Users'),
						'title' => T_('User management'),
						'href' => 'admin.php?ctrl=users',
					),
				) );
		}
		else
		{	// Only perm to view his own profile:
			$this->add_menu_entries( NULL, array(
						'users' => array(
						'text' => T_('My profile'),
						'title' => T_('User profile'),
						'href' => 'admin.php?ctrl=users',
					),
				) );
		}


		if( $current_User->check_perm( 'options', 'view' ) )
		{	// Permission to view settings:
			// FP> This assumes that we don't let regular users access the tools, including plugin tools.
				$this->add_menu_entries( NULL, array(
						'tools' => array(
							'text' => T_('Tools'),
							'href' => 'admin.php?ctrl=crontab',
							'entries' =>  array(
								'cron' => array(
									'text' => T_('Scheduler'),
									'href' => 'admin.php?ctrl=crontab' ),
								'system' => array(
									'text' => T_('System'),
									'href' => 'admin.php?ctrl=system' ),
									),
								),
							) );

				if( $current_User->check_perm( 'spamblacklist', 'view' ) )
				{	// Permission to view antispam:
					$this->add_menu_entries( 'tools', array(
									'antispam' => array(
										'text' => T_('Antispam'),
										'href' => 'admin.php?ctrl=antispam'	),
									) );
				}

				$this->add_menu_entries( 'tools', array(
							'' => array(	// fp> '' is dirty
								'text' => T_('Misc'),
								'href' => 'admin.php?ctrl=tools' ),
						) );
		}
		elseif( $current_User->check_perm( 'spamblacklist', 'view' ) )
		{	// Permission to view antispam but NOT tools:
			// Give it it's own tab:
			$this->add_menu_entries( NULL, array(
						'tools' => array(
							'text' => T_('Tools'),
							'href' => 'admin.php?ctrl=antispam',
							'entries' =>  array(
								'antispam' => array(
									'text' => T_('Antispam'),
									'href' => 'admin.php?ctrl=antispam'	),
								),
						),
					) );
		}



		// Call AdminAfterMenuInit to notify Plugins that the menu is initialized
		// E.g. the livehits_plugin and weather_plugin use it for adding a menu entry.
		$Plugins->trigger_event( 'AdminAfterMenuInit' );
	}


	/**
	 * Get the top of the HTML <body>.
	 *
	 * @return string
	 */
	function get_body_top()
	{
		return '';
	}


	/**
	 * Get the end of the HTML <body>. Close open divs, etc...
	 *
	 * @return string
	 */
	function get_body_bottom()
	{
		return '';
	}


	/**
	 * GLOBAL HEADER - APP TITLE, LOGOUT, ETC.
	 *
	 * @return string
	 */
	function get_page_head()
	{
		global $app_shortname, $app_version, $current_User, $htsrv_url_sensitive, $admin_url, $baseurl, $rsc_url;

		$r = '
		<div id="header">
			<div id="headinfo">
				<span id="headfunctions">'
					// Note: if we log in with another user, we may not have the perms to come back to the same place any more, thus: redirect to admin home.
					.'<a href="'.$htsrv_url_sensitive.'login.php?action=logout&amp;redirect_to='.rawurlencode(url_rel_to_same_host($admin_url, $htsrv_url_sensitive)).'">'.T_('Logout').'</a>
					<img src="'.$rsc_url.'icons/close.gif" width="14" height="14" border="0" class="top" alt="" title="'
					.T_('Logout').'" /></a>
				</span>

				'.$app_shortname.' v <strong>'.$app_version.'</strong>
			</div>

			<h1>'.$this->get_title_for_titlearea().'</h1>
		</div>
		';

		return $r;
	}


  /**
	 * Get the footer text
	 */
	function get_footer_contents()
	{
		global $app_footer_text, $copyright_text;

		global $Hit;

		$r = '';

   	if( $Hit->is_winIE )
		{
		 $r .= '<!--[if lt IE 7]>
<div style="text-align:center; color:#f00; font-weight:bold; margin:1ex;">'.
			T_('WARNING: Internet Explorer 6 may not able to display this admin skin properly. We strongly recommend you upgrade to IE 7 or Firefox.').'</div>
<![endif]-->';
		}

		$r .= '<div class="footer">'.$app_footer_text.' &ndash; '.$copyright_text."</div>\n\n";

		return $r;
	}

	/**
	 * Get colors for page elements that can't be controlled by CSS (charts)
	 */
	function get_color( $what )
	{
		switch( $what )
		{
			case 'payload_background':
				return 'f1f6f8';
				break;
		}
		debug_die( 'unknown color' );
	}

}


?>
