<?php
/**
 * This file implements the UI view for the Available widgets.
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * @package admin
 *
 * @version $Id: _widget_list_available.view.php,v 1.9.2.1 2008/02/13 07:38:13 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

global $container;

echo '<h2><span class="right_icons">'.action_icon( T_('Cancel!'), 'close', regenerate_url( 'container' ) ).'</span>'
	.sprintf(T_('Widgets available for insertion into &laquo;%s&raquo;'), $container ).'</h2>';


$core_componentwidget_defs = array(
		'*'.T_('General purpose widgets'),
			'free_html',
			'coll_logo',
		'*'.T_('Different ways of listing the blog contents'),
			'coll_category_list',
			'coll_tag_cloud',
			'coll_post_list',
			'coll_page_list',
			'coll_comment_list',
			'coll_xml_feeds',
		'*'.T_('Meta info for the blog'),
			'coll_title',
			'coll_tagline',
			'coll_longdesc',
		'*'.T_('Blog navigation'),
			'menu_link',
			'coll_common_links',
			'coll_search_form',
			'user_tools',
		'*'.T_('Other'),
			'colls_list_public',
			'colls_list_owner',
			'linkblog',
	);
$i = 0;
foreach( $core_componentwidget_defs as $code )
{
	$i++;
	if( $code[0] == '*' )
	{ // group
		if( $i > 1 )
		{
			echo '</ul>';
		}
		echo '<h3>'.substr( $code, 1 ).':</h3><ul>';
	}
	else
	{
		load_class( 'widgets/widgets/_'.$code.'.widget.php' );
		$classname = $code.'_Widget';
		$ComponentWidget = & new $classname( NULL, 'core', $code );

		echo '<li>';
		echo '<a href="'.regenerate_url( '', 'action=create&amp;type=core&amp;code='.$ComponentWidget->code ).'" title="'.T_('Add this widget to the container').'">';
		echo get_icon( 'new' ).'<strong>'.$ComponentWidget->get_name().'</strong>';
		echo '</a> <span class="notes">'.$ComponentWidget->get_desc().'</span>';
		echo '</li>';
	}
}


// Now, let's try to get the Plugins that implement a skintag...
// TODO: at some point we may merge them with the above, but alphabetical order probably isn't the best solution

/**
 * @var Plugins
 */
global $Plugins;

$Plugin_array = $Plugins->get_list_by_event( 'SkinTag' );
// Remove the plugins, which have no code, because this gets used to install them:
foreach( $Plugin_array as $k => $v )
{
	if( empty($v->code) )
	{
		unset($Plugin_array[$k]);
	}
}
if( ! empty($Plugin_array) )
{ // We have some plugins

	echo '</ul>';
	echo '<h3>'.T_('Plugins').':</h3><ul>';

	foreach( $Plugin_array as $ID => $Plugin )
	{
		echo '<li>';
		echo '<a href="'.regenerate_url( '', 'action=create&amp;type=plugin&amp;code='.$Plugin->code ).'" title="'.T_('Add this widget to the container').'">';
		echo get_icon( 'new' ).'<strong>'.$Plugin->name.'</strong>';
		echo '</a> <span class="notes">'.$Plugin->short_desc.'</span>';
		echo '</li>';
	}
}
echo '</ul>';



?>