<?php
/**
 * This file implements the UI view for the user group properties.
 *
 * Called by {@link b2users.php}
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
 * @author fplanque: Francois PLANQUE
 * @author blueyed: Daniel HAHLER
 *
 * @version $Id: _group.form.php,v 1.5 2008/01/21 09:35:36 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * @var Group
 */
global $edited_Group;

global $action;

// Begin payload block:
$this->disp_payload_begin();


$Form = & new Form( NULL, 'group_checkchanges' );

$Form->global_icon( T_('Cancel editing!'), 'close', regenerate_url( 'grp_ID,action' ) );

if( $edited_Group->ID == 0 )
{
	$Form->begin_form( 'fform', T_('Creating new group') );
}
else
{
	$title = ( $action == 'edit_user' ? T_('Editing group:') : T_('Viewing group:') )
						.' '.
						( isset($edited_grp_oldname) ? $edited_grp_oldname : $edited_Group->dget('name') )
						.' ('.T_('ID').' '.$edited_Group->ID.')';
	$Form->begin_form( 'fform', $title );
}

$Form->hidden_ctrl();
$Form->hidden( 'action', 'groupupdate' );
$Form->hidden( 'grp_ID', $edited_Group->ID );

$perm_none_option = array( 'none', T_('No Access') );
$perm_view_option = array( 'view', T_('View details') );
$perm_edit_option = array( 'edit', T_('Edit/delete all') );


$Form->begin_fieldset( T_('General').get_manual_link('group_properties_general') );

	$Form->text( 'edited_grp_name', $edited_Group->name, 50, T_('Name'), '', 50, 'large' );

 	if( $edited_Group->ID != 1 )
	{	// Groups others than #1 can be prevented from editing users
		$Form->radio( 'edited_grp_perm_admin', $edited_Group->get('perm_admin'),
				array(  $perm_none_option,
								array( 'hidden', T_('Hidden') ),
								array( 'visible', T_('Visible link') ) // TODO: this may be obsolete, especially now we have to evobar
							), T_('Access to Admin area'), false );
	}
	else
	{	// Group #1 always has user management right:
		$Form->info( T_('Access to Admin area'), T_('Visible link') );
	}

$Form->end_fieldset();

$Form->begin_fieldset( T_('Blogging permissions').get_manual_link('group_properties_blogging') );

	$Form->radio( 'edited_grp_perm_blogs', $edited_Group->get('perm_blogs'),
			array(  array( 'user', T_('Depending on each blog\'s permissions') ),
							array( 'viewall', T_('View all blogs') ),
							array( 'editall', T_('Full Access') )
						), T_('Blogs'), false );

	$Form->radio( 'perm_xhtmlvalidation', $edited_Group->get('perm_xhtmlvalidation'),
			array(  array( 'always', T_('Force valid XHTML + strong security'),
											T_('The security filters below will be strongly enforced.') ),
							array( 'never', T_('Basic security checking'),
											T_('Security filters below will still be enforced but with potential lesser accuracy.') )
						), T_('XHTML validation'), true );

	$Form->radio( 'perm_xhtmlvalidation_xmlrpc', $edited_Group->get('perm_xhtmlvalidation_xmlrpc'),
			array(  array( 'always', T_('Force valid XHTML + strong security'),
											T_('The security filters below will be strongly enforced.') ),
							array( 'never', T_('Basic security checking'),
											T_('Security filters below will still be enforced but with potential lesser accuracy.') )
						), T_('XHTML validation on XML-RPC calls'), true );

	$Form->checklist( array(
						array( 'prevent_css_tweaks', 1, T_('Prevent CSS tweaks'), ! $edited_Group->get('perm_xhtml_css_tweaks'), false,
											T_('WARNING: if allowed, users can easily deface the site, add hidden text, etc.') ),
						array( 'prevent_iframes', 1, T_('Prevent iframes'), ! $edited_Group->get('perm_xhtml_iframes'), false,
											T_('WARNING: if allowed, users may do XSS hacks, steal passwords from other users, etc.') ),
						array( 'prevent_javascript', 1, T_('Prevent javascript'), ! $edited_Group->get('perm_xhtml_javascript'), false,
											T_('WARNING: if allowed, users can easily do XSS hacks, steal passwords from other users, etc.') ),
						array( 'prevent_objects', 1, T_('Prevent objects'), ! $edited_Group->get('perm_xhtml_objects'), false,
											T_('WARNING: if allowed, users can spread viruses and malware through this blog.') ),
					), 'xhtml_security', T_('Security filters') );

	$Form->checkbox( 'apply_antispam', ! $edited_Group->get('perm_bypass_antispam'), T_('Antispam filtering'),
										T_('Inputs from these users will be checked against the antispam blacklist.') );

