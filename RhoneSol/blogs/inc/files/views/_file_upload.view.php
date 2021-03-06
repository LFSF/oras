<?php
/**
 * This file implements the UI for file upload.
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
 * @version $Id: _file_upload.view.php,v 1.7 2008/01/21 09:35:30 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Settings
 */
global $Settings;

global $UserSettings;

global $upload_quickmode, $failedFiles, $ads_list_path, $uploadwithproperties;

global $fm_FileRoot;
?>

<script type="text/javascript">
	<!--
	/**
	 * Mighty cool function to append an input or textarea element onto another element.
	 *
	 * @usedby addAnotherFileInput()
	 */
	function appendLabelAndInputElements( appendTo, labelText, labelBr, inputOrTextarea, inputName,
	                                      inputSizeOrCols, inputMaxLengthOrRows, inputType, inputClass )
	{
		// LABEL:

		// var fileDivLabel = document.createElement("div");
		// fileDivLabel.className = "label";

		var fileLabel = document.createElement('label');
		var fileLabelText = document.createTextNode( labelText );
		fileLabel.appendChild( fileLabelText );

		// fileDivLabel.appendChild( fileLabel )

		appendTo.appendChild( fileLabel );

		if( labelBr )
		{ // We want a BR after the label:
			appendTo.appendChild( document.createElement('br') );
		}
		else
		{
			appendTo.appendChild( document.createTextNode( ' ' ) );
		}

		// INPUT:

		// var fileDivInput = document.createElement("div");
		// fileDivInput.className = "input";

		var fileInput = document.createElement( inputOrTextarea );
		fileInput.name = inputName;
		if( inputOrTextarea == "input" )
		{
			fileInput.type = typeof( inputType ) !== 'undefined' ?
												inputType :
												"text";
			fileInput.size = inputSizeOrCols;
			if( typeof( inputMaxLengthOrRows ) != 'undefined' )
			{
				fileInput.maxlength = inputMaxLengthOrRows;
			}
		}
		else
		{
			fileInput.cols = inputSizeOrCols;
			fileInput.rows = inputMaxLengthOrRows;
		}

		fileInput.className = inputClass;

		// fileDivInput.appendChild( fileInput );

		appendTo.appendChild( fileInput );
		appendTo.appendChild( document.createElement('br') );
	}


	/**
	 * Add a new fileinput area to the upload form.
	 */
	function addAnotherFileInput()
	{
		var uploadfiles = document.getElementById("uploadfileinputs");
		var newLI = document.createElement("li");
		var closeLink = document.createElement("a");
		var closeImage = document.createElement("img");

		uploadfiles.appendChild( newLI );
		newLI.appendChild( closeLink );
		closeLink.appendChild( closeImage );


		newLI.className = "clear";

		closeImage.src = "<?php echo get_icon( 'close', 'url' ) ?>";
		closeImage.alt = "<?php echo get_icon( 'close', 'alt' ) ?>";

		<?php
		$icon_class = get_icon( 'close', 'class' );
		if( $icon_class )
		{
			?>
			closeImage.className = '<?php echo $icon_class ?>';
			<?php
		}

		if( get_icon( 'close', 'rollover' ) )
		{ // handle rollover images ('close' by default is one).
			?>
			closeLink.className = 'rollover';
			if( typeof setupRollovers == 'function' )
			{
				setupRollovers();
			}
			<?php
		}
		?>
		closeImage.setAttribute( 'onclick', "document.getElementById('uploadfileinputs').removeChild(this.parentNode.parentNode);" ); // TODO: setting onclick this way DOES NOT work in IE. (try attachEvent then)
		closeLink.style.cssFloat = 'right';		// standard (not working in IE)
		closeLink.style.styleFloat = 'right'; // IE

		appendLabelAndInputElements( newLI, '<?php echo TS_('Choose a file'); ?>:', false, 'input', 'uploadfile[]', '70', '0', 'file', 'upload_file' );
		<?php
		if( $uploadwithproperties )
		{	// We want file properties on the upload form:
			?>
		appendLabelAndInputElements( newLI, '<?php echo TS_('Filename on server (optional)'); ?>:', false, 'input', 'uploadfile_name[]', '50', '80', 'text', '' );
		appendLabelAndInputElements( newLI, '<?php echo TS_('Long title'); ?>:', true, 'input', 'uploadfile_title[]', '50', '255', 'text', 'large' );
		appendLabelAndInputElements( newLI, '<?php echo TS_('Alternative text (useful for images)'); ?>:', true, 'input', 'uploadfile_alt[]', '50', '255', 'text', 'large' );
		appendLabelAndInputElements( newLI, '<?php echo TS_('Caption/Description of the file'); ?>:', true, 'textarea', 'uploadfile_desc[]', '38', '3', '', 'large' );
			<?php
		}
		?>
	}
	// -->
