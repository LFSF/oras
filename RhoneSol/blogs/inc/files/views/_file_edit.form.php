<?php
/**
 * This file implements the file editing form.
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
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _file_edit.form.php,v 1.2 2008/01/21 09:35:29 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var File
 */
global $edit_File;

$Form = & new Form( NULL, 'file_edit' );

$Form->global_icon( T_('Cancel editing!'), 'close', regenerate_url('fm_mode') );

$Form->begin_form( 'fform', T_('Editing:').' '.$edit_File->get_rdfs_rel_path() );
	$Form->hidden_ctrl();
	$Form->hidden( 'action', 'update_file' );
	$Form->hiddens_by_key( get_memorized() );

 	$Form->switch_layout( 'none' );
	echo '<div class="center">';

	$Form->textarea_input( 'file_content', $edit_File->content, 25, '', array( 'class'=>'large', 'cols' => '80' ) );

	$Form->buttons( array( array( 'submit', '', T_('Save!'), 'SaveButton' ),
												array( 'reset', '', T_('Reset'), 'ResetButton' ) ) );

	echo '</div>';
 	$Form->switch_layout( NULL );

$Form->end_form();


?>