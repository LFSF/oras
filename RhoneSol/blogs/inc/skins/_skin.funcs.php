<?php
/**
 * This file implements Template tags for use withing skins.
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2004-2005 by Daniel HAHLER - {@link http://thequod.de/contact}.
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
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _skin.funcs.php,v 1.24.2.1 2008/04/26 22:28:53 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * Template tag. Initializes internal states for the most common skin displays.
 *
 * For more specific skins, this function should not be called and
 * equivalent code should be customized within the skin.
 *
 * @param string What are we going to display. Most of the time the global $disp should be passed.
 */
function skin_init( $disp )
{
	/**
	 * @var Blog
	 */
	global $Blog;

	global $robots_index;
	global $seo_page_type;

	global $redir, $ReqHost, $ReqURI;

	global $Chapter;
	global $Debuglog;

	/**
	 * @var ItemList2
	 */
	global $MainList;

	/**
	 * This will give more detail when $disp == 'posts'; otherwise it will have the same content as $disp
	 * @var string
	 */
	global $disp_detail;

	$disp_detail = $disp;

	$Debuglog->add('skin_init: '.$disp, 'skin');

	// This is the main template; it may be used to display very different things.
	// Do inits depending on current $disp:
	switch( $disp )
	{
		case 'posts':
		case 'single':
		case 'page':
		case 'feedback-popup':
			// We need to load posts for this display:

			// Note: even if we request the same post as $Item above, the following will do more restrictions (dates, etc.)
			// Init the MainList object:
			init_MainList( $Blog->get_setting('posts_per_page') );
			break;
	}

	// SEO stuff:
	$seo_page_type = NULL;
	switch( $disp )
	{
		// CONTENT PAGES:
		case 'single':
			$seo_page_type = 'Single post page';
			break;

		case 'page':
			$seo_page_type = '"Page" page';
			break;

		case 'posts':
			// Get list of active filters:
			$active_filters = $MainList->get_active_filters();

			if( !empty($active_filters) )
			{	// The current page is being filtered...

				if( array_diff( $active_filters, array( 'page' ) ) == array() )
				{ // This is just a follow "paged" page
					$disp_detail = 'posts-next';
					$seo_page_type = 'Next page';
					if( $Blog->get_setting( 'paged_noindex' ) )
					{	// We prefer robots not to index category pages:
						$robots_index = false;
					}
				}
				elseif( array_diff( $active_filters, array( 'cat_array', 'cat_modifier', 'cat_focus', 'posts', 'page' ) ) == array() )
				{ // This is a category page
					$disp_detail = 'posts-cat';
					$seo_page_type = 'Category page';
					if( $Blog->get_setting( 'chapter_noindex' ) )
					{	// We prefer robots not to index category pages:
						$robots_index = false;
					}

					global $cat, $catsel;
					if( empty( $catsel ) && preg_match( '�[0-9]+�', $cat ) )
					{	// We are on a single cat page:
						// NOTE: we must have selected EXACTLY ONE CATEGORY through the cat parameter
						// BUT: - this can resolved to including children
						//      - selecting exactly one cat through catsel[] is NOT OK since not equivalent (will exclude children)
						// echo 'SINGLE CAT PAGE';
						if( $Blog->get_setting( 'canonical_cat_urls' ) && $redir == 'yes' )
						{ // Check if the URL was canonical:
					    if( !isset( $Chapter ) )
					    {
								$ChapterCache = & get_Cache( 'ChapterCache' );
                /**
								 * @var Chapter
								 */
								$Chapter = & $ChapterCache->get_by_ID( $MainList->filters['cat_array'][0], false );
					    }
							$canoncical_url = $Chapter->get_permanent_url( NULL, NULL, $MainList->get_active_filter('page'), NULL, '&' );
							if( $ReqHost.$ReqURI != $canoncical_url )
							{
								// REDIRECT TO THE CANONICAL URL:
								// fp> TODO: we're going to lose the additional params, it would be better to keep them...
								// fp> what additional params actually?
								header_redirect( $canoncical_url, true );
							}
					  }
					}
				}
				elseif( array_diff( $active_filters, array( 'tags', 'posts', 'page' ) ) == array() )
				{ // This is a tag page
					$disp_detail = 'posts-tag';
					$seo_page_type = 'Tag page';
					if( $Blog->get_setting( 'tag_noindex' ) )
					{	// We prefer robots not to index tag pages:
						$robots_index = false;
					}

					if( $Blog->get_setting( 'canonical_tag_urls' ) && $redir == 'yes' )
					{ // Check if the URL was canonical:
						$canoncical_url = $Blog->gen_tag_url( $MainList->get_active_filter('tags'), $MainList->get_active_filter('page'), '&' );
						if( $ReqHost.$ReqURI != $canoncical_url )
						{
							// REDIRECT TO THE CANONICAL URL:
							// fp> TODO: we're going to lose the additional params, it would be better to keep them...
							// fp> what additional params actually?
							header_redirect( $canoncical_url, true );
						}
					}
				}
				elseif( array_diff( $active_filters, array( 'ymdhms', 'week', 'page' ) ) == array() )
				{ // This is an archive page
					// echo 'archive page';
					$disp_detail = 'posts-date';
					$seo_page_type = 'Date archive page';
					if( $Blog->get_setting( 'archive_noindex' ) )
					{	// We prefer robots not to index archive pages:
						$robots_index = false;
					}
				}
				else
				{	// Other filtered pages:
					$disp_detail = 'posts-filtered';
					$seo_page_type = 'Other filtered page';
					if( $Blog->get_setting( 'filtered_noindex' ) )
					{	// We prefer robots not to index other filtered pages:
						$robots_index = false;
					}
				}
			}
			else
			{	// This is the default blog page
				$disp_detail = 'posts-default';
				$seo_page_type = 'Default page';
				if( $Blog->get_setting( 'default_noindex' ) )
				{	// We prefer robots not to index archive pages:
					$robots_index = false;
				}
			}

			break;

		// SPECIAL FEATURE PAGES:
		case 'feedback-popup':
			$seo_page_type = 'Comment popup';
			if( $Blog->get_setting( $disp.'_noindex' ) )
			{	// We prefer robots not to index these pages:
				$robots_index = false;
			}
			break;

		case 'arcdir':
			$seo_page_type = 'Date archive directory';
			if( $Blog->get_setting( $disp.'_noindex' ) )
			{	// We prefer robots not to index these pages:
				$robots_index = false;
			}
			break;

		case 'catdir':
			$seo_page_type = 'Category directory';
			if( $Blog->get_setting( $disp.'_noindex' ) )
			{	// We prefer robots not to index these pages:
				$robots_index = false;
			}
			break;

		case 'msgform':
			$seo_page_type = 'Contact form';
			if( $Blog->get_setting( $disp.'_noindex' ) )
			{	// We prefer robots not to index these pages:
				$robots_index = false;
			}
			break;

		case 'profile':
		case 'subs':
			$seo_page_type = 'Special feature page';
			if( $Blog->get_setting( 'special_noindex' ) )
			{	// We prefer robots not to index these pages:
				$robots_index = false;
			}
			break;
	}

	// dummy var for backward compatibility with versions < 2.4.1 -- prevents "Undefined variable"
	Global $global_Cache, $credit_links;
	$credit_links = $global_Cache->get( 'creds' );
}


