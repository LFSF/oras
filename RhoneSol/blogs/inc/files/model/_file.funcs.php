<?php
/**
 * This file implements various File handling functions.
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
 * @version $Id: _file.funcs.php,v 1.6.2.1 2008/04/26 22:28:53 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


if( ! function_exists('fnmatch') )
{
	/**
	 * A replacement for fnmatch() which needs PHP 4.3 and a POSIX compliant system (Windows is not).
	 *
	 * @author jk at ricochetsolutions dot com {@link http://php.net/manual/function.fnmatch.php#71725}
	 */
	function fnmatch($pattern, $string)
	{
	   return preg_match( '#^'.strtr(preg_quote($pattern, '#'), array('\*' => '.*', '\?' => '.')).'$#i', $string);
	}
}


/**
 * Converts bytes to readable bytes/kb/mb/gb, like "12.45mb"
 *
 * @param integer bytes
 * @return string bytes made readable
 */
function bytesreadable( $bytes )
{
	static $types = NULL;

	if( empty($bytes) )
	{
		return T_('Empty');
	}

	if( !isset($types) )
	{ // generate once:
		$types = array(
			0 => array( 'abbr' => /* TRANS: Abbr. for "Bytes" */ T_('B.'), 'text' => T_('Bytes') ),
			1 => array( 'abbr' => /* TRANS: Abbr. for "Kilobytes" */ T_('KB'), 'text' => T_('Kilobytes') ),
			2 => array( 'abbr' => /* TRANS: Abbr. for Megabytes */ T_('MB'), 'text' => T_('Megabytes') ),
			3 => array( 'abbr' => /* TRANS: Abbr. for Gigabytes */ T_('GB'), 'text' => T_('Gigabytes') ),
			4 => array( 'abbr' => /* TRANS: Abbr. for Terabytes */ T_('TB'), 'text' => T_('Terabytes') )
		);
	}

	for( $i = 0; $bytes > 1024; $i++ )
	{
		$bytes /= 1024;
	}

	// Format to maximum of 1 digit after .
	$precision = max( 0, ( 1 -floor(log($bytes)/log(10))) );
	$r = sprintf( '%.'.$precision.'f', $bytes );

	$r .= '&nbsp;<abbr title="'.$types[$i]['text'].'">';
	$r .= $types[$i]['abbr'];
	$r .= '</abbr>';

	// $r .= ' '.$precision;

	return $r;
}


/**
 * Get an array of all directories (and optionally files) of a given
 * directory, either flat (one-dimensional array) or multi-dimensional (then
 * dirs are the keys and hold subdirs/files).
 *
 * Note: there is no ending slash on dir names returned.
 *
 * @param string the path to start
 * @param boolean include files (not only directories)
 * @param boolean include directories (not the directory itself!)
 * @param boolean flat (return an one-dimension-array)
 * @param boolean Recurse into subdirectories?
 * @param boolean Get the basename only.
 * @return false|array false if the first directory could not be accessed,
 *                     array of entries otherwise
 */
function get_filenames( $path, $inc_files = true, $inc_dirs = true, $flat = true, $recurse = true, $basename = false )
{
	$r = array();

	$path = trailing_slash( $path );

	if( $dir = @opendir($path) )
	{
		while( ( $file = readdir($dir) ) !== false )
		{
			if( $file == '.' || $file == '..' )
			{
				continue;
			}
			if( is_dir($path.$file) )
			{
				if( $flat )
				{
					if( $inc_dirs )
					{
						$r[] = $basename ? $file : $path.$file;
					}
					if( $recurse )
					{
						$rSub = get_filenames( $path.$file, $inc_files, $inc_dirs, $flat, $recurse, $basename );
						if( $rSub )
						{
							$r = array_merge( $r, $rSub );
						}
					}
				}
				else
				{
					$r[$file] = get_filenames( $path.$file, $inc_files, $inc_dirs, $flat, $recurse, $basename );
				}
			}
			elseif( $inc_files )
			{
				$r[] = $basename ? $file : $path.$file;
			}
		}
		closedir($dir);
	}
	else
	{
		return false;
	}

	return $r;
}