</script>

<?php
	// Begin payload block:
	$this->disp_payload_begin();


	$Form = & new Form( NULL, 'fm_upload_checkchanges', 'post', 'none', 'multipart/form-data' );
	$Form->begin_form( 'fform' );
		$Form->hidden_ctrl();
		$Form->hidden( 'MAX_FILE_SIZE', $Settings->get( 'upload_maxkb' )*1024 ); // Just a hint for the browser.
		$Form->hidden( 'upload_quickmode', $upload_quickmode );
		$Form->hiddens_by_key( get_memorized() );


	$Widget = & new Widget( 'file_browser' );

	$Widget->global_icon( T_('Quit upload mode!'), 'close', regenerate_url( 'ctrl,fm_mode', 'ctrl=files' ) );

	$Widget->title = T_('File upload').get_manual_link('upload_multiple');
	$Widget->disp_template_replaced( 'block_start' );


?>

<table id="fm_browser" cellspacing="0" cellpadding="0">
	<thead>
		<tr>
			<td colspan="2" id="fm_bar">
			<?php
				if( $uploadwithproperties )
				{
					echo '<a href="'.regenerate_url( 'uploadwithproperties', 'uploadwithproperties=0' ).'">'.T_('Hide advanced upload properties').'</a>';
				}
				else
				{
					echo '<a href="'.regenerate_url( 'uploadwithproperties', 'uploadwithproperties=1' ).'">'.T_('Show advanced upload properties').'</a>';
				}
			?>
			</td>
		</tr>
	</thead>

	<tbody>
		<tr>
			<?php
				echo '<td id="fm_dirtree">';

				// Version with all roots displayed
				echo get_directory_tree( NULL, NULL, $ads_list_path, true );

				// Version with only the current root displayed:
				// echo get_directory_tree( $fm_FileRoot, $fm_FileRoot->ads_path, $ads_list_path, true );

				echo '</td>';

				echo '<td id="fm_files">';


		if( count( $failedFiles ) )
		{
			echo '<p class="error">'.T_('Some file uploads failed. Please check the errors below.').'</p>';
		}
		?>

			<div class="upload_title"><?php echo T_('Files to upload') ?></div>

			<ul id="uploadfileinputs">
				<?php
					if( empty($failedFiles) )
					{ // No failed failes, display 5 empty input blocks:
						$displayFiles = array( NULL, NULL, NULL, NULL, NULL );
					}
					else
					{ // Display failed files:
						$displayFiles = & $failedFiles;
					}

					foreach( $displayFiles as $lKey => $lMessage )
					{ // For each file upload block to display:

						if( $lMessage !== NULL )
						{ // This is a failed upload:
							echo '<li class="invalid" title="'
											./* TRANS: will be displayed as title for failed file uploads */ T_('Invalid submission.').'">';
							echo '<p class="error">'.$lMessage.'</p>';
						}
						else
						{ // Not a failed upload, display normal block:
							echo '<li>';
						}

						// fp> TODO: would be cool to add a close icon starting at the 2nd <li>
						// dh> TODO: it may be useful to add the "accept" attrib to the INPUT elements to give the browser a hint about the accepted MIME types
						?>

						<label><?php echo T_('Choose a file'); ?>:</label>
						<input name="uploadfile[]" size="70" type="file" class="upload_file" /><br />

						<?php
						if( $uploadwithproperties )
						{	// We want file properties on the upload form:
							?>
							<label><?php echo T_('Filename on server (optional)'); ?>:</label>
							<input name="uploadfile_name[]" type="text" size="50" maxlength="80"
								value="<?php echo ( isset( $uploadfile_name[$lKey] ) ? format_to_output( $uploadfile_name[$lKey], 'formvalue' ) : '' ) ?>" /><br />

							<label><?php echo T_('Long title'); ?>:</label><br />
							<input name="uploadfile_title[]" type="text" size="50" maxlength="255" class="large"
								value="<?php echo ( isset( $uploadfile_title[$lKey] ) ? format_to_output( $uploadfile_title[$lKey], 'formvalue' ) : '' );
								?>" /><br />

							<label><?php echo T_('Alternative text (useful for images)'); ?>:</label><br />
							<input name="uploadfile_alt[]" type="text" size="50" maxlength="255" class="large"
								value="<?php echo ( isset( $uploadfile_alt[$lKey] ) ? format_to_output( $uploadfile_alt[$lKey], 'formvalue' ) : '' );
								?>" /><br />

							<label><?php echo T_('Caption/Description of the file'); /* TODO: maxlength (DB) */ ?>:</label><br />
							<textarea name="uploadfile_desc[]" rows="3" cols="38" class="large"><?php
								echo ( isset( $uploadfile_desc[$lKey] ) ? $uploadfile_desc[$lKey] : '' )
							?></textarea><br />
							<?php
						}

						echo '</li>';
						// no text after </li> or JS will bite you! (This is where additional blocks get inserted)
					}

				?>
			</ul>

			<p class="uploadfileinputs"><a href="#" onclick="addAnotherFileInput(); return false;" class="small"><?php echo T_('Add another file'); ?></a></p>

			<div class="upload_foot">
				<input type="submit" value="<?php echo format_to_output( T_('Upload to server now'), 'formvalue' ); ?>" class="ActionButton" >
				<input type="reset" value="<?php echo format_to_output( T_('Reset'), 'formvalue' ); ?>" class="ResetButton">

				<p class="note">
					<?php
					$restrictNotes = array();

					// Get list of recognized file types (others are not allowed to get uploaded)
					// dh> because FiletypeCache/DataObjectCache has no interface for getting a list, this dirty query seems less dirty to me.
					$allowed_extensions = $DB->get_col( 'SELECT ftyp_extensions FROM T_filetypes WHERE ftyp_allowed != 0' );
					$allowed_extensions = implode( ' ', $allowed_extensions ); // implode with space, ftyp_extensions can hold many, separated by space
					// into array:
					$allowed_extensions = preg_split( '~\s+~', $allowed_extensions, -1, PREG_SPLIT_NO_EMPTY );
					// readable:
					$allowed_extensions = implode_with_and($allowed_extensions);

					$restrictNotes[] = '<strong>'.T_('Allowed file extensions').'</strong>: '.$allowed_extensions;

					if( $Settings->get( 'upload_maxkb' ) )
					{ // We want to restrict on file size:
						$restrictNotes[] = '<strong>'.T_('Maximum allowed file size').'</strong>: '.bytesreadable( $Settings->get( 'upload_maxkb' )*1024 );
					}

					echo implode( '<br />', $restrictNotes ).'<br />';
					?>
				</p>
			</div>

		</td>
		</tr>
	</tbody>
</table>

<?php

	$Widget->disp_template_raw( 'block_end' );

	$Form->end_form();

	// End payload block:
	$this->disp_payload_end();


?>