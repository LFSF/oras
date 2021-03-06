<?php
/**
 * This file implements the File types list.
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
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 * @author mbruneau: Marc BRUNEAU / PROGIDISTRI
 *
 * @version $Id: _filetype_list.view.php,v 1.3 2008/01/21 09:35:30 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


global $rsc_url;

// Create result set:
$Results = & new Results(
							'SELECT * FROM T_filetypes', 'ftyp_' );
$Results->Cache = & get_Cache( 'FiletypeCache' );
$Results->title = T_('File types list');

$Results->cols[] = array(
						'th' => T_('Icon'),
						//'order' => 'ftyp_icon',
						'th_class' => 'shrinkwrap',
						'td_class' => 'shrinkwrap',
						'td' => '% {Obj}->get_icon() %',
					);

if( $current_User->check_perm( 'options', 'edit', false ) )
{ // We have permission to modify:
	$Results->cols[] = array(
							'th' => T_('Extensions'),
							'order' => 'ftyp_extensions',
							'td' => '<strong><a href="admin.php?ctrl=filetypes&amp;ftyp_ID=$ftyp_ID$&amp;action=edit" title="'.
											T_('Edit this file type...').'">$ftyp_extensions$</a></strong>',
						);
}
else
{	// View only:
	$Results->cols[] = array(
							'th' => T_('Extensions'),
							'order' => 'ftyp_extensions',
							'td' => '<strong>$ftyp_extensions$</strong>',
						);

}

$Results->cols[] = array(
						'th' => T_('Name'),
						'order' => 'ftyp_name',
						'td' => '$ftyp_name$',
					);

$Results->cols[] = array(
						'th' => T_('Mime type'),
						'order' => 'ftyp_mimetype',
						'td' => '$ftyp_mimetype$',
					);

$Results->cols[] = array(
						'th' => T_('View type'),
						'order' => 'ftyp_viewtype',
						'td' => '$ftyp_viewtype$',
					);
/**
 * Display the permissions for the type file
 */
function display_perm( $perm )
{
	if ( $perm )
	{
		$r = get_icon( 'file_allowed' );
	}
	else
	{
		$r = get_icon( 'file_not_allowed' );
	}
	return $r;
}

$Results->cols[] = array(
						'th' => T_('Upload'),
						'order' => 'ftyp_allowed',
						'th_class' => 'shrinkwrap',
						'td_class' => 'shrinkwrap',
						'td' => '%display_perm( #ftyp_allowed# )%',
					);

if( $current_User->check_perm( 'options', 'edit', false ) )
{ // We have permission to modify:

	$Results->cols[] = array(
							'th' => T_('Actions'),
							'th_class' => 'shrinkwrap',
							'td_class' => 'shrinkwrap',
							'td' => action_icon( T_('Edit this file type...'), 'edit',
	                        '%regenerate_url( \'action\', \'ftyp_ID=$ftyp_ID$&amp;action=edit\')%' )
	                    .action_icon( T_('Duplicate this file type...'), 'copy',
	                        '%regenerate_url( \'action\', \'ftyp_ID=$ftyp_ID$&amp;action=copy\')%' )
	                    .action_icon( T_('Delete this file type!'), 'delete',
	                        '%regenerate_url( \'action\', \'ftyp_ID=$ftyp_ID$&amp;action=delete\')%' ),
						);

  $Results->global_icon( T_('Create a new file type...'), 'new', regenerate_url( 'action', 'action=new'), T_('New file type').' &raquo;', 3, 4  );
}


$Results->display();


?>