/**
 * Get a list of available admin skins.
 *
 * This checks if there's a _adminUI.class.php in there.
 *
 * @return array  List of directory names that hold admin skins or false, if the admin skins driectory does not exist.
 */
function get_admin_skins()
{
	global $adminskins_path, $admin_subdir, $adminskins_subdir;

	$dirs_in_adminskins_dir = get_filenames( $adminskins_path, false, true, true, false, true );

	if( $dirs_in_adminskins_dir === false )
	{
		return false;
	}

	$r = array();
	if( $dirs_in_adminskins_dir )
	{
		foreach( $dirs_in_adminskins_dir as $l_dir )
		{
			if( !file_exists($adminskins_path.$l_dir.'/_adminUI.class.php') )
			{
				continue;
			}
			$r[] = $l_dir;
		}
	}
	return $r;
}


/**
 * Get size of a directory, including anything (especially subdirs) in there.
 *
 * @param string the dir's full path
 */
function get_dirsize_recursive( $path )
{
	$files = get_filenames( $path, true, false );
	$total = 0;

	foreach( $files as $lFile )
	{
		$total += filesize($lFile);
	}

	return $total;
}


/**
 * Deletes a dir recursively, wiping out all subdirectories!!
 *
 * @param string the dir
 */
function rmdir_r( $path )
{
	$path = trailing_slash( $path );
	// echo "<br>rmdir_r($path)";

	if( $dir = @opendir($path) )
	{
		while( ( $file = readdir($dir) ) !== false )
		{
			if( $file == '.' || $file == '..' )
			{
				continue;
			}

			$adfp_filepath = $path.$file;

			// echo "<br> - $os_filepath ";

			if( is_dir( $adfp_filepath ) && ! is_link($adfp_filepath) )
			{ // Note: we do NOT follow symlinks
				// echo 'D';
				rmdir_r( $adfp_filepath );
			}
			else
			{ // File or symbolic link
				//echo 'F/S';
				@unlink( $adfp_filepath );
			}
		}
		closedir($dir);

		@rmdir( $path );
	}
}


/**
 * Get the size of an image file
 *
 * @param string absolute file path
 * @param string what property/format to get: 'width', 'height', 'widthxheight',
 *               'type', 'string' (as for img tags), else 'widthheight' (array)
 * @return mixed false if no image, otherwise what was requested through $param
 */
function imgsize( $path, $param = 'widthheight' )
{
	/**
	 * Cache image sizes
	 */
	global $cache_imgsize;

	if( isset($cache_imgsize[$path]) )
	{
		$size = $cache_imgsize[$path];
	}
	elseif( !($size = @getimagesize( $path )) )
	{
		return false;
	}
	else
	{
		$cache_imgsize[$path] = $size;
	}

	if( $param == 'width' )
	{
		return $size[0];
	}
	elseif( $param == 'height' )
	{
		return $size[1];
	}
	elseif( $param == 'widthxheight' )
	{
		return $size[0].'x'.$size[1];
	}
	elseif( $param == 'type' )
	{
		switch( $size[1] )
		{
			case 1: return 'gif';
			case 2: return 'jpg';
			case 3: return 'png';
			case 4: return 'swf';
			default: return 'unknown';
		}
	}
	elseif( $param == 'string' )
	{
		return $size[3];
	}
	else
	{ // default: 'widthheight'
		return array( $size[0], $size[1] );
	}
}


/**
 * Add a trailing slash, if none present
 *
 * @param string the path/url
 * @return string the path/url with trailing slash
 */
function trailing_slash( $path )
{
	if( empty($path) || substr( $path, -1 ) == '/' )
	{
		return $path;
	}
	else
	{
		return $path.'/';
	}
}