/**
 * Tells if we are on the default blog page
 *
 * @return boolean
 */
function is_default_page()
{
	global $disp_detail;
	return ($disp_detail == 'posts-default' );
}


/**
 * Template tag. Include a sub-template at the current position
 *
 * @todo plugin hook to handle a special disp
 */
function skin_include( $template_name, $params = array() )
{
	global $skins_path, $ads_current_skin_path, $disp;

	// Globals that may be needed by the template:
	global $Blog, $MainList, $Item;
	global $Plugins, $Skin;
	global $current_User, $Hit, $Session, $Settings;
	global $skin_url, $htsrv_url, $htsrv_url_sensitive;
	global $credit_links, $skin_links, $francois_links, $fplanque_links, $skinfaktory_links;

	if( $template_name == '$disp$' )
	{ // This is a special case.
		// We are going to include a template based on $disp:

		// Default display handlers:
		$disp_handlers = array_merge( array(
				'disp_arcdir'         => '_arcdir.disp.php',
				'disp_catdir'         => '_catdir.disp.php',
				'disp_comments'       => '_comments.disp.php',
				'disp_feedback-popup' => '_feedback_popup.disp.php',
				'disp_mediaidx'       => '_mediaidx.disp.php',
				'disp_msgform'        => '_msgform.disp.php',
				'disp_page'           => '_page.disp.php',
				'disp_posts'          => '_posts.disp.php',
				'disp_profile'        => '_profile.disp.php',
				'disp_single'         => '_single.disp.php',
				'disp_subs'           => '_subs.disp.php',
			), $params );

		if( !isset( $disp_handlers['disp_'.$disp] ) )
		{
			printf( '<div class="skin_error">Unhandled disp type [%s]</div>', $disp );
			return;
		}

		$template_name = $disp_handlers['disp_'.$disp];

		if( empty( $template_name ) )
		{	// The caller asked not to display this handler
			return;
		}
	}

	if( file_exists( $ads_current_skin_path.$template_name ) )
	{	// The skin has a customized handler, use that one instead:
		require $ads_current_skin_path.$template_name;
	}
	elseif( file_exists( $skins_path.$template_name ) )
	{	// Use the default template:
		require $skins_path.$template_name;
	}
	else
	{
		printf( '<div class="skin_error">Sub template [%s] not found.</div>', $template_name );
		if( !empty($current_User) && $current_User->level == 10 )
		{
			printf( '<div class="skin_error">User level 10 help info: [%s]</div>', $ads_current_skin_path.$template_name );
		}
	}
}


