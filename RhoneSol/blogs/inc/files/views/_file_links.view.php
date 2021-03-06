<?php
/**
 * This file implements the UI for item links in the filemanager.
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
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _file_links.view.php,v 1.3 2008/01/21 09:35:29 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * @var Item
 */
global $edited_Item;


$Form = & new Form( NULL, 'fm_links', 'post', 'fieldset' );


$Form->begin_form( 'fform' );

$Form->hidden_ctrl();


$Results = & new Results(
					'SELECT link_ID, link_ltype_ID, T_files.*
						 FROM T_links INNER JOIN T_files ON link_file_ID = file_ID
						WHERE link_itm_ID = '.$edited_Item->ID,
					'link_' );

$Results->title = sprintf( T_('Files linked to &laquo;%s&raquo;'),
				'<a href="?ctrl=items&amp;blog='.$edited_Item->blog_ID.'&amp;p='.$edited_Item->ID.'" title="'
				.T_('View this post...').'">'.$edited_Item->dget('title').'</a>' );

if( $current_User->check_perm( 'item_post!'.$edited_Item->status, 'edit', false, $edited_Item ) )
{ // User has permission to edit this post
	$Results->global_icon( T_('Edit this post...'), 'edit', '?ctrl=items&amp;action=edit&amp;p='.$edited_Item->ID, T_('Edit') );
}

// Close link mode and continue in File Manager (remember the Item_ID though):
$Results->global_icon( T_('Quit link mode!'), 'close', regenerate_url( 'fm_mode' ) );


// TYPE COLUMN:
function file_type( & $row )
{
	global $current_File;

	// Instantiate a File object for this line:
	$current_File = new File( $row->file_root_type, $row->file_root_ID, $row->file_path ); // COPY (FUNC) needed for following columns
	// Flow meta data into File object:
	$current_File->load_meta( false, $row );

	return $current_File->get_preview_thumb( 'fulltype' );
}
$Results->cols[] = array(
						'th' => T_('Icon/Type'),
						'th_class' => 'shrinkwrap',
						'td_class' => 'shrinkwrap',
						'td' => '%file_type( {row} )%',
					);


// PATH COLUMN:
function file_path()
{
	/**
	 * @global File
	 */
	global $current_File;
	global $edited_Item;

	// File relative path & name:
	return $current_File->get_linkedit_link( '&amp;fm_mode=link_item&amp;item_ID='.$edited_Item->ID );
}
$Results->cols[] = array(
						'th' => T_('Path'),
						'order' => 'file_path',
						'td_class' => 'left',
						'td' => '%file_path()%',
					);


// TITLE COLUMN:
$Results->cols[] = array(
						'th' => T_('Title'),
						'order' => 'file_title',
						'td_class' => 'left',
						'td' => '$file_title$',
					);


// ACTIONS COLUMN:
function file_actions( $link_ID )
{
	global $current_File, $edited_Item, $current_User;

	$title = T_('Locate this file!');

	$r = $current_File->get_linkedit_link( '&amp;fm_mode=link_item&amp;item_ID='.$edited_Item->ID, get_icon( 'locate', 'imgtag', array( 'title'=>$title ) ), $title );

	if( $current_User->check_perm( 'item', 'edit', false, $edited_Item ) )
	{	// Check that we have permission to edit item:
		$r .= action_icon( T_('Delete this link!'), 'unlink',
                      regenerate_url( 'action', 'link_ID='.$link_ID.'&amp;action=unlink') );
	}

	return $r;
}
$Results->cols[] = array(
						'th' => T_('Actions'),
						'th_class' => 'shrinkwrap',
						'td_class' => 'shrinkwrap',
						'td' => '%file_actions( #link_ID# )%',
					);

$Results->display();

if( $current_User->check_perm( 'item', 'edit', false, $edited_Item ) )
{	// Check that we have permission to edit item:
	printf( '<p>'.T_('Click on link %s icons below to link additional files to this item.').'</p>', get_icon( 'link', 'imgtag', array('class'=>'top') ) );
}

$Form->end_form( );



?>