/**
 * Remove trailing slash, if present
 *
 * @param string the path/url
 * @return string the path/url without trailing slash
 */
function no_trailing_slash( $path )
{
	if( substr( $path, -1 ) == '/' )
	{
		return substr( $path, 0, strlen( $path ) );
	}
	else
	{
		return $path;
	}
}


/**
 * Returns canonicalized pathname of a directory + ending slash
 *
 * @param string absolute path to be reduced ending with slash
 * @return string absolute reduced path, slash terminated or NULL if the path could not get canonicalized.
 */
function get_canonical_path( $ads_path )
{
	// Remove windows backslashes:
	$ads_path = str_replace( '\\', '/', $ads_path );

	// Make sure there's a trailing slash
	$ads_path = trailing_slash($ads_path);

	$ads_path = str_replace( '//', '/', $ads_path );
	$ads_path = str_replace( '/./', '/', $ads_path );
	while( ($ads_realpath = preg_replace( '#(^|/)([^/^.]+)/\.\./#', '$1', $ads_path )) != $ads_path )
	{ // While we find /../ back references to dereference...
		// echo '*';
		$ads_path = $ads_realpath;
	}

	// pre_dump( 'get_canonical_path()', $ads_path, $ads_realpath );

	if( strpos( $ads_realpath, '..' ) !== false )
	{	// Path malformed:
		return NULL;
	}

	return $ads_realpath;
}


/**
 * Check for valid filename and extension of the filename (no path allowed). (MB)
 *
 * @uses $FiletypeCache, $settings or $force_regexp_filename form _advanced.php
 *
 * @param string filename to test
 * @param boolean
 * @return nothing if the filename is valid according to the regular expression and the extension too, error message if not
 */
function validate_filename( $filename, $allow_locked_filetypes = false )
{
	global $Settings, $force_regexp_filename;

	// Check filename
	if( $force_regexp_filename )
	{ // Use the regexp from _advanced.php
		if( !preg_match( ':'.str_replace( ':', '\:', $force_regexp_filename ).':', $filename ) )
		{ // Invalid filename
			return sprintf( T_('&laquo;%s&raquo; is not a valid filename.'), $filename );
		}
	}
	else
	{	// Use the regexp from SETTINGS
		if( !preg_match( ':'.str_replace( ':', '\:', $Settings->get( 'regexp_filename' ) ).':', $filename ) )
		{ // Invalid filename
			return sprintf( T_('&laquo;%s&raquo; is not a valid filename.'), $filename );
		}
	}

	// Check extension filename
	if( preg_match( '#\.([a-zA-Z0-9\-_]+)$#', $filename, $match ) )
	{ // Filename has a valid extension
		$FiletypeCache = & get_Cache( 'FiletypeCache' );
		if( $Filetype = & $FiletypeCache->get_by_extension( strtolower( $match[1] ) , false ) )
		{
			if( $Filetype->allowed || $allow_locked_filetypes )
			{ // Filename has an unlocked extension or we allow locked extensions
				return;
			}
			else
			{	// Filename hasn't an allowed extension
				return sprintf( T_('&laquo;%s&raquo; is a locked extension.'), htmlentities($match[1]) );
			}
		}
		else
		{ // Filename hasn't an allowed extension
			return sprintf( T_('&laquo;%s&raquo; has an unrecognized extension.'), $filename );
		}
	}
	else
	{ // Filename hasn't a valid extension
		return sprintf( T_('&laquo;%s&raquo; has not a valid extension.'), $filename );
	}
}


/**
 * Check for valid dirname (no path allowed). ( MB )
 *
 * @uses $Settings or $force_regexp_dirname form _advanced.php
 * @param string dirname to test
 * @return nothing if the dirname is valid according to the regular expression, error message if not
 */
