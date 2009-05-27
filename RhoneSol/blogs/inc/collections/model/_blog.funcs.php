<?php
/**
 * This file implements Blog handling functions.
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
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _blog.funcs.php,v 1.3 2008/01/22 18:47:32 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * Update the advanced user/group permissions for edited blog
 *
 * @param int Blog ID
 * @param string 'user' or 'group'
 */
function blog_update_perms( $blog, $context = 'user' )
{
	global $DB;

  /**
	 * @var User
	 */
	global $current_User;

	if( $context == 'user' )
	{
		$table = 'T_coll_user_perms';
		$prefix = 'bloguser_';
		$ID_field = 'bloguser_user_ID';
	}
	else
	{
		$table = 'T_coll_group_perms';
		$prefix = 'bloggroup_';
		$ID_field = 'bloggroup_group_ID';
	}

	// Get affected user/group IDs:
	$IDs = param( $context.'_IDs', '/^[0-9]+(,[0-9]+)*$/', '' );
	$ID_array = explode( ',', $IDs );
	// pre_dump( $ID_array );

	// Can the current user touch advanced admin permissions?
	if( ! $current_User->check_perm( 'blog_admin', 'edit', false, $blog ) )
	{	// We have no permission to touch advanced admins!
		// echo 'restrict';

		// Get the users/groups which are adavnced admins
		$admins_ID_array = $DB->get_col( "SELECT {$ID_field}
																				FROM $table
																			 WHERE {$ID_field} IN (".implode(',',$ID_array).")
																							AND {$prefix}blog_ID = $blog
																							AND {$prefix}perm_admin <> 0" );

		// Take the admins out of the list:
		$ID_array = array_diff( $ID_array, $admins_ID_array );
		// pre_dump( $ID_array );
	}
	// else echo 'adv admin';

	if( empty( $ID_array ) )
	{
		return;
	}

	// Delete old perms for this blog:
	$DB->query( "DELETE FROM $table
								WHERE {$ID_field} IN (".implode(',',$ID_array).")
											AND {$prefix}blog_ID = ".$blog );

	$inserted_values = array();
	foreach( $ID_array as $loop_ID )
	{ // Check new permissions for each user:
		// echo "<br/>getting perms for $ID_field : $loop_ID <br />";

		$easy_mode = param( 'blog_perm_easy_'.$loop_ID, 'string', 'nomember' );

		if( $easy_mode != 'nomember' && $easy_mode != 'custom' )
		{
			$easy_perms = array(
				'bloguser_ismember' => 0,
				'bloguser_perm_poststatuses' => array(),
				'bloguser_perm_delpost' => 0,
				'bloguser_perm_comments' => 0,
				'bloguser_perm_media_upload' => 0,
				'bloguser_perm_media_browse' => 0,
				'bloguser_perm_media_change' => 0,
				'bloguser_perm_admin' => 0,
				'bloguser_perm_properties' => 0,
				'bloguser_perm_cats' => 0
			);

			if( ! $current_User->check_perm( 'blog_admin', 'edit', false, $blog )
				 && $easy_mode == 'admin' )
			{	// We have no permission to give advanced admins perm!
				$easy_mode = 'owner';
			}
			// echo $easy_mode;

			// Select option
			switch( $easy_mode )
			{
				case 'admin':
				case 'owner':
					$easy_perms['bloguser_perm_edit'] = 'all';
					break;

				case 'moderator':
					$easy_perms['bloguser_perm_edit'] = 'lt';
					break;

				case 'editor':
				case 'contrib':
					$easy_perms['bloguser_perm_edit'] = 'own';
					break;

				case 'member':
				default:
					$easy_perms['bloguser_perm_edit'] = 'no';
					break;
			}

			switch( $easy_mode )
			{
				case 'admin':
					$easy_perms['bloguser_perm_admin'] = 1;

				case 'owner':
					$easy_perms['bloguser_perm_properties'] = 1;
					$easy_perms['bloguser_perm_cats'] = 1;
					$easy_perms['bloguser_perm_delpost'] = 1;

				case 'moderator':
					$easy_perms['bloguser_perm_poststatuses'][] = 'redirected';
					$easy_perms['bloguser_perm_comments'] = 1;
					$easy_perms['bloguser_perm_media_upload'] = 1;
					$easy_perms['bloguser_perm_media_browse'] = 1;
					$easy_perms['bloguser_perm_media_change'] = 1;

				case 'editor':
					$easy_perms['bloguser_perm_poststatuses'][] = 'deprecated';
					$easy_perms['bloguser_perm_poststatuses'][] = 'protected';
					$easy_perms['bloguser_perm_poststatuses'][] = 'published';

				case 'contrib':
					$easy_perms['bloguser_perm_poststatuses'][] = 'draft';
					$easy_perms['bloguser_perm_poststatuses'][] = 'private';
					$easy_perms['bloguser_perm_media_upload'] = 1;
					$easy_perms['bloguser_perm_media_browse'] = 1;

				case 'member':
					$easy_perms['bloguser_ismember'] = 1;
					break;

				default:
					die( 'unhandled easy mode' );
			}

			$easy_perms['bloguser_perm_poststatuses'] = implode( ',', $easy_perms['bloguser_perm_poststatuses'] );

			$inserted_values[] = " ( $blog, $loop_ID, ".$easy_perms['bloguser_ismember']
														.', '.$DB->quote($easy_perms['bloguser_perm_poststatuses'])
														.', '.$DB->quote($easy_perms['bloguser_perm_edit'])
														.', '.$easy_perms['bloguser_perm_delpost'].', '.$easy_perms['bloguser_perm_comments']
														.', '.$easy_perms['bloguser_perm_cats'].', '.$easy_perms['bloguser_perm_properties']
														.', '.$easy_perms['bloguser_perm_admin']
														.', '.$easy_perms['bloguser_perm_media_upload'].', '.$easy_perms['bloguser_perm_media_browse']
														.', '.$easy_perms['bloguser_perm_media_change'].' ) ';
		}
		else
		{	// Use checkboxes
			$perm_post = array();

			$ismember = param( 'blog_ismember_'.$loop_ID, 'integer', 0 );

			$perm_published = param( 'blog_perm_published_'.$loop_ID, 'string', '' );
			if( !empty($perm_published) ) $perm_post[] = 'published';

			$perm_protected = param( 'blog_perm_protected_'.$loop_ID, 'string', '' );
			if( !empty($perm_protected) ) $perm_post[] = 'protected';

			$perm_private = param( 'blog_perm_private_'.$loop_ID, 'string', '' );
			if( !empty($perm_private) ) $perm_post[] = 'private';

			$perm_draft = param( 'blog_perm_draft_'.$loop_ID, 'string', '' );
			if( !empty($perm_draft) ) $perm_post[] = 'draft';

			$perm_deprecated = param( 'blog_perm_deprecated_'.$loop_ID, 'string', '' );
			if( !empty($perm_deprecated) ) $perm_post[] = 'deprecated';

			$perm_redirected = param( 'blog_perm_redirected_'.$loop_ID, 'string', '' );
			if( !empty($perm_redirected) ) $perm_post[] = 'redirected';

			$perm_edit = param( 'blog_perm_edit_'.$loop_ID, 'string', 'no' );

			$perm_delpost = param( 'blog_perm_delpost_'.$loop_ID, 'integer', 0 );
			$perm_comments = param( 'blog_perm_comments_'.$loop_ID, 'integer', 0 );
			$perm_cats = param( 'blog_perm_cats_'.$loop_ID, 'integer', 0 );
			$perm_properties = param( 'blog_perm_properties_'.$loop_ID, 'integer', 0 );

			if( $current_User->check_perm( 'blog_admin', 'edit', false, $blog ) )
			{	// We have permission to give advanced admins perm!
				$perm_admin = param( 'blog_perm_admin_'.$loop_ID, 'integer', 0 );
			}
			else
			{
				$perm_admin = 0;
			}

			$perm_media_upload = param( 'blog_perm_media_upload_'.$loop_ID, 'integer', 0 );
			$perm_media_browse = param( 'blog_perm_media_browse_'.$loop_ID, 'integer', 0 );
			$perm_media_change = param( 'blog_perm_media_change_'.$loop_ID, 'integer', 0 );

			// Update those permissions in DB:

			if( $ismember || count($perm_post) || $perm_delpost || $perm_comments || $perm_cats || $perm_properties
										|| $perm_admin || $perm_media_upload || $perm_media_browse || $perm_media_change )
			{ // There are some permissions for this user:
				$ismember = 1;	// Must have this permission

				// insert new perms:
				$inserted_values[] = " ( $blog, $loop_ID, $ismember, ".$DB->quote(implode(',',$perm_post)).",
																	".$DB->quote($perm_edit).",
																	$perm_delpost, $perm_comments, $perm_cats, $perm_properties, $perm_admin,
																	$perm_media_upload, $perm_media_browse, $perm_media_change )";
			}
		}
	}

	// Proceed with insertions:
	if( count( $inserted_values ) )
	{
		$DB->query( "INSERT INTO $table( {$prefix}blog_ID, {$ID_field}, {$prefix}ismember,
											{$prefix}perm_poststatuses, {$prefix}perm_edit, {$prefix}perm_delpost, {$prefix}perm_comments,
											{$prefix}perm_cats, {$prefix}perm_properties, {$prefix}perm_admin,
											{$prefix}perm_media_upload, {$prefix}perm_media_browse, {$prefix}perm_media_change)
									VALUES ".implode( ',', $inserted_values ) );
	}
}


/**
 * Translates an given array of permissions to an "easy group".
 *
 * USES OBJECT ROW
 *
 * - nomember
 * - member
 * - editor (member+edit posts+delete+edit comments+all filemanager rights)
 * - administrator (editor+edit cats+edit blog)
 * - custom
 *
 * @param array indexed, as the result row from "SELECT * FROM T_coll_user_perms"
 * @return string one of the five groups (nomember, member, editor, admin, custom)
 */
function blogperms_get_easy2( $perms, $context = 'user' )
{
	if( !isset($perms->{'blog'.$context.'_ismember'}) )
	{
		return 'nomember';
	}

	if( !empty( $perms->{'blog'.$context.'_perm_poststatuses'} ) )
	{
		$perms_post = explode( ',', $perms->{'blog'.$context.'_perm_poststatuses'} );
	}
	else
	{
		$perms_post = array();
	}

	$perms_contrib =  (in_array( 'draft', $perms_post ) ? 1 : 0)
									+ (in_array( 'private', $perms_post ) ? 1 : 0)
									+(int)$perms->{'blog'.$context.'_perm_media_upload'}
									+(int)$perms->{'blog'.$context.'_perm_media_browse'};

	$perms_editor =   (in_array( 'deprecated', $perms_post ) ? 1 : 0)
									+ (in_array( 'protected', $perms_post ) ? 1 : 0)
									+ (in_array( 'published', $perms_post ) ? 1 : 0);

	$perms_moderator = (in_array( 'redirected', $perms_post ) ? 1 : 0)
									+(int)$perms->{'blog'.$context.'_perm_comments'}
									+(int)$perms->{'blog'.$context.'_perm_media_change'};

	$perms_owner =   (int)$perms->{'blog'.$context.'_perm_properties'}
									+(int)$perms->{'blog'.$context.'_perm_cats'}
									+(int)$perms->{'blog'.$context.'_perm_delpost'};

	$perms_admin =   (int)$perms->{'blog'.$context.'_perm_admin'};

	$perm_edit = $perms->{'blog'.$context.'_perm_edit'};

	// echo "<br> $perms_contrib $perms_editor $perms_moderator $perms_admin $perm_edit ";

	if( $perms_contrib == 4 && $perms_editor == 3 && $perms_moderator == 3 && $perms_owner == 3 && $perms_admin == 1 && $perm_edit == 'all' )
	{ // has full admin rights
		return 'admin';
	}

	if( $perms_contrib == 4 && $perms_editor == 3 && $perms_moderator == 3 && $perms_owner == 3 && $perms_admin == 0 && $perm_edit == 'all' )
	{ // has full editor rights
		return 'owner';
	}

	if( $perms_contrib == 4 && $perms_editor == 3 && $perms_moderator == 3 && $perms_owner == 0 && $perms_admin == 0 && $perm_edit == 'lt' )
	{ // moderator
		return 'moderator';
	}

	if( $perms_contrib == 4 && $perms_editor == 3 && $perms_moderator == 0 && $perms_owner == 0 && $perms_admin == 0 && $perm_edit == 'own' )
	{ // publisher
		return 'editor';
	}

	if( $perms_contrib == 4 && $perms_editor == 0 && $perms_moderator == 0 && $perms_owner == 0 && $perms_admin == 0 && $perm_edit == 'own' )
	{ // contributor
		return 'contrib';
	}

	if( $perms_contrib == 0 && $perms_editor == 0 && $perms_moderator == 0 && $perms_owner == 0  && $perms_admin == 0 && $perm_edit == 'no' )
	{
		return 'member';
	}

	return 'custom';
}


/**
 * Check permissions on a given blog (by ID) and autoselect an appropriate blog
 * if necessary.
 *
 * For use in admin
 *
 * NOTE: we no longer try to set $Blog inside of the function because later global use cannot be safely guaranteed in PHP4.
 *
 * @param string Permission name that must be given to the {@link $current_User} object.
 * @param string Permission level that must be given to the {@link $current_User} object.
 * @return integer new selected blog
 */
function autoselect_blog( $permname, $permlevel = 'any' )
{
	global $blog;

  /**
	 * @var User
	 */
	global $current_User;

	$autoselected_blog = $blog;

	if( $autoselected_blog )
	{ // a blog is already selected
		if( !$current_User->check_perm( $permname, $permlevel, false, $autoselected_blog ) )
		{ // invalid blog
		 	// echo 'current blog was invalid';
			$autoselected_blog = 0;
		}
	}

	if( !$autoselected_blog )
	{ // No blog is selected so far (or selection was invalid)...
		// Let's try to find another one:

    /**
		 * @var BlogCache
		 */
		$BlogCache = & get_Cache( 'BlogCache' );

		// Get first suitable blog
		$blog_array = $BlogCache->load_user_blogs( $permname, $permlevel, $current_User->ID, 'ID', 1 );
		if( !empty($blog_array) )
		{
			$autoselected_blog = $blog_array[0];
		}
	}

	return $autoselected_blog;
}


/**
 * Check that we have received a valid blog param
 *
 * For use in admin
 */
function valid_blog_requested()
{
	global $Blog, $Messages;
	if( empty( $Blog ) )
	{	// The requested blog does not exist
		$Messages->add( T_('The requested blog does not exist (any more?)'), 'error' );
		return false;
	}
	return true;
}


/**
 * Set working blog to a new value and memorize it in user settings if needed.
 *
 * For use in admin
 *
 * @return boolean $blog changed?
 */
function set_working_blog( $new_blog_ID )
{
	global $blog, $UserSettings;

	if( $new_blog_ID != (int)$UserSettings->get('selected_blog') )
	{	// Save the new default blog.
		// fp> Test case 1: dashboard without a blog param should go to last selected blog
		// fp> Test case 2: uploading to the default blog may actually upload into another root (sev)
		$UserSettings->set( 'selected_blog', $blog );
		$UserSettings->dbupdate();
	}

	if( $new_blog_ID == $blog )
	{
		return false;
	}

	$blog = $new_blog_ID;

	return true;
}



?>