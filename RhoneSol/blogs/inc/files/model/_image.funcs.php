<?php
/**
 * This file implements various Image File handling functions.
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
 * {@internal Open Source relicensing agreement:
 * }}
 *
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _image.funcs.php,v 1.3 2008/01/21 09:35:29 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * Scale dimensions to fit into a constrained size, while preserving aspect ratio.
 *
 * @param integer source width
 * @param integer source height
 * @param integer constrained width
 * @param integer constrained height
 */
function scale_to_constraint( $src_width, $src_height, $max_width, $max_height )
{
	$src_ratio = $src_width / $src_height;
	if( $max_width / $max_height <= $src_ratio )
	{
		$width = $max_width;
		$height = (int)round( $max_width / $src_ratio );
	}
	else
	{
		$width = (int)round( $max_height * $src_ratio );
		$height = $max_height;
	}

	return array( $width, $height );
}


/**
 * Scale dimensions to fit into a constrained size, while preserving aspect ratio.
 * The scaling only happens if the source is larger than the constraint.
 *
 * @param integer source width
 * @param integer source height
 * @param integer constrained width
 * @param integer constrained height
 */
function fit_into_constraint( $src_width, $src_height, $max_width, $max_height )
{
	if( $src_width > $max_width || $src_height > $max_height )
	{
		return scale_to_constraint( $src_width, $src_height, $max_width, $max_height );
	}

	return array( $src_width, $src_height );
}


/**
 * Load an image from a file into memory
 *
 * @param string pathname of image file
 * @param string
 * @return array resource image handle or NULL
 */
function load_image( $path, $mimetype )
{
	$err = NULL;
	$imh = NULL;

	switch( $mimetype )
	{
		case 'image/jpeg':
			$imh = imagecreatefromjpeg( $path ); // dh> TODO: this can fail, if $path is not a valid jpeg! Handle this.
			break;

		case 'image/gif':
			$imh = imagecreatefromgif( $path );  // dh> TODO: this can fail, if $path is not a valid gif! Handle this.
			break;

		case 'image/png':
			$imh = imagecreatefrompng( $path );  // dh> TODO: this can fail, if $path is not a valid png! Handle this.
			break;

 		default:
			// Unrecognized mime type
			$err = '!Unsupported format '.$mimetype.' (load_image)';
			break;
	}

	return array( $err, $imh );
}


/**
 * Output an image from memory to web client
 *
 * @param resource image handle
 * @param string pathname of image file
 * @param string
 * @param integer
 * @param string permissions
 * @return string
 */
function save_image( $imh, $path, $mimetype, $quality = 90, $chmod = NULL )
{
	$err = NULL;

	switch( $mimetype )
	{
		case 'image/jpeg':
			imagejpeg( $imh, $path, $quality );
			break;

		case 'image/gif':
			imagegif( $imh, $path );
			break;

		case 'image/png':
			imagepng( $imh, $path );
			break;

 		default:
			// Unrecognized mime type
			$err = '!Unsupported format '.$mimetype.' (save_image)';
			break;
	}

	if( empty( $err ) )
	{
		// Make sure the file has the default permissions we want:
		if( $chmod === NULL )
		{
			global $Settings;
			$chmod = $Settings->get('fm_default_chmod_file');
		}
		chmod( $path, octdec( $chmod ) );
	}

	return $err;
}


/**
 * Output an image from memory to web client
 *
 * @param resource image handle
 * @param string
 * @return string
 */
function output_image( $imh, $mimetype )
{
	$err = NULL;

	switch( $mimetype )
	{
		case 'image/jpeg':
			header('Content-type: '.$mimetype );
			imagejpeg( $imh );
			break;

		case 'image/gif':
			header('Content-type: '.$mimetype );
			imagegif( $imh );
			break;

 		default:
			// Unrecognized mime type
			$err = 'Emime';	// Sort error code
			break;
	}

	return $err;
}




/**
 * Generate a thumbnail
 *
 * @return array short error code + dest image handler
 */
function generate_thumb( $src_imh, $thumb_width, $thumb_height )
{
	$src_width = imagesx( $src_imh ) ;
	$src_height = imagesy( $src_imh );

	if( $src_width <= $thumb_width && $src_height <= $thumb_height )
	{	// There is no need to resample, use original!
		return array( NULL, $src_imh );
	}

	list( $dest_width, $dest_height ) = scale_to_constraint( $src_width, $src_height, $thumb_width, $thumb_height );

	// pre_dump( $src_width, $src_height, $dest_width, $dest_height );

	$dest_imh = imagecreatetruecolor( $dest_width, $dest_height ); // Create a black image
	if( ! imagecopyresampled( $dest_imh, $src_imh, 0, 0, 0, 0, $dest_width, $dest_height, $src_width, $src_height ) )
	{
		return array( '!GD-library internal error (resample)', $dest_imh );
	}

	// TODO: imageinterlace();

	return array( NULL, $dest_imh );
}


?>