function validate_dirname( $dirname )
{
	global $Settings, $force_regexp_dirname;

	if( $dirname != '..' )
	{
		if( !empty( $force_regexp_dirname ) )
		{ // Use the regexp from _advanced.php
			if( preg_match( ':'.str_replace( ':', '\:', $force_regexp_dirname ).':', $dirname ) )
			{ // Valid dirname
				return;
			}
		}
		else
		{ // Use the regexp from SETTINGS
			if( preg_match( ':'.str_replace( ':', '\:', $Settings->get( 'regexp_dirname' ) ).':', $dirname ) )
			{ // Valid dirname
				return;
			}
		}
	}

	return sprintf( T_('&laquo;%s&raquo; is not a valid directory name.'), $dirname );
}


/**
 * Return the path without the leading {@link $basepath}, or if not
 * below {@link $basepath}, just the basename of it.
 *
 * Do not use this for file handling.  JUST for displaying! (DEBUG MESSAGE added)
 *
 * @param string Path
 * @return string Relative path or even base name.
 *   NOTE: when $debug, the real path gets appended.
 */
function rel_path_to_base( $path )
{
	global $basepath, $debug;

	// Remove basepath prefix:
	if( preg_match( '~^('.preg_quote($basepath, '~').')(.+)$~', $path, $match ) )
	{
		$r = $match[2];
	}
	else
	{
		$r = basename($path).( is_dir($path) ? '/' : '' );
	}

	if( $debug )
	{
		$r .= ' [DEBUG: '.$path.']';
	}

	return $r;
}


/**
 * Get the directories of the supplied path as a radio button tree.
 *
 * @todo fp> Make a DirTree class (those static hacks suck)
 *
 * @param FileRoot A single root or NULL for all available.
 * @param string the root path to use
 * @param boolean add radio buttons ?
 * @param string used by recursion
 * @return string
 */