/**
 * Template tag. Output HTML base tag to current skin.
 *
 * This is needed for relative css and img includes.
 */
function skin_base_tag()
{
	global $skins_url, $skin, $Blog, $disp;

	if( ! empty( $skin ) )
	{
		$base_href = $skins_url.$skin.'/';
	}
	else
	{ // No skin used:
		if( ! empty( $Blog ) )
		{
			$base_href = $Blog->gen_baseurl();
		}
		else
		{
			global $baseurl;
			$base_href = $baseurl;
		}
	}

	$target = NULL;
	if( !empty($disp) && strpos( $disp, '-popup' ) )
	{	// We are (normally) displaying in a popup window, we need most links to open a new window!
		$target = '_blank';
	}

	base_tag( $base_href, $target );
}


/**
 * Template tag. Output content-type header
 *
 * We use this method when we are NOT generating a static page
 *
 * @see skin_content_meta()
 *
 * @param string content-type; override for RSS feeds
 */
function skin_content_header( $type = 'text/html' )
{
	global $generating_static, $io_charset;

	if( empty($generating_static) )
	{	// We use this method when we are NOT generating a static page
		header( 'Content-type: '.$type.'; charset='.$io_charset );
	}
}


/**
 * Template tag. Output content-type http_equiv meta tag
 *
 * We use this method when we ARE generating a static page
 *
 * @see skin_content_header()
 *
 * @param string content-type; override for RSS feeds
 */
function skin_content_meta( $type = 'text/html' )
{
	global $generating_static, $io_charset;

	if( ! empty($generating_static) )
	{	// We use this method when we ARE generating a static page
		echo '<meta http-equiv="Content-Type" content="'.$type.'; charset='.$io_charset.'" />';
	}
}


/**
 * Template tag. Display a Widget.
 *
 * This load the widget class, instantiates it, and displays it.
 *
 * @param array
 */
function skin_widget( $params )
{
	if( empty( $params['widget'] ) )
	{
		echo 'No widget code provided!';
		return false;
	}

	$widget_code = $params['widget'];
	unset( $params['widget'] );

	if( ! load_class( 'widgets/widgets/_'.$widget_code.'.widget.php', false ) )
	{	// For some reason, that widget doesn't seem to exist... (any more?)
		echo "Invalid widget code provided [$widget_code]!";
		return false;
	}

	$widget_classname = $widget_code.'_Widget';

  /**
	 * @var ComponentWidget
	 */
	$Widget = new $widget_classname();	// COPY !!

	return $Widget->display( $params );
}


/**
	 * Display a container
	 *
	 * @param string
	 * @param array
 */
function skin_container( $sco_name, $params = array() )
{
	global $Skin;

	$Skin->container( $sco_name, $params );
}

/**
 * Checks if a skin is provided by a plugin.
 *
 * Used by front-end.
 *
 * @uses Plugin::GetProvidedSkins()
 * @return false|integer False in case no plugin provides the skin or ID of the first plugin that provides it.
 */
function skin_provided_by_plugin( $name )
{
	static $plugin_skins;
	if( ! isset($plugin_skins) || ! isset($plugin_skins[$name]) )
	{
		global $Plugins;

		$plugin_r = $Plugins->trigger_event_first_return('GetProvidedSkins', NULL, array('in_array'=>$name));
		if( $plugin_r )
		{
			$plugin_skins[$name] = $plugin_r['plugin_ID'];
		}
		else
		{
			$plugin_skins[$name] = false;
		}
	}

	return $plugin_skins[$name];
}


/**
 * Checks if a skin exists. This can either be a regular skin directory
 * or can be in the list {@link Plugin::GetProvidedSkins()}.
 *
 * Used by front-end.
 *
 * @param skin name (directory name)
 * @return boolean true is exists, false if not
 */
function skin_exists( $name, $filename = 'index.main.php' )
{
	global $skins_path;

	if( is_readable( $skins_path.$name.'/'.$filename ) )
	{
		return true;
	}

	// Check list provided by plugins:
	if( skin_provided_by_plugin($name) )
	{
		return true;
	}

	return false;
}





?>
