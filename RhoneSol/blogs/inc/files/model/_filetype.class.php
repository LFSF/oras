<?php
/**
 * This file implements the file type class.
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
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 * @author mbruneau: Marc BRUNEAU / PROGIDISTRI
 *
 * @version $Id: _filetype.class.php,v 1.2 2008/01/21 09:35:29 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('_core/model/dataobjects/_dataobject.class.php');

/**
 * Filetype Class
 *
 * @package evocore
 */
class Filetype extends DataObject
{
	var $extensions = '' ;
	var $name = ''			 ;
	var $mimetype = ''	 ;
	var $icon = ''			 ;
	var $viewtype = ''	 ;
	var $allowed =''		 ;

	/**
	 * Constructor
	 *
	 * @param table Database row
	 */
	function Filetype( $db_row = NULL )
	{

		// Call parent constructor:
		parent::DataObject( 'T_filetypes', 'ftyp_', 'ftyp_ID' );

		$this->delete_restrictions = array(
					);

  	$this->delete_cascades = array(
			);

 		if( $db_row != NULL )
		{
			$this->ID      			= 	$db_row->ftyp_ID      		;
			$this->extensions  	= 	$db_row->ftyp_extensions 	;
			$this->name   			= 	$db_row->ftyp_name    		;
			$this->mimetype  	 	= 	$db_row->ftyp_mimetype  	;
			$this->icon    			= 	$db_row->ftyp_icon    		;
			$this->viewtype    	= 	$db_row->ftyp_viewtype   	;
			$this->allowed 			=		$db_row->ftyp_allowed		  ;
		}
		else
		{	// Create a new filetype:
			$this->set( 'viewtype', 'browser' );
		}
	}


	/**
	 * Load data from Request form fields.
	 *
	 * @return boolean true if loaded data seems valid.
	 */
	function load_from_Request()
	{
		global $force_upload_forbiddenext;

		// Extensions
		if( param_string_not_empty( 'ftyp_extensions', T_('Please enter file extensions separated by space.') ) )
		{ // Check if estensions has a valid format
			$GLOBALS['ftyp_extensions'] = strtolower( trim( $GLOBALS['ftyp_extensions'] ) );
			$reg_exp = '/^[a-z0-9]+( [a-z0-9]+)*$/';
			if( !preg_match( $reg_exp, $GLOBALS['ftyp_extensions'], $res ) )
			{ // Extensiosn has an invalid format
				param_error( 'ftyp_extensions', T_( 'Invalid file extensions format.' ) );
			}
		}
		$this->set_from_Request( 'extensions' );

		// Name
		param_string_not_empty( 'ftyp_name', T_('Please enter a name.') );
		$this->set_from_Request( 'name' );

		// Mime type
		param_string_not_empty( 'ftyp_mimetype', T_('Please enter a mime type.') );
		$this->set_from_Request( 'mimetype' );

		// Icon for the mime type
		if( param( 'ftyp_icon', 'string', '' ) )
		{
			param_check_filename( 'ftyp_icon', T_('Please enter a file name.') );
		}
		$this->set_from_Request( 'icon' );

		// View type
		param( 'ftyp_viewtype', 'string' );
		$this->set_from_Request( 'viewtype' );

		// Allowed to upload theses extensions
		param( 'ftyp_allowed', 'integer', '0' );
		if( $GLOBALS['ftyp_allowed'] )
		{
			// Check if the extension is in the array of the not allowed extensions (_advanced.php)
			$not_allowed = false;
			$extensions = explode ( ' ', $GLOBALS['ftyp_extensions'] );
			foreach($extensions as $extension)
			{
				if( in_array( $extension, $force_upload_forbiddenext ) )
				{
					$not_allowed = true;
					continue;
				}
			}
			if( $not_allowed )
			{ // this extension is not allowed
				$GLOBALS['ftyp_allowed'] = 0;
			}
		}
		$this->set_from_Request( 'allowed' );

		return ! param_errors_detected();
	}


	/**
	 * Set param value
	 *
	 * By default, all values will be considered strings
	 *
	 * @param string parameter name
	 * @param mixed parameter value
	 */
	function set( $parname, $parvalue )
	{
		switch( $parname )
		{
			case 'extensions':
			case 'name':
			case 'mimetype':
			case 'icon':
			case 'viewtype':
			case 'allowed':
			default:
				$this->set_param( $parname, 'string', $parvalue );
		}
	}

	/**
	 * Return the img html code of the icon
	 * @return string
	 */
	function get_icon()
	{
		global $rsc_url;

		$icon = $this->icon;
		if( empty($icon) )
		{ // use default icon
			$icon = 'default.png';
		}

		return '<img src="'.$rsc_url.'icons/fileicons/'.$icon.'" alt="" title="'.$this->dget('name', 'htmlattr').'" class="middle" />';
	}

}


?>