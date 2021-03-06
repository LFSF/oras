<?php
/**
 * This file implements the UI for file browsing.
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
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _file_browse.view.php,v 1.10 2008/02/04 13:57:50 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Filelist
 */
global $fm_Filelist;
/**
 * @var FileRootCache
 */
global $FileRootCache;
/**
 * @var string
 */
global $fm_flatmode;
/**
 * @var User
 */
global $current_User;
/**
 * @var GeneralSettings
 */
global $Settings;

global $UserSettings;

global $fm_hide_dirtree, $create_name, $ads_list_path, $rsc_url;

global $fm_FileRoot, $path;

/**
 * @var Item
 */
global $edited_Item;
?>

<!-- FILE BROWSER -->

<?php
	$Widget = & new Widget( 'file_browser' );
	$Widget->global_icon( T_('Upload...'), '', regenerate_url( 'ctrl', 'ctrl=upload' ), T_('Upload').' &raquo;', 1, 5 );

	if( !empty($edited_Item) )
	{ // Return to post editing:
		$Widget->global_icon( T_('Close file manager'), 'close', '?ctrl=items&amp;p='.$edited_Item->ID );
	}

	$Widget->title = T_('File browser').get_manual_link('file_browser');
	$Widget->disp_template_replaced( 'block_start' );
?>

