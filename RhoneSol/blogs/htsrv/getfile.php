<?php
/**
 * This file implements the File view (including resizing of images)
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 * Parts of this file are copyright (c)2005-2006 by PROGIDISTRI - {@link http://progidistri.com/}.
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
 * PROGIDISTRI S.A.S. grants Francois PLANQUE the right to license
 * PROGIDISTRI S.A.S.'s contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package htsrv
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 * @author mbruneau: Marc BRUNEAU / PROGIDISTRI
 */


/**
 * Load config, init and get the {@link $mode mode param}.
 */
require_once dirname(__FILE__).'/../conf/_config.php';
require_once $inc_path.'/_main.inc.php';


// Check permission:
// fp> TODO: skip this if $public_access_to_media  (needs testing before enabling)
if( ! isset($current_User) )
{
	debug_die( 'No permission to get file (not logged in)!' );
}
$current_User->check_perm( 'files', 'view', true );
// fp> TODO: check specific READ perm for requested fileroot

// Load params:
param( 'root', 'string', true );	// the root directory from the dropdown box (user_X or blog_X; X is ID - 'user' for current user (default))
param( 'path', 'string', true );
param( 'size', 'string', NULL );	// Can be used for images.

// Load fileroot info:
$FileRootCache = & get_Cache( 'FileRootCache' );
$FileRoot = & $FileRootCache->get_by_ID( $root );

// Load file object (not the file content):
$File = & new File( $FileRoot->type, $FileRoot->in_type_ID, $path );

if( !empty($size) && $File->is_image() )
{	// We want a thumbnail:
	// This will do all the magic:
	$File->thumbnail( $size );
}
else
{	// We want the regular file:
	// Headers to display the file directly in the browser
	header('Content-type: '.$File->Filetype->mimetype );
	header('Content-Length: '.filesize( $File->get_full_path() ) );

	if( $File->Filetype->viewtype == 'download' )
	{
		header('Content-disposition: attachment; filename="'.$File->get_name().'"' );
	}

	// Display the content of the file
	readfile( $File->get_full_path() );
}


?>