function get_directory_tree( $Root = NULL, $ads_full_path = NULL, $ads_selected_full_path = NULL, $radios = false, $rds_rel_path = NULL, $is_recursing = false )
{
	static $js_closeClickIDs; // clickopen IDs that should get closed
	static $instance_ID = 0;

	if( ! $is_recursing )
	{	// This is not a recursive call (yet):
		// Init:
		$instance_ID++;
		$js_closeClickIDs = array();
		$ret = '<ul class="clicktree">';
	}
	else
	{
		$ret = '';
	}

	// ________________________ Handle Roots ______________________
	if( $Root === NULL )
	{ // We want to list all roots:
		$FileRootCache = & get_Cache( 'FileRootCache' );
		$_roots = $FileRootCache->get_available_FileRoots();

		foreach( $_roots as $l_Root )
		{
			$subR = get_directory_tree( $l_Root, $l_Root->ads_path, $ads_selected_full_path, $radios, '', true );
			if( !empty( $subR['string'] ) )
			{
				$ret .= '<li>'.$subR['string'].'</li>';
			}
		}
	}
	else
	{
		// We'll go through files in current dir:
		$Nodelist = & new Filelist( $Root, trailing_slash($ads_full_path) );
		$Nodelist->load();
		$Nodelist->sort( 'name' );
		$has_sub_dirs = $Nodelist->count_dirs();

		$id_path = 'id_path_'.$instance_ID.md5( $ads_full_path );

		$r['string'] = '<span class="folder_in_tree">';

		// echo '<br />'. $rds_rel_path . ' - '.$ads_full_path;
		if( $ads_full_path == $ads_selected_full_path )
		{	// This is the current open path
	 		$r['opened'] = true;
		}
		else
		{
	 		$r['opened'] = NULL;
		}


		if( $radios )
		{ // Optional radio input to select this path:
			$root_and_path = format_to_output( implode( '::', array($Root->ID, $rds_rel_path) ), 'formvalue' );

			$r['string'] .= '<input type="radio" name="root_and_path" value="'.$root_and_path.'" id="radio_'.$id_path.'"';

			if( $r['opened'] )
			{	// This is the current open path
				$r['string'] .= ' checked="checked"';
			}

			//.( ! $has_sub_dirs ? ' style="margin-right:'.get_icon( 'collapse', 'size', array( 'size' => 'width' ) ).'px"' : '' )
			$r['string'] .= ' /> &nbsp; &nbsp;';
		}

		// Folder Icon + Name:
		$url = regenerate_url( 'root,path', 'root='.$Root->ID.'&amp;path='.$rds_rel_path );
		$label = action_icon( T_('Open this directory in the file manager'), 'folder', $url )
			.'<a href="'.$url.'"
			title="'.T_('Open this directory in the file manager').'">'
			.( empty($rds_rel_path) ? $Root->name : basename( $ads_full_path ) )
			.'</a>';

		// Handle potential subdir:
		if( ! $has_sub_dirs )
		{	// No subirs
			$r['string'] .= get_icon( 'expand', 'noimg', array( 'class'=>'' ) ).'&nbsp;'.$label.'</span>';
		}
		else
		{ // Process subdirs
			$r['string'] .= get_icon( 'collapse', 'imgtag', array( 'onclick' => 'toggle_clickopen(\''.$id_path.'\');',
						'id' => 'clickimg_'.$id_path
					) )
				.'&nbsp;'.$label.'</span>'
				.'<ul class="clicktree" id="clickdiv_'.$id_path.'">'."\n";

			while( $l_File = & $Nodelist->get_next( 'dir' ) )
			{
				$rSub = get_directory_tree( $Root, $l_File->get_full_path(), $ads_selected_full_path, $radios, $l_File->get_rdfs_rel_path(), true );

				if( $rSub['opened'] )
				{ // pass opened status on, if given
					$r['opened'] = $rSub['opened'];
				}

				$r['string'] .= '<li>'.$rSub['string'].'</li>';
			}

			if( !$r['opened'] )
			{
				$js_closeClickIDs[] = $id_path;
			}
			$r['string'] .= '</ul>';
		}

   	if( $is_recursing )
		{
			return $r;
		}
		else
		{
			$ret .= '<li>'.$r['string'].'</li>';
		}
	}

	if( ! $is_recursing )
	{
 		$ret .= '</ul>';

		if( ! empty($js_closeClickIDs) )
		{ // there are IDs of checkboxes that we want to close
			$ret .= "\n".'<script type="text/javascript">toggle_clickopen( \''
						.implode( "' );\ntoggle_clickopen( '", $js_closeClickIDs )
						."' );\n</script>";
		}
	}

	return $ret;
}


/**
 * Create a directory recursively.
 *
 * NOTE: this can be done with the "recursive" param in PHP5
 *
 * @todo dh> simpletests for this (especially for open_basedir)
 *
 * @param string directory name
 * @param integer permissions
 * @return boolean
 */
function mkdir_r( $dirName, $chmod = NULL )
{
	if( is_dir($dirName) )
	{ // already exists:
		return true;
	}

	if( $chmod === NULL )
	{
		global $Settings;
		$chmod = $Settings->get('fm_default_chmod_dir');
	}

	/*
	if( version_compare(PHP_VERSION, 5, '>=') )
	{
		return mkdir( $dirName, $chmod, true );
	}
	*/

	$dirName = trailing_slash($dirName);

	$parts = array_reverse( explode('/', $dirName) );
	$loop_dir = $dirName;
	$create_dirs = array();
	foreach($parts as $part)
	{
		if( ! strlen($part) )
		{
			continue;
		}
		// We want to create this dir:
		array_unshift($create_dirs, $loop_dir);
		$loop_dir = substr($loop_dir, 0, 0 - strlen($part)-1);

		if( is_dir($loop_dir) )
		{ // found existing dir:
			foreach($create_dirs as $loop_dir )
			{
				if( ! @mkdir($loop_dir, octdec($chmod)) )
				{
					return false;
				}
			}
			return true;
		}
	}
	return true;
}



?>