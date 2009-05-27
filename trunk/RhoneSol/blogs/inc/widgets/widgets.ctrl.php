<?php
/**
 * This file implements the UI controller for managing widgets inside of a blog.
 *
 * b2evolution - {@link http://b2evolution.net/}
 * Released under GNU GPL License - {@link http://b2evolution.net/about/license.html}
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 *
 * {@internal Open Source relicensing agreement:
 * }}
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @package admin
 *
 * @version $Id: widgets.ctrl.php,v 1.8 2008/01/21 09:35:36 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var AdminUI
 */
global $AdminUI;
/**
 * @var Plugins
 */
global $Plugins;

load_class( 'widgets/model/_widget.class.php' );

param( 'action', 'string', 'list' );

/*
 * Init the objects we want to work on.
 */
switch( $action )
{
 	case 'nil':
 	case 'list':
		// Do nothing
		break;

	case 'create':
		param( 'type', 'string', true );
		param( 'code', 'string', true );
	case 'new':
		param( 'container', 'string', true, true );	// memorize
		break;

	case 'edit':
	case 'update':
	case 'delete':
	case 'move_up':
	case 'move_down':
		param( 'wi_ID', 'integer', true );
		$WidgetCache = & get_Cache( 'WidgetCache' );
		$edited_ComponentWidget = & $WidgetCache->get_by_ID( $wi_ID );
		// Take blog from here!
		// echo $edited_ComponentWidget->coll_ID;
 		set_working_blog( $edited_ComponentWidget->coll_ID );
		$BlogCache = & get_Cache( 'BlogCache' );
		$Blog = & $BlogCache->get_by_ID( $blog );

		break;

	default:
		debug_die( 'Init objects: unhandled action' );
}

if( ! valid_blog_requested() )
{
	debug_die( 'Invalid blog requested' );
}
$current_User->check_perm( 'blog_properties', 'edit', true, $blog );

// Get Skin used by current Blog:
$SkinCache = & get_Cache( 'SkinCache' );
$Skin = & $SkinCache->get_by_ID( $Blog->skin_ID );
// Make sure containers are loaded for that skin:
$container_list = $Skin->get_containers();


/**
 * Perform action:
 */