$Form->end_fieldset();

$Form->begin_fieldset( T_('Additional permissions').get_manual_link('group_properties_additional_permissions') );

	$Form->radio( 'edited_grp_perm_stats', $edited_Group->get('perm_stats'),
			array(  $perm_none_option,
							array( 'user', T_('View stats for specific blogs'), T_('Based on each blog\'s edit permissions') ), // fp> dirty hack, I'll tie this to blog edit perm for now
							array( 'view', T_('View stats for all blogs') ),
							array( 'edit', T_('Full Access'), T_('Includes deleting/reassigning of stats') )
						), T_('Stats'), true );

	// fp> todo perm check
	$filetypes_linkstart = '<a href="?ctrl=filetypes" title="'.T_('Edit locked file types...').'">';
	$filetypes_linkend = '</a>';
	$Form->radio( 'edited_grp_perm_files', $edited_Group->get('perm_files'),
			array(	$perm_none_option,
							array( 'view', T_('View files for all allowed roots') ),
							array( 'add', T_('Add/Upload files to allowed roots') ),
							array( 'edit', sprintf( T_('Edit %sunlocked files'), $filetypes_linkstart.get_icon('file_allowed').$filetypes_linkend ) ),
							array( 'all', sprintf( T_('Edit all files, including %slocked ones'), $filetypes_linkstart.get_icon('file_not_allowed').$filetypes_linkend ), T_('Needed for editing PHP files in skins.') ),
						), T_('Files'), true, T_('This setting will further restrict any media file permissions on specific blogs.') );

$Form->end_fieldset();

$Form->begin_fieldset( T_('System admin permissions').get_manual_link('group_properties_system_permissions') );

	$Form->radio( 'edited_grp_perm_spamblacklist', $edited_Group->get('perm_spamblacklist'),
			array(  $perm_none_option,
							array( 'view', T_('View only') ),
							array( 'edit', T_('Full Access') )
						), T_('Antispam'), false );

	$Form->checkbox( 'edited_grp_perm_templates', $edited_Group->get('perm_templates'), T_('Skins'), T_('Check to allow access to skin files.') );

	if( $edited_Group->ID != 1 )
	{	// Groups others than #1 can be prevented from editing users
		$Form->radio( 'edited_grp_perm_users', $edited_Group->get('perm_users'),
				array(	$perm_none_option,
								$perm_view_option,
								$perm_edit_option
							), T_('Users & Groups') );
	}
	else
	{	// Group #1 always has user management right:
		$Form->info( T_('Users & Groups'), T_('Full Access') );
	}
	$Form->radio( 'edited_grp_perm_options', $edited_Group->get('perm_options'),
			array(	$perm_none_option,
							$perm_view_option,
							$perm_edit_option
						), T_('Settings') );

$Form->end_fieldset();

if( $action != 'view_group' )
{
	$Form->buttons( array(
		array( '', '', T_('Save !'), 'SaveButton' ),
		array( 'reset', '', T_('Reset'), 'ResetButton' ) ) );
}

$Form->end_form();

// End payload block:
$this->disp_payload_end();


?>