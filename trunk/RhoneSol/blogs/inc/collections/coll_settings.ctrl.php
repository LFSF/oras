<?php
/**
 * This file implements the UI controller for blog params management, including permissions.
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
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @todo (sessions) When creating a blog, provide "edit options" (3 tabs) instead of a single long "New" form (storing the new Blog object with the session data).
 * @todo Currently if you change the name of a blog it gets not reflected in the blog list buttons!
 *
 * @version $Id: coll_settings.ctrl.php,v 1.11 2008/01/21 09:35:26 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

param_action( 'edit' );
param( 'tab', 'string', 'general', true );

// Check permissions on requested blog and autoselect an appropriate blog if necessary.
// This will prevent a fat error when switching tabs and you have restricted perms on blog properties.
if( $selected = autoselect_blog( 'blog_properties', 'edit' ) ) // Includes perm check
{	// We have a blog to work on:

	if( set_working_blog( $selected ) )	// set $blog & memorize in user prefs
	{	// Selected a new blog:
		$BlogCache = & get_Cache( 'BlogCache' );
		$Blog = & $BlogCache->get_by_ID( $blog );
	}

	/**
	 * @var Blog
	 */
	$edited_Blog = & $Blog;
}
else
{	// We could not find a blog we have edit perms on...
	// Note: we may still have permission to edit categories!!
	// redirect to blog list:
	header_redirect( '?ctrl=collections' );
	// EXITED:
	$Messages->add( T_('Sorry, you have no permission to edit blog properties.'), 'error' );
	$action = 'nil';
	$tab = '';
}

memorize_param( 'blog', 'integer', -1 );	// Needed when generating static page for example

if( ( $tab == 'perm' || $tab == 'permgroup' )
	&& ( empty($blog) || ! $Blog->advanced_perms ) )
{	// We're trying to access advanced perms but they're disabled!
	$tab = 'features';	// the screen where you can enable advanced perms
	if( $action == 'update' )
	{ // make sure we don't update anything here
		$action = 'edit';
	}
}


/**
 * Perform action:
 */
switch( $action )
{
	case 'edit':
	case 'filter1':
	case 'filter2':
		// Edit collection form (depending on tab):
		// Check permissions:
		$current_User->check_perm( 'blog_properties', 'edit', true, $blog );

		param( 'preset', 'string', '' );

		$edited_Blog->load_presets( $preset );

		break;

	case 'update':
		// Update DB:
		// Check permissions:
		$current_User->check_perm( 'blog_properties', 'edit', true, $blog );

		switch( $tab )
		{
			case 'general':
			case 'urls':
				if( $edited_Blog->load_from_Request( array() ) )
				{ // Commit update to the DB:
					$edited_Blog->dbupdate();
					$Messages->add( T_('The blog settings have been updated'), 'success' );
				}
				break;

			case 'features':
				if( $edited_Blog->load_from_Request( array( 'features' ) ) )
				{ // Commit update to the DB:
					$edited_Blog->dbupdate();
					$Messages->add( T_('The blog settings have been updated'), 'success' );
				}
				break;

			case 'seo':
				if( $edited_Blog->load_from_Request( array( 'seo' ) ) )
				{ // Commit update to the DB:
					$edited_Blog->dbupdate();
					$Messages->add( T_('The blog settings have been updated'), 'success' );
				}
				break;

			case 'skin':
				if( $edited_Blog->load_from_Request( array() ) )
				{ // Commit update to the DB:
					$edited_Blog->dbupdate();
					$Messages->add( T_('The blog skin has been changed.')
										.' <a href="'.$admin_url.'?ctrl=coll_settings&tab=skin&blog='.$edited_Blog->ID.'">'.T_('Edit...').'</a>', 'success' );
					header_redirect( $edited_Blog->gen_blogurl() );
				}
				break;

			case 'advanced':
				if( $edited_Blog->load_from_Request( array( 'pings' ) ) )
				{ // Commit update to the DB:
					$edited_Blog->dbupdate();
					$Messages->add( T_('The blog settings have been updated'), 'success' );
				}
				break;

			case 'perm':
				blog_update_perms( $blog, 'user' );
				$Messages->add( T_('The blog permissions have been updated'), 'success' );
				break;

			case 'permgroup':
				blog_update_perms( $blog, 'group' );
				$Messages->add( T_('The blog permissions have been updated'), 'success' );
				break;
		}

		break;
}

$AdminUI->set_path( 'blogs',  $tab  );


/**
 * Display page header, menus & messages:
 */
$AdminUI->set_coll_list_params( 'blog_properties', 'edit',
											array( 'ctrl' => 'coll_settings', 'tab' => $tab, 'action' => 'edit' ),
											T_('List'), '?ctrl=collections&amp;blog=0' );

// Display <html><head>...</head> section! (Note: should be done early if actions do not redirect)
$AdminUI->disp_html_head();

// Display title, menu, messages, etc. (Note: messages MUST be displayed AFTER the actions)
$AdminUI->disp_body_top();


// Begin payload block:
$AdminUI->disp_payload_begin();


// Display VIEW:
switch( $AdminUI->get_path(1) )
{
	case 'general':
		$next_action = 'update';
		$AdminUI->disp_view( 'collections/views/_coll_general.form.php' );
		break;

	case 'features':
		$AdminUI->disp_view( 'collections/views/_coll_features.form.php' );
		break;

	case 'skin':
		$AdminUI->disp_view( 'skins/views/_coll_skin.view.php' );
		break;

	case 'urls':
		$AdminUI->disp_view( 'collections/views/_coll_urls.form.php' );
		break;

	case 'seo':
		$AdminUI->disp_view( 'collections/views/_coll_seo.form.php' );
		break;

	case 'advanced':
		$AdminUI->disp_view( 'collections/views/_coll_advanced.form.php' );
		break;

	case 'perm':
		$AdminUI->disp_view( 'collections/views/_coll_user_perm.form.php' );
		break;

	case 'permgroup':
		$AdminUI->disp_view( 'collections/views/_coll_group_perm.form.php' );
		break;
}

// End payload block:
$AdminUI->disp_payload_end();


// Display body bottom, debug info and close </html>:
$AdminUI->disp_global_footer();



?>