switch( $action )
{
 	case 'nil':
 	case 'new':
 	case 'edit':
		// Do nothing
		break;

	case 'create':
		// Add a Widget to container:
		if( !in_array( $container, $container_list ) )
		{
			$Messages->add( T_('WARNING: you are adding to a container that does not seem to be part of the current skin.'), 'error' );
		}

		switch( $type )
		{
			case 'core':
				// Check the requested core widget is valid:
				load_class( 'widgets/widgets/_'.$code.'.widget.php' );
				$objtype = $code.'_Widget';
				$edited_ComponentWidget = & new $objtype();
				break;

			case 'plugin':
				if( ! $Plugin = & $Plugins->get_by_code( $code ) )
				{
					debug_die( 'Requested plugin not found' );
				}
				if( ! $Plugins->has_event( $Plugin->ID, 'SkinTag' ) )
				{
					debug_die( 'Requested plugin does not support SkinTag' );
				}
				$edited_ComponentWidget = & new ComponentWidget( NULL, 'plugin', $code, array() );
				break;

			default:
				debug_die( 'Unhandled widget type' );
		}

		$edited_ComponentWidget->set( 'coll_ID', $Blog->ID );
		$edited_ComponentWidget->set( 'sco_name', $container );

		// INSERT INTO DB:
		$edited_ComponentWidget->dbinsert();

		$Messages->add( sprintf( T_('Widget &laquo;%s&raquo; has been added to container &laquo;%s&raquo;.'),
					$edited_ComponentWidget->get_name(), T_($container)	), 'success' );

		header_redirect( '?ctrl=widgets&action=edit&wi_ID='.$edited_ComponentWidget->ID );
		break;


	case 'update':
		// Update Settings
		$edited_ComponentWidget->load_from_Request();

		if(	! param_errors_detected() )
		{	// Update settings:
			$edited_ComponentWidget->dbupdate();
			$Messages->add( T_('Widget settings have been updated'), 'success' );
			$action = 'list';
		}
		break;


	case 'move_up':
		// Move the widget up:

		$order = $edited_ComponentWidget->order;
		$DB->begin();

 		// Get the previous element
		$row = $DB->get_row( 'SELECT *
														FROM T_widget
													 WHERE wi_coll_ID = '.$Blog->ID.'
													 	 AND wi_sco_name = '.$DB->quote($edited_ComponentWidget->sco_name).'
														 AND wi_order < '.$order.'
													 ORDER BY wi_order DESC
													 LIMIT 0,1' );
		if( !empty( $row) )
		{
			$prev_ComponentWidget = & new ComponentWidget( $row );
			$prev_order = $prev_ComponentWidget->order;

			$edited_ComponentWidget->set( 'order', 0 );	// Temporary
			$edited_ComponentWidget->dbupdate();

			$prev_ComponentWidget->set( 'order', $order );
			$prev_ComponentWidget->dbupdate();

			$edited_ComponentWidget->set( 'order', $prev_order );
			$edited_ComponentWidget->dbupdate();

		}
		$DB->commit();
		break;

	case 'move_down':
		// Move the widget down:

		$order = $edited_ComponentWidget->order;
		$DB->begin();

 		// Get the next element
		$row = $DB->get_row( 'SELECT *
														FROM T_widget
													 WHERE wi_coll_ID = '.$Blog->ID.'
													 	 AND wi_sco_name = '.$DB->quote($edited_ComponentWidget->sco_name).'
														 AND wi_order > '.$order.'
													 ORDER BY wi_order ASC
													 LIMIT 0,1' );
		if( !empty( $row) )
		{
			$next_ComponentWidget = & new ComponentWidget( $row );
			$next_order = $next_ComponentWidget->order;

			$edited_ComponentWidget->set( 'order', 0 );	// Temporary
			$edited_ComponentWidget->dbupdate();

			$next_ComponentWidget->set( 'order', $order );
			$next_ComponentWidget->dbupdate();

			$edited_ComponentWidget->set( 'order', $next_order );
			$edited_ComponentWidget->dbupdate();

		}
		$DB->commit();
		break;

	case 'delete':
		// Remove a widget from container:
		$msg = sprintf( T_('Widget &laquo;%s&raquo; removed.'), $edited_ComponentWidget->get_name() );
		$edited_ComponentWidget->dbdelete( true );
		unset( $edited_ComponentWidget );
		forget_param( 'wi_ID' );
		$Messages->add( $msg, 'success' );

		// PREVENT RELOAD & Switch to list mode:
		header_redirect( '?ctrl=widgets&blog='.$blog );
		break;

 	case 'list':
		break;

	default:
		debug_die( 'Action: unhandled action' );
}


/**
 * Display page header, menus & messages:
 */
$AdminUI->set_coll_list_params( 'blog_properties', 'edit', array( 'ctrl' => 'widgets' ),
			T_('List'), '?ctrl=collections&amp;blog=0' );

$AdminUI->set_path( 'blogs', 'widgets' );

// Display <html><head>...</head> section! (Note: should be done early if actions do not redirect)
$AdminUI->disp_html_head();

// Display title, menu, messages, etc. (Note: messages MUST be displayed AFTER the actions)
$AdminUI->disp_body_top();


/**
 * Display payload:
 */
switch( $action )
{
	case 'nil':
		// Do nothing
		break;


	case 'new':
		// Begin payload block:
		$AdminUI->disp_payload_begin();

		// Display VIEW:
		$AdminUI->disp_view( 'widgets/views/_widget_list_available.view.php' );

		// End payload block:
		$AdminUI->disp_payload_end();
		break;


	case 'edit':
	case 'update':	// on error
		// Begin payload block:
		$AdminUI->disp_payload_begin();

		// Display VIEW:
		$AdminUI->disp_view( 'widgets/views/_widget.form.php' );


		// End payload block:
		$AdminUI->disp_payload_end();
		break;


	case 'list':
	default:
		// Begin payload block:
		$AdminUI->disp_payload_begin();

		// Display VIEW:
		$AdminUI->disp_view( 'widgets/views/_widget_list.view.php' );

		// End payload block:
		$AdminUI->disp_payload_end();
		break;
}

// Display body bottom, debug info and close </html>:
$AdminUI->disp_global_footer();



?>