<table id="fm_browser" cellspacing="0" cellpadding="0">
	<thead>
		<tr>
			<td colspan="2" id="fm_bar">
			<?php
				if( $UserSettings->get( 'fm_allowfiltering' ) != 'no' )
				{
					// Title for checkbox and its label
					$titleRegExp = format_to_output( T_('Filter is a regular expression'), 'formvalue' );

					echo '<div class="toolbaritem">';

					$Form = & new Form( NULL, 'fmbar_filter_checkchanges', 'get', 'none' );
					$Form->begin_form();
					$Form->hidden_ctrl();
					$Form->hiddens_by_key( get_memorized(), array('fm_filter', 'fm_filter_regex') );
					?>

					<label for="fm_filter" class="tooltitle"><?php echo T_('Filter') ?>:</label>
					<input type="text" name="fm_filter" id="fm_filter"
						value="<?php echo format_to_output( $fm_Filelist->get_filter( false ), 'formvalue' ) ?>"
						size="7" accesskey="f" />

					<?php
						if( $UserSettings->get( 'fm_allowfiltering' ) == 'regexp' )
						{
							?>
							<input type="checkbox" class="checkbox" name="fm_filter_regex" id="fm_filter_regex" title="<?php echo $titleRegExp; ?>"
								value="1"<?php if( $fm_Filelist->is_filter_regexp() ) echo ' checked="checked"' ?> />
							<label for="fm_filter_regex" title="<?php echo $titleRegExp; ?>"><?php
								echo /* TRANS: short for "is regular expression" */ T_('RegExp').'</label>';
						}
					?>

					<input type="submit" name="actionArray[filter]" class="SmallButton"
						value="<?php echo format_to_output( T_('Apply'), 'formvalue' ) ?>" />

					<?php
					if( $fm_Filelist->is_filtering() )
					{ // "reset filter" form
						?>
						<input type="image" name="actionArray[filter_unset]" value="<?php echo T_('Unset filter'); ?>"
							title="<?php echo T_('Unset filter'); ?>" src="<?php echo get_icon( 'delete', 'url' ) ?>" class="ActionButton" />
						<?php
					}
				$Form->end_form();

				echo '</div>';
			}
			?>

			<!-- ROOTS SELECT -->

			<?php
				$Form = & new Form( NULL, 'fmbar_roots', 'post', 'none' );
				$Form->begin_form();
				// $Form->hidden_ctrl();
				$Form->hiddens_by_key( get_memorized() );

				$rootlist = $FileRootCache->get_available_FileRoots();
				if( count($rootlist) > 1 )
				{ // provide list of roots to choose from
					?>
					<select name="new_root" onchange="this.form.submit();">
					<?php
					$optgroup = '';
					foreach( $rootlist as $l_FileRoot )
					{
						if( ($typegroupname = $l_FileRoot->get_typegroupname()) != $optgroup )
						{ // We're entering a new group:
							if( ! empty($optgroup) )
							{
								echo '</optgroup>';
							}
							echo '<optgroup label="'.T_($typegroupname).'">';
							$optgroup = $typegroupname;
						}
						echo '<option value="'.$l_FileRoot->ID.'"';

						if( $fm_Filelist->_FileRoot && $fm_Filelist->_FileRoot->ID == $l_FileRoot->ID )
						{
							echo ' selected="selected"';
						}

						echo '>'.format_to_output( $l_FileRoot->name )."</option>\n";
					}
					if( ! empty($optgroup) )
					{
						echo '</optgroup>';
					}
					?>
					</select>
					<script type="text/javascript">
						<!--
						// Just to have noscript tag below (which has to know what type it is not for).
						// -->
					</script>
					<noscript>
						<input class="ActionButton" type="submit" value="<?php echo T_('Change root'); ?>" />
					</noscript>

					<?php
				}

				/*
				 * Display link to display directory tree:
				 */
				if( $fm_hide_dirtree )
				{
					echo ' <a href="'.regenerate_url('fm_hide_dirtree', 'fm_hide_dirtree=0').'">'.T_('Display directory tree').'</a>';
				}
				else
				{
					echo ' <a href="'.regenerate_url('fm_hide_dirtree', 'fm_hide_dirtree=1').'">'.T_('Hide directory tree').'</a>';
				}

				/*
				 * Flat mode
				 */
				echo ' - ';
				if( $fm_flatmode )
				{
					echo ' <a href="'.regenerate_url('fm_flatmode', 'fm_flatmode=0').'" title="'
								.T_('View one folder per page').'">'.T_('Folder mode').'</a>';
				}
				else
				{
					echo ' <a href="'.regenerate_url('fm_flatmode', 'fm_flatmode=1').'" title="'
								.T_('View all files and subfolders on a single page').'">'.T_('Flat mode').'</a>';
				}

				/*
				 * Settings:
				 */
				echo ' - <a href="'.regenerate_url('', 'action=edit_settings').'" title="'
								.T_('Edit display settings').'">'.T_('Display settings').'</a>';

				$Form->end_form();


		// -----------------------------------------------
		// Display table header: directory location info:
		// -----------------------------------------------
		echo '<div id="fmbar_cwd">';
		// Display current dir:
		echo T_('Current dir').': <strong class="currentdir">'.$fm_Filelist->get_cwd_clickable().'</strong>';
		echo '</div> ';

		// Display current filter:
		if( $fm_Filelist->is_filtering() )
		{
			echo '<div id="fmbar_filter">';
			echo '[<em class="filter">'.$fm_Filelist->get_filter().'</em>]';
			// TODO: maybe clicking on the filter should open a JS popup saying "Remove filter [...]? Yes|No"
			echo '</div> ';
		}


		// The hidden reload button, which gets displayed if a popup detects that the displayed files have changed
		?>
		<span style="display:none;" id="fm_reloadhint">
			<a href="<?php echo regenerate_url() ?>"
				title="<?php echo T_('A popup has discovered that the displayed content of this window is not up to date. Click to reload.'); ?>">
				<?php echo get_icon( 'refresh' ) ?>
			</a>
		</span>

		<?php
		// Display filecounts:
		?>

		<div id="fmbar_filecounts" title="<?php printf( T_('%s bytes'), number_format($fm_Filelist->count_bytes()) ); ?>"> (<?php
			disp_cond( $fm_Filelist->count_dirs(), T_('One directory'), T_('%d directories'), T_('No directories') );
			echo ', ';
			disp_cond( $fm_Filelist->count_files(), T_('One file'), T_('%d files'), T_('No files' ) );
			echo ', '.bytesreadable( $fm_Filelist->count_bytes() );
			?>
			)
		</div>

			</td>
		</tr>
	</thead>

	<tbody>
		<tr>
			<?php
				// ______________________________ Directory tree ______________________________
				if( ! $fm_hide_dirtree )
				{
					echo '<td id="fm_dirtree">';

					// Version with all roots displayed
					//echo get_directory_tree( NULL, NULL, $ads_list_path );

					// Version with only the current root displayed:
					echo get_directory_tree( $fm_Filelist->_FileRoot, $fm_Filelist->_FileRoot->ads_path, $ads_list_path );

					echo '</td>';
				}

				echo '<td id="fm_files">';
				// ______________________________ Files ______________________________

				require dirname(__FILE__).'/_file_list.inc.php';

				// ______________________________ Toolbars ______________________________
				echo '<div id="fileman_toolbars_bottom">';

				/*
				 * CREATE FILE/FOLDER TOOLBAR:
				 */
				if( ($Settings->get( 'fm_enable_create_dir' ) || $Settings->get( 'fm_enable_create_file' ))
							&& $current_User->check_perm( 'files', 'add' ) )
				{ // dir or file creation is enabled and we're allowed to add files:
					global $create_type;

					echo '<div class="toolbaritem">';
					$Form = & new Form( NULL, 'fmbar_create_checkchanges', 'post', 'none' );
					$Form->begin_form();
						$Form->hidden( 'action', 'createnew' );
						$Form->hidden_ctrl();
						$Form->hiddens_by_key( get_memorized() );
						if( ! $Settings->get( 'fm_enable_create_dir' ) )
						{	// We can create files only:
							echo '<label for="fm_createname" class="tooltitle">'.T_('New file:').'</label>';
							echo '<input type="hidden" name="create_type" value="file" />';
						}
						elseif( ! $Settings->get( 'fm_enable_create_file' ) )
						{	// We can create directories only:
							echo '<label for="fm_createname" class="tooltitle">'.T_('New folder:').'</label>';
							echo '<input type="hidden" name="create_type" value="dir" />';
						}
						else
						{	// We can create both files and directories:
							echo T_('New').': ';
							echo '<select name="create_type">';
							echo '<option value="dir"';
							if( isset($create_type) &&  $create_type == 'dir' )
							{
								echo ' selected="selected"';
							}
							echo '>'.T_('folder').'</option>';

							echo '<option value="file"';
							if( isset($create_type) && $create_type == 'file' )
							{
								echo ' selected="selected"';
							}
							echo '>'.T_('file').'</option>';
							echo '</select>:';
						}
					?>
					<input type="text" name="create_name" id="fm_createname" value="<?php
						if( isset( $create_name ) )
						{
							echo $create_name;
						} ?>" size="15" />
					<input class="ActionButton" type="submit" value="<?php echo format_to_output( T_('Create!'), 'formvalue' ) ?>" />
					<?php
					$Form->end_form();
					echo '</div>';
				}


				/*
				 * UPLOAD:
				 */
				if( $Settings->get('upload_enabled') && $current_User->check_perm( 'files', 'add' ) )
				{	// Upload is enabled and we have permission to use it...
					echo "<!-- QUICK UPLOAD: -->\n";
					echo '<div class="toolbaritem">';
					$Form = & new Form( NULL, 'fmbar_quick_upload', 'post', 'none', 'multipart/form-data' );
					$Form->begin_form();
						$Form->hidden( 'ctrl', 'upload' );
						$Form->hidden( 'upload_quickmode', 1 );
						// The following is mainly a hint to the browser.
						$Form->hidden( 'MAX_FILE_SIZE', $Settings->get( 'upload_maxkb' )*1024 );
						$Form->hiddens_by_key( get_memorized('ctrl') );
						echo '<div>';
						echo '<input name="uploadfile[]" type="file" size="10" />';
						echo '<input class="ActionButton" type="submit" value="&gt; '.T_('Quick upload!').'" />';
						echo '</div>';
					$Form->end_form();
					echo '</div>';
				}

				echo '</div>';
				echo '<div class="clear"></div>';

				echo '</td>'
			?>
		</tr>
	</tbody>
</table>

<?php
	$Widget->disp_template_raw( 'block_end' );


?>