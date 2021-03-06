<?php
/**
 * This file implements the Fast Form handling class.
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 * Parts of this file are copyright (c)2004 by PROGIDISTRI - {@link http://progidistri.com/}.
 * Parts of this file are copyright (c)2004-2005 by Daniel HAHLER - {@link http://thequod.de/contact}.
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
 *
 * PROGIDISTRI grants Francois PLANQUE the right to license
 * PROGIDISTRI's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER
 * @author fplanque: Francois PLANQUE.
 * @author fsaya: Fabrice SAYA-GASNIER / PROGIDISTRI
 * @author mbruneau: Marc BRUNEAU / PROGIDISTRI
 *
 * @todo Provide buffering of whole Form to be able to add onsubmit-JS to enable/disabled
 *       (group) checkboxes again and other useful stuff.
 *
 * NOTE: we use an member array ($_common_params) for exchanging params between functions.
 * This will most probably cause problems, when nesting inputs. This should be refactored
 * to use a field_name-based member array. (blueyed)
 *
 * @version $Id: _form.class.php,v 1.24.2.1 2008/02/09 16:19:18 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_funcs( '_core/ui/_uiwidget.class.php' );

/**
 * Form class
 *
 * @package evocore
 */
class Form extends Widget
{
	/**
	 * Output HTML or just return it?
	 * @var boolean
	 */
	var $output = true;

	/**
	 * Remember number of open tags that need to be handled in {@link end_form()}.
	 *
	 * @var array
	 */
	var $_opentags = array( 'fieldset' => 0 );

	/**
	 * Suffix for LABELs.
	 * @var string
	 */
	var $label_suffix = ':';


	/**
	 * Common params shared between methods.
	 *
	 * These can all be used with the $field_params argument of the functions.
	 *
	 * - 'note': The note associated with the field.
	 * - 'note_format': The format of the note. %s gets replaced by the note.
	 * - 'label': The label for the field.
	 * - 'required': is the element required to be filled/checked? This will add a visual hint (boolean; default: false)
	 *
	 * @see handle_common_params()
	 * @var array
	 */
	var $_common_params = array();

	/**
	 * This is the default note format, where {@link handle_common_params()} falls
	 * back to, when not given with $field_params.
	 * @todo This might be used in switch_layout().
	 * @var string
	 */
	var $note_format = ' <span class="notes">%s</span>';

	/**
	 * This is a buffer for hidden fields. We'll display all of them just before the end of form </form>. This avoids having them caught in between table rows.
	 *
	 * @var string
	 */
	var $hiddens = array();

	/**
	 * Do we need to add javascript for check/uncheck all functionality
	 */
	var $check_all = false;

	/**
	 * Additional Javascript to append to the form, in {@link Form::end_form()}.
	 *
	 * @access protected
	 * @var array
	 */
	var $append_javascript = array();

	/**
	 * Display param errors with fields, appended to the note?
	 * @var boolean
	 */
	var $disp_param_err_messages_with_fields = true;

	/**
	 * Stack of previous used layouts
	 * @see Form::switch_layout()
	 * @var array
	 */
	var $saved_layouts;
	var $saved_templates;


	/**
	 * Constructor
	 *
	 * @param string the action destination of the form (NULL for pagenow)
	 * @param string the name of the form (will be used as an ID)
	 * @param string the action to execute when the form is submitted
	 * @param string the method used to send data
	 * @param string the form layout : 'fieldset', 'table' or '' (NULL means: if there is an {@link $AdminUI} object get it from there, otherwise use 'fieldset')
	 */
	function Form( $form_action = NULL, $form_name = '', $form_method = 'post', $layout = NULL, $enctype = '' )
	{
		global $AdminUI, $pagenow;

		$this->form_name = $form_name;
		$this->form_action = (is_null($form_action) ? $pagenow : $form_action );
		$this->form_method = $form_method;
		$this->enctype = $enctype;

		if( is_object($AdminUI) )
		{
			if( empty( $layout ) || $layout == 'split' || $layout == 'none' || $layout == 'fieldset' )
			{ // Get default skin setting:
				$template = $AdminUI->get_template( 'Form' );
				$layout = $template['layout'];
			}
			else
			{
				$template = $AdminUI->get_template( $layout.'_form' );
				$layout = $template['layout'];
			}
		}
		else
		{	// This happens for comment forms & login screen for example...
			$template = array(
				'layout' => 'fieldset',
				'formstart' => '<div>',// required before (no_)title_fmt for validation
				'title_fmt' => '<span style="float:right">$global_icons$</span><h2>$title$</h2>'."\n",
				'no_title_fmt' => '<span style="float:right">$global_icons$</span>'."\n",
				'fieldset_begin' => '<fieldset $fieldset_attribs$>'."\n"
														.'<legend $title_attribs$>$fieldset_title$</legend>'."\n",
				'fieldset_end' => '</fieldset>'."\n",
				'fieldstart' => '<fieldset$ID$>'."\n",
				'labelstart' => '<div class="label">',
				'labelend' => "</div>\n",
				'labelempty' => '<div class="label"></div>', // so that IE6 aligns DIV.input correcctly
				'inputstart' => '<div class="input">',
				'infostart' => '<div class="info">',
				'inputend' => "</div>\n",
				'fieldend' => "</fieldset>\n\n",
				'buttonsstart' => '<fieldset><div class="label"></div><div class="input">', // DIV.label for IE6
				'buttonsend' => "</div></fieldset>\n\n",
				'formend' => '</div>',
			);
			$layout = 'fieldset';
		}

		$this->saved_layouts = array($layout);
		$this->saved_templates = array($template);
		$this->switch_layout( NULL );	// "restore" saved layout.
	}


	/**
	 * @param string|NULL the form layout : 'fieldset', 'table' or ''; NULL to restore previsouly saved layout
	 */
	function switch_layout( $layout )
	{
		if( $layout == NULL )
		{ // we want to restore previous layout:
			if( count($this->saved_layouts) )
			{
				$this->layout = array_shift($this->saved_layouts);
				// Temporary hack:
				$template = array_shift($this->saved_templates);
				if( !empty($template ) )
				{
					//pre_dump($template);
					$this->template =     $template;
					$this->formstart =    $template['formstart'];
					$this->title_fmt =    $template['title_fmt'];
					$this->no_title_fmt = $template['no_title_fmt'];
					$this->fieldstart =   $template['fieldstart'];
					$this->labelstart =   $template['labelstart'];
					$this->labelend =     $template['labelend'];
					$this->labelempty =   $template['labelempty'];
					$this->inputstart =   $template['inputstart'];
					$this->infostart =    $template['infostart'];
					$this->inputend =     $template['inputend'];
					$this->fieldend =     $template['fieldend'];
					$this->buttonsstart = $template['buttonsstart'];
					$this->buttonsend =   $template['buttonsend'];
					$this->formend =      $template['formend'];
				}
			}
		}
		else
		{ // We want to switch to a new layout
			array_unshift( $this->saved_layouts, $this->layout );
			$this->layout = $layout;

			switch( $this->layout )
			{
				case 'table':
					$this->formstart = '<table cellspacing="0" class="fform">'."\n";
					// Note: no thead in here until you can safely add a tbody to the rest of the content...
					$this->title_fmt = '<tr class="formtitle"><th colspan="2"><div class="results_title">'
															.'<span class="right_icons">$global_icons$</span>'
															.'$title$</div></th></tr>'."\n";
					$this->no_title_fmt = '<tr><th colspan="2"><span class="right_icons">$global_icons$</span></th></tr>'."\n";
					$this->fieldstart = '<tr$ID$>'."\n";
					$this->labelstart = '<td class="label">';
					$this->labelend = "</td>\n";
					$this->labelempty = '<td class="label">&nbsp;</td>'."\n";
					$this->inputstart = '<td class="input">';
					$this->infostart = '<td class="info">';
					$this->inputend = "</td>\n";
					$this->fieldend = "</tr>\n\n";
					$this->buttonsstart = '<tr class="buttons"><td colspan="2">';
					$this->buttonsend = "</td></tr>\n";
					$this->formend = "</table>\n";
					break;

				case 'fieldset':
					$this->formstart = '<div>';// required before (no_)title_fmt for validation
					$this->title_fmt = '<span style="float:right">$global_icons$</span><h2>$title$</h2>'."\n";
					$this->no_title_fmt = '<span style="float:right">$global_icons$</span>'."\n";
					$this->fieldstart = '<fieldset$ID$>'."\n";
					$this->labelstart = '<div class="label">';
					$this->labelend = "</div>\n";
					$this->labelempty = '<div class="label"></div>'; // so that IE6 aligns DIV.input correcctly
					$this->inputstart = '<div class="input">';
					$this->infostart = '<div class="info">';
					$this->inputend = "</div>\n";
					$this->fieldend = "</fieldset>\n\n";
					$this->buttonsstart = '<fieldset><div class="label"></div><div class="input">'; // DIV.label for IE6
					$this->buttonsend = "</div></fieldset>\n\n";
					$this->formend = '</div>';
					break;

				case 'chicago':		// Temporary dirty hack
					$this->formstart = '<div>';// required before (no_)title_fmt for validation
					$this->title_fmt = '<span style="float:right">$global_icons$</span><h2>$title$</h2>'."\n";
					$this->no_title_fmt = '<span style="float:right">$global_icons$</span>'."\n";
					$this->fieldstart = '<fieldset$ID$>'."\n";
					$this->labelstart = '<div class="label">';
					$this->labelend = "</div>\n";
					$this->labelempty = '<div class="label"></div>'; // so that IE6 aligns DIV.input correcctly
					$this->inputstart = '<div class="input">';
					$this->infostart = '<div class="info">';
					$this->inputend = "</div>\n";
					$this->fieldend = "</fieldset>\n\n";
					$this->buttonsstart = '<fieldset><div class="label"></div><div class="input">'; // DIV.label for IE6
					$this->buttonsend = "</div></fieldset>\n\n";
					$this->formend = '</div>';
					break;

				case 'linespan':
					$this->formstart = '';
					$this->title_fmt = '<span style="float:right">$global_icons$</span><h2>$title$</h2>'."\n";
					$this->no_title_fmt = '<span style="float:right">$global_icons$</span>&nbsp;'."\n";
					$this->fieldstart = '<div class="tile"$ID$>';
					$this->labelstart = '<strong>';
					$this->labelend = "</strong>\n";
					$this->labelempty = '';
					$this->inputstart = '';
					$this->infostart = '';
					$this->inputend = "\n";
					$this->fieldend = "</div>\n";
					$this->buttonsstart = '';
					$this->buttonsend = "\n";
					$this->formend = '';
					break;

				case 'blockspan':
					$this->formstart = '';
					$this->title_fmt = '$title$'."\n"; // TODO: icons
					$this->no_title_fmt = '';          //           "
					$this->fieldstart = '<span class="block"$ID$>';
					$this->labelstart = '';
					$this->labelend = "\n";
					$this->labelempty = '';
					$this->inputstart = '';
					$this->infostart = '';
					$this->inputend = "\n";
					$this->fieldend = '</span>'.get_icon( 'pixel' )."\n";
					$this->buttonsstart = '';
					$this->buttonsend = "\n";
					$this->formend = '';
					break;

				default:
					// "none" (no layout)
					$this->formstart = '';
					$this->title_fmt = '$title$'."\n"; // TODO: icons
					$this->no_title_fmt = '';          //           "
					$this->fieldstart = ''; // fp> shall we still use $ID$ here ?
					$this->labelstart = '';
					$this->labelend = "\n";
					$this->labelempty = '';
					$this->inputstart = '';
					$this->infostart = '';
					$this->inputend = "\n";
					$this->fieldend = "\n";
					$this->buttonsstart = '';
					$this->buttonsend = "\n";
					$this->formend = '';
			}

		}
	}


	/**
	 * Start an input field.
	 *
	 * A field is a fielset containing a label div and an input div.
	 *
	 * @uses $_common_params
	 * @param string The name of the field
	 * @param string The field label
	 * @param boolean Reset {@link $_common_params}? This should be used if you build a field by yourself.
	 * @return The generated HTML
	 */
	function begin_field( $field_name = NULL, $field_label = NULL, $reset_common_params = false )
	{
		if( $reset_common_params )
		{
			$this->_common_params = array();
		}
		// Remember these, to make them available to get_label()
		if( isset($field_name) )
		{
			$this->_common_params['name'] = $field_name;
		}
		if( isset($field_label) )
		{
			$this->_common_params['label'] = $field_label;
		}

		// Start the new form field and inject an automatic DOM id
		// This is useful to show/hide the whole field by JS.
		if( !empty(	$this->_common_params['id'] ) )
		{
			$ffield_id = ' id="ffield_'.$this->_common_params['id'].'" ';
		}
		else
		{	// No ID in case there's no id/name given for a field.
			$ffield_id = '';
		}
		$r = str_replace( '$ID$', $ffield_id, $this->fieldstart );

		if( isset($this->_common_params['field_prefix']) )
		{
			$r .= $this->_common_params['field_prefix'];
		}

		$r .= $this->get_label();

		$r .= $this->inputstart;

		return $r;
	}


	/**
	 * End an input field.
	 *
	 * A field is a fielset containing a label div and an input div.
	 *
	 * @param string Field's note to display. (deprecated)
	 * @param string Format of the field's note (%s gets replaced with the note). (deprecated)
	 * @return The generated HTML
	 */
	function end_field( $field_note = NULL, $field_note_format = NULL )
	{
		if( isset($field_note) ) // Note: allow "0" as a note
		{ // deprecated - should get set by calling handle_common_params()
			$this->_common_params['note'] = $field_note;
		}
		if( isset($field_note_format) )
		{ // deprecated - should get set by calling handle_common_params()
			$this->_common_params['note_format'] = $field_note_format;
		}

		$r = '';

		if( !empty($this->_common_params['note']) )
		{ // We have a note
			$r .= sprintf( $this->_common_params['note_format'], $this->_common_params['note'] );
		}

		if( isset($this->_common_params['field_suffix']) )
		{
			$r .= $this->_common_params['field_suffix'];
		}

		$r .= $this->inputend.$this->fieldend;

		return $r;
	}


	/**
	 * Builds a fieldset tag. This is a fieldset element by default, but a th element
	 * for table layout.
	 *
	 * @param string the title of the fieldset
	 * @param string the field params to the fieldset
	 *               additionally 'legend_params' can be used to give an array of field params
	 * @return true|string true (if output) or the generated HTML if not outputting
	 */
	function begin_fieldset( $title = '', $field_params = array() )
	{
		if( !isset($field_params['class']) )
		{
			$field_params['class'] = 'fieldset';
		}

		switch( $this->layout )
		{
			case 'table':
				$r = '<tr'.get_field_attribs_as_string($field_params).'><th colspan="2">'."\n";
				// NOTE: empty THs can be rendered and/or are DHTML scriptable

				if( $title != '' )
				{ // there is a title to display
					$r .= $title;
				}

				$r .= "</th></tr>\n";
				break;

			default:
				if( ! empty($field_params['legend_params']) )
				{	// We have params specifically passed for the title
					$legend_params = $field_params['legend_params'];
					unset( $field_params['legend_params'] );
				}

				$r = str_replace( '$fieldset_attribs$', get_field_attribs_as_string($field_params), $this->template['fieldset_begin'] );
				// $r = '<fieldset'.get_field_attribs_as_string($field_params).'>'."\n";

				$r = str_replace( '$fieldset_title$', $title, $r );

				if( empty($legend_params) )
				{ // there are no legend_params, remove the placeholder
					$r = str_replace( '$title_attribs$', '', $r );
				}
				else
				{
					$r = str_replace( '$title_attribs$', get_field_attribs_as_string($legend_params), $r );
				}

				// Remove any empty legend tags: they cause a small gap in the fieldset border (FF 2.0.0.11)
				$r = preg_replace('~<legend[^>]*></legend>~', '', $r);

				$this->_opentags['fieldset']++;
		}

		return $this->display_or_return( $r );
	}


	/**
	 * Ends a fieldset.
	 *
	 * @return true|string true (if output) or the generated HTML if not outputting
	 */
	function end_fieldset()
	{
		switch( $this->layout )
		{
			case 'table':
				$r = '';
				break;

			default:
				$r = $this->template['fieldset_end'];
				$this->_opentags['fieldset']--;
		}

		return $this->display_or_return( $r );
	}


	/**
	 * Builds a text (or password) input field.
	 *
	 * Note: please use {@link Form::password_input()} for password fields.
	 *
	 * @param string The name of the input field. This gets used for id also, if no id given in $field_params.
	 * @param string Initial value
	 * @param integer Size of the input field
	 * @param string Label displayed with the field
	 * @param string "help" note (Should provide something useful, otherwise leave it empty)
	 * @param array Extended attributes/params.
	 *                 - 'maxlength': if not set, $field_size gets used (use '' to disable it)
	 *                 - 'class': the CSS class to use for the <input> element
	 *                 - 'type': 'text', 'password' (defaults to 'text')
	 *                 - 'force_to': 'UpperCase' (JS onchange handler)
	 *                 - NOTE: any other attributes will be used as is (onchange, onkeyup, id, ..).
	 * @return true|string true (if output) or the generated HTML if not outputting
	 */
	function text_input( $field_name, $field_value, $field_size, $field_label, $field_note = '', $field_params = array() )
	{
		$field_params['value'] = $field_value;

		if( !empty($field_note) )
		{
			$field_params['note'] = $field_note;
		}

		if( !empty($field_size) )
		{
			if( !isset($field_params['maxlength']) )
			{ // maxlength defaults to size
				$field_params['maxlength'] = $field_size;
			}

			$field_params['size'] = $field_size;
		}

		if( !isset($field_params['type']) )
		{ // type defaults to "text"
			$field_params['type'] = 'text';
		}

		if( isset($field_params['force_to']) )
		{
			if( $field_params['force_to'] == 'UpperCase' )
			{ // Force input to uppercase (at front of onchange event)
				$field_params['onchange'] = 'this.value = this.value.toUpperCase();'
					.( empty($field_params['onchange']) ? '' : ' '.$field_params['onchange'] );
			}
			unset($field_params['force_to']); // not a html attrib
		}

		// Give it a class, so it can be selected for CSS in IE6
		if( empty($field_params['class']) ) $field_params['class'] = 'form_text_input';
		else $field_params['class'] .= ' form_text_input';

		$field_params['name'] = $field_name;
		$field_params['label'] = $field_label;
		return $this->input_field( $field_params );
	}


	/**
	 * Builds a text (or password) input field.
	 *
	 * Note: please use {@link Form::password()} for password fields
	 *
	 * @param string the name of the input field
	 * @param string initial value
	 * @param integer size of the input field
	 * @param string label displayed in front of the field
	 * @param string note displayed with field
	 * @param integer max length of the value (if 0 field_size will be used!)
	 * @param string the CSS class to use
	 * @param string input type (only 'text' or 'password' makes sense)
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function text( $field_name, $field_value, $field_size, $field_label, $field_note = '',
											$field_maxlength = 0, $field_class = '', $inputtype = 'text', $force_to = '' )
	{
		$field_params = array();

		if( $field_maxlength !== 0 )
		{
			$field_params['maxlength'] = $field_maxlength;
		}
		if( $field_class !== '' )
		{
			$field_params['class'] = $field_class;
		}
		if( $inputtype !== 'text' )
		{
			$field_params['type'] = $inputtype;
		}
		if( $force_to !== '' )
		{
			$field_params['force_to'] = $force_to;
		}

		return $this->text_input( $field_name, $field_value, $field_size, $field_label, $field_note, $field_params );
	}


	/**
	 * Builds a password input field.
	 *
	 * Calls the text_input() method with type == 'password'.
	 *
	 * @param string The name of the input field. This gets used for id also, if no id given in $field_params.
	 * @param string Initial value
	 * @param integer Size of the input field
	 * @param string Label displayed in front of the field
	 * @param string Note displayed with field
	 * @param integer Max length of the value (if 0 field_size will be used!)
	 * @param string Extended attributes, see {@link text_input()}.
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function password_input( $field_name, $field_value, $field_size, $field_label, $field_params = array() )
	{
		$field_params['type'] = 'password';

		return $this->text_input( $field_name, $field_value, $field_size, $field_label, '', $field_params );	// TEMP: Note already in params
	}


	/**
	 * Builds a password input field.
	 *
	 * Calls the text() method with a 'password' parameter.
	 *
	 * @param string the name of the input field
	 * @param string initial value
	 * @param integer size of the input field
	 * @param string label displayed in front of the field
	 * @param string note displayed with field
	 * @param integer max length of the value (if 0 field_size will be used!)
	 * @param string the CSS class to use
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function password( $field_name, $field_value, $field_size, $field_label, $field_note = '',
											$field_maxlength = 0 , $field_class = '' )
	{
		$field_params = array( 'type' => 'password' );

		if( $field_maxlength !== 0 )
		{
			$field_params['maxlength'] = $field_maxlength;
		}
		if( !empty($field_class) )
		{
			$field_params['class'] = $field_class;
		}

		return $this->text_input( $field_name, $field_value, $field_size, $field_label, $field_note, $field_params );
	}


	/**
	 * Builds a date input field.
	 *
	 * @param string the name of the input field
	 * @param string initial value (ISO datetime (YYYY-MM-DD HH:MM:SS)
	 *               or erroneous if the field is in error state)
	 * @param string label displayed in front of the field
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - date_format: Format of the date (string, PHP format, default taken from {@link locale_datefmt()})
	 *              - add_date_format_note: If true, date format note gets prepended to the field's note
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function date_input( $field_name, $field_value, $field_label, $field_params = array() )
	{
		global $month, $weekday_letter;

		if( empty($field_params['date_format']) )
		{	// Use locale date format:
			$date_format = locale_datefmt();
		}
		else
		{
			$date_format = $field_params['date_format'];
		}
		// Don't keep that attrib in the list:
		unset( $field_params['date_format'] );

		// Convert PHP date format to JS library date format (date.js):
		// NOTE: when editing/extending this here, you probably also have to adjust param_check_date()!
		$js_date_format = preg_replace_callback( '~(\\\)?(\w)~', create_function( '$m', '
			if( $m[1] == "\\\" ) return "\\\".$m[0]; // leave escaped
			switch( $m[2] )
			{
				case "d": return "dd"; // day, 01-31
				case "j": return "d"; // day, 1-31
				case "l": return "EE"; // weekday (name)
				case "D": return "E"; // weekday (abbr)
				case "e": return ""; // weekday letter, not supported

				case "m": return "MM"; // month, 01-12
				case "n": return "M"; // month, 1-12
				case "F": return "MMM"; // full month name; "name or abbr" in date.js
				case "M": return "NNN"; // month name abbr

				case "y": return "yy"; // year, 00-99
				case "Y": return "yyyy"; // year, XXXX
				default:
					return $m[0];
			}' ), $date_format );
		#pre_dump( $js_date_format );

		if( param_has_error( $field_name ) )
		{ // There is an error message for this field:

			// We do not try to format the date, we keep the erroneous date.
			//echo 'error on '.$field_name.' keep erroneous entry intact ';

			$field_params['value'] = trim(substr( $field_value, 0, 10 ));
		}
		else
		{ // Make the date value clean for display:

			// The date value may be compact, in this case we have to decompact it
			if( preg_match( '/^[0-9]+$/', $field_value ) )
			{	// The date is compact, so we decompact it
				$field_value = decompact_date( $field_value );
			}

			// Get DATE part of datetime and format it to locale format:
			$field_params['value'] = mysql2date( $date_format, $field_value );
		}


		if( !empty($field_params['add_date_format_note']) )
		{ // Prepend $date_format to note
			$field_params['note'] = empty($field_params['note'])
				? '('.$date_format.')'
				: '('.$date_format.') '.$field_params['note'];
		}
		unset( $field_params['add_date_format_note'] );


		if( !isset($field_params['size']) )
		{ // Get size out of $date_format if not explicitly set
			$field_params['size'] = strlen( $js_date_format );
		}

		/*
		dh> do not use maxlength by default. Makes no sense IMHO and fails with dateformats like "j \d\e F, Y"
		if( !isset($field_params['maxlength']) )
		{
			$field_params['maxlength'] = $field_params['size'];
		}
		*/

		// Give it a class, so it can be selected for CSS in IE6
		if( empty($field_params['class']) ) $field_params['class'] = 'form_date_input';
		else $field_params['class'] .= ' form_date_input';


		$this->handle_common_params( $field_params, $field_name, $field_label );

		$r = $this->begin_field()
				.'<script type="text/javascript">
						//<![CDATA[
						var cal_'.$field_name.' = new CalendarPopup();
						cal_'.$field_name.'.showYearNavigation();
						cal_'.$field_name.'.showNavigationDropdowns();
						// cal_'.$field_name.'.showYearNavigationInput();
						// MonthNames get set through MONTH_NAMES
				   cal_'.$field_name.'.setDayHeaders( '
							."'".T_($weekday_letter[0])."',"
							."'".T_($weekday_letter[1])."',"
							."'".T_($weekday_letter[2])."',"
							."'".T_($weekday_letter[3])."',"
							."'".T_($weekday_letter[4])."',"
							."'".T_($weekday_letter[5])."',"
							."'".T_($weekday_letter[6])."' );\n"
				.' cal_'.$field_name.'.setWeekStartDay('.locale_startofweek().');
						cal_'.$field_name.".setTodayText('".TS_('Today')."');
						//]]>
					</script>\n"
				.$this->get_input_element($field_params, false)
				.'<a href="#" onclick="cal_'.$field_name.".select(document.getElementById('".$field_name."'), 'anchor_".$field_name."', '".$js_date_format."');"
				.' return false;" name="anchor_'.$field_name.'" id="anchor_'.$this->get_valid_id($field_name).'" title="'.T_('Select date').'">'
				.get_icon( 'calendar', 'imgtag', array( 'title'=>T_('Select date') ) ).'</a>';

		$r .= $this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Builds a date input field.
	 *
	 * @param string the name of the input field
	 * @param string initial value (ISO datetime)
	 * @param string label displayed in front of the field
	 * @param string date format (php format)
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function date( $field_name, $field_value, $field_label, $date_format = NULL )
	{
		$field_params = array( 'date_format' => $date_format, 'type' => 'text' );

		return $this->date_input( $field_name, $field_value, $field_label, $field_params );
	}


	/**
	 * Builds a time input field.
	 *
	 * @param string The name of the input field
	 * @param string Initial value (ISO datetime)
	 * @param string Label displayed in front of the field
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - 'time_format': Format of the time (string, default 'hh:mm:ss')
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function time_input( $field_name, $field_value, $field_label, $field_params = array() )
	{
		if( isset($field_params['time_format']) )
		{
			$field_format = '('.$field_params['time_format'].')';
			unset( $field_params['time_format'] ); // not an attribute
		}
		else
		{
			$field_format = '(hh:mm:ss)';
		}

		// Prepend format to note
		if( isset($field_params['note']) )
		{
			$field_params['note'] = $field_format.' '.$field_params['note'];
		}
		else
		{
			$field_params['note'] = $field_format;
		}

		$field_size = strlen($field_format);

		// Get time part of datetime:
		$field_value = substr( $field_value, 11, 8 );

		return $this->text_input( $field_name, $field_value, $field_size, $field_label, '', $field_params ); // TEMP: Note already in params
	}


	/**
	 * Builds a time input field.
	 *
	 * @param string the name of the input field
	 * @param string initial value (ISO datetime)
	 * @param string label displayed in front of the field
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function time( $field_name, $field_value, $field_label, $field_format = 'hh:mm:ss' )
	{
		$field_params = array( 'time_format' => $field_format );

		return $this->time_input( $field_name, $field_value, $field_label, $field_params );
	}


	/**
	 * Builds a time select input field
	 *
	 * @param string field name
	 * @param string initial value (ISO datetime or time only)
	 * @param string precison xmn or xsec (x:integer) for the options minutes or secondes
	 * @param string field label to be display before the field
	 * @param string note to be displayed after the field
	 * @param string CSS class for select
	 * @param string Javascript to add for onchange event (trailing ";").
	 */
	function time_select( $field_name, $field_value = NULL, $precision = '5mn', $field_label, $field_note = NULL, $field_class = NULL, $field_onchange = NULL )
	{
		preg_match( '#([0-9]+)(mn|s)#', $precision, $matches );

		if( !isset( $matches[1] ) && !isset( $matches[2] ) )
		{	// precison has a bad format
			return;
		}

		$field_params = array(
		'note' => $field_note,
		'class' => $field_class,
		'onchange' => $field_onchange );

		/***  instantiate the precison for the minutes and secondes select options  ****/

		if( $matches[2] == 'mn' )
		{
			$precision_mn = $matches[1];
			$precision_s = 0;
			// convert the precision in sec
			$precision *= 60;
		}
		else
		{
			$precision_mn = 1;
			$precision_s = $matches[1];
		}

		// Check if field value is only a time
		if( strlen( $field_value ) <= 8 )
		{	// Add date part:
			$field_value = '2000-01-01 '.$field_value;
		}

		/***  set round time with the precision  ***/
		// Get nb sec since unix...
		$nbsec = mysql2timestamp( $field_value );
		$modulo =  $nbsec % $precision;

		if( $modulo < ( $precision / 2 ) )
		{ // The round time is before
			$nbsec -= $modulo;
		}
		else
		{ // The round time is after
			$nbsec += $precision - $modulo;
		}

		/******************************************************/

		$this->handle_common_params( $field_params, $field_name, $field_label );

		$r = $this->begin_field();

		/**********   select options for the hours *************/

		$field_params['name'] = $field_name . '_h';
		$field_params['id'] = $field_params['name'];
		// Get Hour part of datetime:
		$hour = date( 'H', $nbsec );

		$r .= $this->_number_select(  $hour, 23 , 1, $field_params);

		/*********  select options for the minutes *************/

		$field_params['name'] = $field_name . '_mn';
		$field_params['id'] = $field_params['name'];
		// Get Minute part of datetime:
		$minute = date('i',$nbsec);

		$r .= ':'.$this->_number_select(  $minute, 59, $precision_mn, $field_params);

		if( $precision_s )
		{/*********  select options for the minutes  ***********/

			$field_params['name'] = $field_name . '_s';
			$field_params['id'] = $field_params['name'];
			// Get Secondes part of datetime:
			$seconde = substr( $field_value, 17, 2 );

			$r .=':'.$this->_number_select(  $seconde, 59, $precision_s, $field_params);
		}

		$r .= $this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Buil a select input field number
	 * @access private
	 *
	 * @param string 	field value of selected
	 * @param integer maximum value for the input select
	 * @param integer increment for the loop (precision)
	 * @param array params
	 */
	function _number_select( $field_value, $max, $precision = 1, $field_params )
	{
			$r	=	'<select'.get_field_attribs_as_string( $field_params ).'>';

			for( $i=0; $i <= $max ; $i += $precision)
			{
				$val = sprintf( '%02d', $i );
				$r .= '<option value="'.$val.'"'.
								($field_value == $val ? ' selected="selected"' : '') .
								'>'	.$val.'</option>';
			}

			$r .= '</select>';

			return $r;
	}


	/**
	 * Builds a duration input field.
	 *
	 * @todo @Francois: please check API and change as appropriate.
	 *
	 * @param string the name of the input field
	 * @param string initial value (seconds)
	 * @param string label displayed in front of the field
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - minutes_step ( default = 15 );
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function duration_input( $field_prefix, $duration, $field_label, $field_params = array() )
	{
		$this->handle_common_params( $field_params, $field_prefix, $field_label );

		$r = $this->begin_field();

		$days = floor( $duration / 86400 ); // 24 hours
		$r .= "\n".'<select name="'.$field_prefix.'_days" id="'.$this->get_valid_id($field_prefix).'_days">';
		$r .= '<option value="0"'.( 0 == $days ? ' selected="selected"' : '' ).">---</option>\n";
		for( $i = 1; $i <= 30; $i++ )
		{
			$r .= '<option value="'.$i.'"'.( $i == $days ? ' selected="selected"' : '' ).'>'.$i."</option>\n";
		}
		$r .= '</select>'.T_('days')."\n";

		$hours = floor( $duration / 3600 ) % 24;
		$r .= "\n".'<select name="'.$field_prefix.'_hours" id="'.$this->get_valid_id($field_prefix).'_hours">';
		$r .= '<option value="0"'.( 0 == $hours ? ' selected="selected"' : '' ).">---</option>\n";
		for( $i = 1; $i <= 23; $i++ )
		{
			$r .= '<option value="'.$i.'"'.( $i == $hours ? ' selected="selected"' : '' ).'>'.$i."</option>\n";
		}
		$r .= '</select>'.T_('hours')."\n";

		$minutes = floor( $duration / 60 ) % 60;
		$minutes_step = ( empty($field_params['minutes_step']) ? 15 : $field_params['minutes_step'] );
		$r .= "\n".'<select name="'.$field_prefix.'_minutes" id="'.$this->get_valid_id($field_prefix).'_minutes">';
		for( $i = 0; $i <= 59 ; $i += $minutes_step )
		{
			$r .= '<option value="'.$i.'"'.( ($minutes>=$i && $minutes<($i+$minutes_step)) ? ' selected="selected"' : '' ).'>'
						.($i == 0 ? '---' : substr('0'.$i,-2))."</option>\n";
		}
		$r .= '</select>'.T_('minutes')."\n";

		$r .= $this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Builds a duration input field.
	 *
	 * @param string the name of the input field
	 * @param string initial value (seconds)
	 * @param string label displayed in front of the field
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function duration( $field_prefix, $duration, $field_label )
	{
		return $this->duration_input( $field_prefix, $duration, $field_label );
	}


	/**
	 * Build a select to choose a weekday.
	 *
	 * @uses select_input_options()
	 *
	 * @return true|string
	 */
	function dayOfWeek_input( $field_name, $field_value, $field_label, $field_params = array() )
	{
		global $weekday_abbrev;

		$field_options = '';

		foreach( $weekday_abbrev as $lNumber => $lWeekday )
		{
			$field_options .= '<option';

			if( $field_value == $lNumber )
			{
				$field_options .= ' selected="selected"';
			}
			$field_options .= ' value="'.$lNumber.'">'.T_($lWeekday).'</option>';
		}

		return $this->select_input_options( $field_name, $field_options, $field_label, '', $field_params );
	}


	/**
	 * Build a select to choose a weekday.
	 *
	 * @return true|string
	 */
	function dayOfWeek( $field_name, $field_value, $field_label, $field_note = NULL, $field_class = NULL )
	{
		$field_params = array();
		if( isset($field_note) )
		{
			$field_params['note'] = $field_note;
		}

		if( isset($field_class) )
		{
			$field_params['class'] = $field_class;
		}

		return $this->dayOfWeek_input( $field_name, $field_value, $field_label, $field_params );
	}


	/**
	 * Builds a checkbox field
	 *
	 * @param string the name of the checkbox
	 * @param boolean indicating if the checkbox must be checked by default
	 * @param string label
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              'value': the value attribute of the checkbox (default 1)
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function checkbox_input( $field_name, $field_checked, $field_label, $field_params = array() )
	{
		$field_params['name'] = $field_name;
		$field_params['label'] = $field_label;
		$field_params['type'] = 'checkbox';

		if( !isset($field_params['value']) )
		{
			$field_params['value'] = 1;
		}

		if( $field_checked )
		{
			$field_params['checked'] = 'checked';
		}

		if( !isset($field_params['class']) )
		{
			$field_params['class'] = 'checkbox';
		}

		return $this->input_field( $field_params );
	}


	/**
	 * EXPERIMENTAL: simpler method of obtaining basic checkboxes
	 */
	function checkbox_basic_input( $field_name, $field_checked, $field_label, $field_params = array() )
	{
		$field_params['name'] = $field_name;
		$field_params['type'] = 'checkbox';

		if( !isset($field_params['value']) )
		{
			$field_params['value'] = 1;
		}

		if( $field_checked )
		{
			$field_params['checked'] = 'checked';
		}

		if( !isset($field_params['class']) )
		{
			$field_params['class'] = 'checkbox';
		}

		echo '<label>';
		echo $this->get_input_element($field_params);
		echo $field_label;
		echo '</label>';
	}


	/**
	 * Builds a checkbox field
	 *
	 * @param string the name of the checkbox
	 * @param boolean indicating if the checkbox must be checked
	 * @param string label
	 * @param string note
	 * @param string CSS class
	 * @param string value to use
	 * @param boolean an optional indicating whether the box is disabled or not
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function checkbox( $field_name, $field_checked, $field_label, $field_note = '',
											$field_class = '', $field_value = 1, $field_disabled = false )
	{
		$field_params = array();

		if( $field_note !== '' )
		{
			$field_params['note'] = $field_note;
		}
		if( $field_class !== '' )
		{
			$field_params['class'] = $field_class;
		}
		if( $field_value !== 1 )
		{
			$field_params['value'] = $field_value;
		}
		if( $field_disabled != false )
		{
			$field_params['disabled'] = 'disabled';
		}

		return $this->checkbox_input( $field_name, $field_checked, $field_label, $field_params );
	}


	/**
	 * Return links to check and uncheck all check boxes of the form
	 */
	function check_all()
	{
		// Need to add event click on links at the form end.
		$this->check_all = true;

		// fp> This is "name=" and I mean it!!! The JS is looking for all elements with this name!
		return '<a name="check_all_nocheckchanges" href="'.regenerate_url().'">'
				//.T_('Check all').' '
				.get_icon( 'check_all', 'imgtag', NULL, true )
				.'</a> | <a name="uncheck_all_nocheckchanges" href="'.regenerate_url().'">'
				//.T_('Uncheck all').' '
				.get_icon( 'uncheck_all', 'imgtag', NULL, true ).'</a> '.'&nbsp;';
	}


	/**
	 * Builds the form field
	 *
	 * @param string the class to use for the form tag
	 * @param string title to display on top of the form
	 * @param array Additional params to the form element. See {@link $_common_params}.
	 *              These may override class members.
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function begin_form( $form_class = NULL, $form_title = '', $form_params = array() )
	{
		global $use_strict;
		if( $use_strict ) unset( $form_params[ 'target' ] );// target isn't valid for XHTML Strict

		$this->handle_common_params( $form_params, NULL /* "name" attribute is deprecated in xhtml */ );

		if( ! empty($this->form_name) )
		{
			$form_params['id'] = $this->form_name;
		}

		// Set non-mandatory attributes if given in $form_params
		if( !isset($form_params['enctype']) && !empty( $this->enctype ) )
		{
			$form_params['enctype'] = $this->enctype;
		}

		if( !isset($form_params['class']) && !empty( $form_class ) )
		{
			$form_params['class'] = $form_class;
		}

		if( !isset($form_params['method']) )
		{
			$form_params['method'] = $this->form_method;
		}

		if( !isset($form_params['action']) )
		{
			$form_params['action'] = $this->form_action;
		}

		if( !empty($form_params['bozo_start_modified']) )
		{
			$bozo_start_modified = true;
			unset( $form_params['bozo_start_modified'] );
		}
		$r = "\n\n<form".get_field_attribs_as_string($form_params).">\n";

		// $r .= '<div>'; // for XHTML (dh> removed 'style="display:inline"' because it's buggy with FireFox 1.0.x, at least at the "Write" admin page; see http://forums.b2evolution.net/viewtopic.php?t=10130)
		// fp> inline was needed for inline forms like the DELETE confirmation.
		// fp> why does XHTML require all forms to have an embedded DIV?

		$r .= $this->formstart;

		if( empty($form_title) )
		{
			$r .= $this->replace_vars( $this->no_title_fmt );
		}
		else
		{
			$this->title = $form_title;

			$r .= $this->replace_vars( $this->title_fmt );
		}

		// Initialization of javascript vars used to create parent_child select lists
		// TODO: does this make sense to add it to every form??
		$r .= '<script type="text/javascript">
							var nb_dynamicSelects = 0;
							var tab_dynamicSelects = Array();
						</script>';

		global $UserSettings;
		if( isset($UserSettings) && $UserSettings->get( 'control_form_abortions' )
			&& preg_match( '#^(.*)_checkchanges#', $this->form_name ) )
		{ // This form will trigger the bozo validator, preset a localized bozo confirm message:

			$r .= '<script type="text/javascript">
					if( typeof bozo == "object" )
					{	// If Bozo validator is active:
						bozo.confirm_mess = \'';
			if( empty( $this->title ) )
			{ // No form title:
				$r .= TS_( 'You have modified this form but you haven\'t submitted it yet.\nYou are about to lose your edits.\nAre you sure?' );
			}
			else
			{ // with form title:
				$r .= sprintf( TS_( 'You have modified the form \"%s\"\nbut you haven\'t submitted it yet.\nYou are about to lose your edits.\nAre you sure?' ), $this->title );
			}

			$r .= '\';';

			if(	!empty($bozo_start_modified) )
			{
				$r .= '
					// Update number of changes for this form:
					bozo.tab_changes["'.$this->form_name.'"] = 1;
					// Update Total # of changes:
					bozo.nb_changes++;
				';
			}


			$r .='	}
				</script>';
		}

		return $this->display_or_return( $r );
	}


	/**
	 * Ends the form, optionally displays buttons and closes all open fieldsets.
	 *
	 * @param array Optional array to display the buttons before the end of the form, see {@link buttons_input()}
	 * @return true|string true (if output) or the generated HTML if not outputting.
	 */
	function end_form( $buttons = array() )
	{
		$r = '';
		if( !empty( $buttons ) )
		{
			$save_output = $this->output;
			$this->output = 0;

			$r .= $this->buttons( $buttons ); // converts old-style to new style, through convert_button_to_field_params()

			$this->output = $save_output;
		}

		while( $this->_opentags['fieldset']-- > 0 )
		{
			$r .= "\n</fieldset>\n";
		}

		$r .= $this->formend;


		// Display all buffered hidden fields in a 0 height DIV (for XHTML):
		$r .= '<div style="height:0">'.implode( '', $this->hiddens ).'</div>';

		// $r .= '</div>';
		$r .= "\n</form>\n\n";

		// When the page loads, Initialize all the parent child select lists + other javascripts
		$r .= '
			<script type="text/javascript">
				//<![CDATA[
				if( typeof addEvent == "function" && typeof init_dynamicSelect == "function" )
				{
					addEvent( window, "load", init_dynamicSelect, false );
					';
					if( $this->check_all )
					{ // Init check_all event on check_all links
						$r .= 'addEvent( window, "load", init_check_all, false );';
					}
					$r .= '
				}
				';

				if( $this->append_javascript )
				{ // Append Javascript that we have added
					$r .= implode( "\n", $this->append_javascript );
				}
				$r .= '
				//]]>
			</script>';

		// Reset (in case we re-use begin_form! NOTE: DO NOT REUSE begin_form, it's against the spec.)
		$this->hiddens = array();

		return $this->display_or_return( $r );
	}


	/**
	 * Builds a checkbox list
	 *
	 * the two-dimension array must indicate, for each checkbox:
	 *  - the name,
	 *  - the value,
	 *  - the comment to put between <input> and <br />
	 *  - a boolean indicating whether the box must be checked or not
	 *  - an optional boolean indicating whether the box is disabled or not
	 *  - an optional note
	 *  - 'required': is the box required to be checked (boolean; default: false)
	 *
	 * @todo Transform to $field_params schema.
	 * @param array a two-dimensional array containing the parameters of the input tag
	 * @param string name
	 * @param string label
	 * @param boolean true to surround checkboxes if they are required
	 * @param boolean true add a surround_check span, used by check_all mouseover
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function checklist( $options, $field_name, $field_label, $required = false, $add_highlight_spans = false )
	{
		$field_params = array();
		$field_params['type'] = 'checkbox';
		$this->handle_common_params( $field_params, $field_name, $field_label );

		$r = $this->begin_field( $field_name, $field_label );

		foreach( $options as $option )
		{ //loop to construct the list of 'input' tags

			$loop_field_name = $option[0];

			$loop_field_note = isset($option[5]) ? $option[5] : '';

			$r .= '<label class="">';

			if( $add_highlight_spans )
			{ // Need it to highlight checkbox for check_all and uncheck_all mouseover
				$r .= '<span name="surround_check" class="checkbox_surround_init">';
				$after_field_highlight = '</span>';
			}
			else
			{
				$after_field_highlight = '';
			}

			$after_field = '';
			if( param_has_error( $field_name ) )
			{ // There is an error message for this field, we want to mark the checkboxes with a red border:
				$r .= '<span class="checkbox_error">';
				$after_field .= '</span>';
			}
			if( $required )
			{	//this field is required
				$r .= '<span class="checkbox_required">';
				$after_field .= '</span>';
			}

			$r .= "\t".'<input type="checkbox" name="'.$loop_field_name.'" value="'.$option[1].'" ';
			if( $option[3] )
			{ //the checkbox has to be checked by default
				$r .= ' checked="checked" ';
			}
			if( isset( $option[4] ) && $option[4] )
			{ // the checkbox has to be disabled
				$r .= ' disabled="disabled" ';
			}
			$r .= ' class="checkbox" />';

			$r .= $after_field;

			$r .= $after_field_highlight;

			$r .= ' '.$option[2];

			$r .='</label>';

			if( !empty($loop_field_note) )
			{ // We want to display a note:
				$r .= ' <span class="notes">'.$loop_field_note.'</span>';
			}
			$r .= "<br />\n";
		}

		$r .= $this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Display a select field and populate it with a callback function.
	 *
	 * @param string field name
	 * @param string default field value
	 * @param callback callback function
	 * @param string field label to be display before the field
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              Nothing yet.
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select_input( $field_name, $field_value, $field_list_callback, $field_label, $field_params = array() )
	{
		$field_options = call_user_func( $field_list_callback, $field_value );

		return $this->select_input_options( $field_name, $field_options, $field_label, '', $field_params );
	}


	/**
	 * Display a select field and populate it with a callback function.
	 *
	 * @param string field name
	 * @param string default field value
	 * @param callback callback function
	 * @param string field label to be display before the field
	 * @param string note to be displayed after the field
	 * @param string CSS class for select
	 * @param string Javascript to add for onchange event (trailing ";").
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select(
		$field_name,
		$field_value,
		$field_list_callback,
		$field_label,
		$field_note = '',
		$field_class = '',
		$field_onchange = NULL )
	{
		$field_params = array();
		if( $field_note !== '' )
		{
			$field_params['note'] = $field_note;
		}
		if( $field_class !== '' )
		{
			$field_params['class'] = $field_class;
		}
		if( isset($field_onchange) )
		{
			$field_params['onchange'] = $field_onchange;
		}

		return $this->select_input( $field_name, $field_value, $field_list_callback, $field_label, $field_params );
	}


	/**
	 * Display a select field and populate it with a cache object by using a callback
	 * method.
	 *
	 * @uses select_input_options()
	 * @param string Field name
	 * @param string Default field value
	 * @param DataObjectCache Cache containing values for list
	 * @param string Field label to be display with the field
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - 'allow_none': allow to select [none] in list (boolean, default false)
	 *              - 'object_callback': Object's callback method name (string, default 'get_option_list')
	 *              - 'loop_object_method': The method on the objects inside the callback (string, default NULL)
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select_input_object( $field_name, $field_value, & $field_object, $field_label, $field_params = array() )
	{
		if( isset($field_params['allow_none']) )
		{
			$allow_none = $field_params['allow_none'];
			unset( $field_params['allow_none'] );
		}
		else
		{
			$allow_none = false;
		}

		if( isset($field_params['object_callback']) )
		{
			$field_object_callback = $field_params['object_callback'];
			unset( $field_params['object_callback'] );
		}
		else
		{
			$field_object_callback = 'get_option_list';
		}

		if( isset($field_params['loop_object_method']) )
		{
			$field_options = $field_object->$field_object_callback( $field_value, $allow_none, $field_params['loop_object_method'] );
		}
		else
		{
			$field_options = $field_object->$field_object_callback( $field_value, $allow_none );
		}

		if( isset($field_params['note']) )
		{
			$field_note = $field_params['note'];
			unset( $field_params['note'] );
		}
		else
		{
			$field_note = '';
		}

		return $this->select_input_options( $field_name, $field_options, $field_label, $field_note, $field_params );
	}


	/**
	 * Display a select field and populate it with a cache object.
	 *
	 * @uses select_input_object()
	 * @param string field name
	 * @param string default field value
	 * @param DataObjectCache Cache containing values for list
	 * @param string field label to be display before the field
	 * @param string note to be displayed after the field
	 * @param boolean allow to select [none] in list
	 * @param string CSS class for select
	 * @param string Object's callback method name.
	 * @param string Javascript to add for onchange event (trailing ";").
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select_object(
		$field_name,
		$field_value,
		& $field_object,
		$field_label,
		$field_note = '',
		$allow_none = false,
		$field_class = '',
		$field_object_callback = 'get_option_list',
		$field_onchange = NULL )
	{
		$field_params = array(
			'note' => $field_note,
			'allow_none' => $allow_none,
			'class' => $field_class,
			'object_callback' => $field_object_callback,
			'onchange' => $field_onchange );

		return $this->select_input_object( $field_name, $field_value, $field_object, $field_label, $field_params  );
	}


	/**
	 * Display a select field and populate it with a cache object.
	 *
	 * @param string field name
	 * @param string string containing options '<option>...</option>'
	 * @param string field label to be display before the field
	 * @param string "help" note (Should provide something useful, otherwise leave it empty)
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - 'label': Field label to be display before the field
	 *              - 'class': CSS class for select
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select_input_options( $field_name, $field_options, $field_label, $field_note = '', $field_params = array() )
	{
		$this->handle_common_params( $field_params, $field_name, $field_label );

		$r = $this->begin_field();
		if( !empty( $field_params['parent'] ) )
		{// need to display an arrow to show that this select list options has a preselection from a parent
			$r .= get_icon( 'parent_childto_arrow' );
		}

		$r .="\n<select".get_field_attribs_as_string($field_params).'>'
			 .$field_options
			 ."</select>\n";

		$r .= $this->end_field( $field_note );

		if( !empty( $field_params['parent'] ) )
		{ // Set up the dynamic preselection array from the parent to this select list options
			$r .= "<script type='text/javascript'>
								tab_dynamicSelects[nb_dynamicSelects] = Array();
								tab_dynamicSelects[nb_dynamicSelects]['parent'] = '".$field_params['parent']."';
								tab_dynamicSelects[nb_dynamicSelects]['child'] = '$field_name';
								nb_dynamicSelects++;
							</script>";
		}

		return $this->display_or_return( $r );
	}


	/**
	 * Display a select field and populate it with a cache object.
	 *
	 * @uses select_input_options()
	 * @param string field name
	 * @param string string containing options
	 * @param string field label to be display before the field
	 * @param string note to be displayed after the field
	 * @param string CSS class for select
	 * @param string Javascript to add for onchange event (trailing ";").
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select_options(
		$field_name,
		$field_options,
		$field_label,
		$field_note = NULL,
		$field_class = NULL,
		$field_onchange = NULL )
	{
		$field_params = array(
			'note' => $field_note,
			'class' => $field_class,
			'onchange' => $field_onchange,
			 );

		return $this->select_input_options( $field_name, $field_options, $field_label, '', $field_params );
	}


	/**
	 * This is a stub for {@link select_input_options()} which builds the required list
	 * of <option> elements from a given list of options ($field_options) and
	 * the selected value ($field_value).
	 *
	 * @uses select_input_options()
	 * @param string field name
	 * @param mixed Initial value
	 * @param array Options. If an associative key (string) is used, this gets the value attribute.
	 *              NOTE: numeric strings get converted to integers by PHP!
	 * @param string Field label to be display before the field
	 * @param string Note
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - 'value': The selected value
	 *              - 'force_keys_as_values': Use the key of $field_options for "value" attrib always.
	 *              - Plus all of {@link select_input_options()}.
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function select_input_array( $field_name, $field_value, $field_options, $field_label, $field_note = NULL, $field_params = array() )
	{
		if( isset($field_params['force_keys_as_values']) )
		{
			$force_keys_as_values = $field_params['force_keys_as_values'];
			unset($field_params['force_keys_as_values']); // not an attribute to <select>
		}
		else
		{
			$force_keys_as_values = false;
		}

		// Build $options_list
		$options_list = '';

		foreach( $field_options as $l_key => $l_option )
		{
			// Get the value attribute from key if is_string():
			$l_value = ($force_keys_as_values || is_string($l_key)) ? $l_key : $l_option;

			$options_list .= '<option value="'.format_to_output($l_value, 'formvalue').'"';

			if(
					( is_array( $field_value ) && in_array( $l_value, $field_value ) ) ||
					( !is_array( $field_value ) && (string)$l_value == (string)$field_value ) // cast to string so "1,2" is != 1
				)
			{
				$options_list .= ' selected="selected"';
			}

			$options_list .= '>'.format_to_output($l_option).'</option>';
		}

		return $this->select_input_options( $field_name, $options_list, $field_label, $field_note, $field_params );
	}


	/**
	 * Combo box
	 * Display a select options list with an option 'new',
	 * and when this one is seleted, display a combo input text to add a new value
	 *
	 * @param string field name
	 * @param string field value
	 * @param string containing options
	 * @param string field label
	 * @param array Optional params
	 *
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function combo_box( $field_name, $field_value, $field_options, $field_label, $field_params = array() )
	{
		if( param_has_error( $field_name) )
		{	// There is an error on the combo, so we need to set the combo input text class to 'field_error'
			$input_class = 'field_error';
		}
		else
		{
			if( isset( $field_params['required'] ) && $field_params['required'] )
			{	// The field is required, so update its class:
				$input_class = ' field_required';
			}
			else
			{
				$input_class = '';
			}
		}
		unset($field_params['required']); // already handled above, do not pass to handle_common_params()

		// Set onchange event on the select, when the select changes, we check the value to display or hide an input text after it
		$field_params['onchange']= 'check_combo( this.id, this.options[this.selectedIndex].value, "'.$input_class.'")';

		$this->handle_common_params( $field_params, $field_name, $field_label );

		$r = $this->begin_field();

		// Select option to add after the select list a combo input text:
		$option_new  = '<option value="new">'.T_('New').': </option>'."\n";

		// Add the new option to the select list:
		$field_options = $option_new . $field_options;

		// Select list
		$r .="\n<select".get_field_attribs_as_string($field_params).'>'
			 .$field_options
			 ."</select>\n";

		if( $field_options == $option_new  || $input_class == 'field_error' || !$field_value )
		{	// The list is empty or there is an error on the combo or no field value, so we have to display the input text:
			$visible = 'inline';
		}
		else
		{ // Hide the input text:
			$visible = 'none' ;
		}

		$r .= '<input type="text" id="'.$field_name.'_combo" name="'.$field_name.'_combo" size="30" class="'.$input_class.'" style="display:'.$visible.'">';

		if( $visible == 'none' )
		{ // The input text is hidden, so if no javascript activated, we always display input text:
			$r .= '<script type="text/javascript"></script>'; // We need <script> tag here to use a <noscript> tag when javascript is deactivated:
			$r .= '<noscript>
							<input type="text" id="'.$field_name.'_combo" name="'.$field_name.'_combo" size="30" class="'.$input_class.'">
						</noscript>';
		}

		$r .= $this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Build a text area.
	 *
	 * @param string Name of the field
	 * @param string Value of the field
	 * @param integer Number of rows
	 * @param string Label for the field
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - 'cols': Number of columns (integer, default 50)
	 */
	function textarea_input( $field_name, $field_value, $field_rows, $field_label, $field_params = array() )
	{
		global $rsc_url;

		if( !isset($field_params['cols']) )
		{
			$field_params['cols'] = 50;
		}

		if( !isset($field_params['note_format']) )
		{ // Default note_format for <textarea>:
			$field_params['note_format'] = '<br/><span class="notes">%s</span>';
		}

		$this->handle_common_params( $field_params, $field_name, $field_label );

		// Give it a class, so it can be selected for CSS in IE6
		if( empty($field_params['class']) ) $field_params['class'] = 'form_textarea_input';
		else $field_params['class'] .= ' form_textarea_input';

		if( isset($field_params['maxlength']) )
		{ // attach event to the textarea to accomplish max length:
			$this->append_javascript['textarea_maxlength'.$field_name] = '
				if( typeof jQuery == "function" )
				{
				$("#'.$field_params['id'].'").bind( "keyup", function(event)
					{
						if( this.value.length > '.$field_params['maxlength'].' )
						{
							this.value = this.value.substr(0,'.$field_params['maxlength'].');
							event.preventDefault();
						}
					} );
				}';
			unset($field_params['maxlength']); // not a HTML attribute for textarea
		}

		$r = $this->begin_field()
			// NOTE: The following pixel is needed to avoid the dity IE textarea expansion bug
			// see http://fplanque.net/2003/Articles/iecsstextarea/index.html
			.'<img src="'.$rsc_url.'img/blank.gif" width="1" height="1" alt="" />'
			.'<textarea'
			.get_field_attribs_as_string( $field_params )
			.' rows="'.$field_rows.'">'
			.format_to_output( $field_value, 'formvalue' )
			.'</textarea>'
			// NOTE: this one is for compensating the previous pixel in case of center aligns.
			.'<img src="'.$rsc_url.'img/blank.gif" width="1" height="1" alt="" />'
			.$this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Build a text area.
	 *
	 * @uses textarea_input()
	 *
	 * @param string
	 * @param string
	 * @param integer
	 * @param string
	 * @param string
	 * @param integer
	 * @param string
	 */
	function textarea( $field_name, $field_value, $field_rows, $field_label,
												$field_note = '', $field_cols = 50 , $field_class = '' )
	{
		$field_params = array(
			'note' => $field_note,
			'cols' => $field_cols,
			'class' => $field_class );

		return $this->textarea_input( $field_name, $field_value, $field_rows, $field_label, $field_params );
	}


	/**
	 * Builds an info field.
	 * An info field is a fieldset containing a label div and an info div.
	 *
	 * {@internal
	 * NOTE: we don't use {@link begin_field()} here, because the label is meant
	 * to be always on the left and this avoids fiddling with the <label> tag.
	 * }}
	 *
	 * @param string the field label
	 * @param string the field info
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - 'format_info': Format of info content, see {@link format_to_output()} (string, default 'htmlbody')
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function info_field( $field_label, $field_info, $field_params = array() )
	{
		if( isset($field_params['format_info']) )
		{
			$format_info = $field_params['format_info'];
			unset($field_params['format_info']); // not an HTML element
		}
		else
		{
			$format_info = 'htmlbody';
		}

		if( !isset($field_params['note_format']) )
		{ // Default field_note for info:
			$field_params['note_format'] = ' <small class="notes">%s</small>';
		}

		$this->handle_common_params( $field_params, NULL, $field_label );

		$r = $this->fieldstart;

		// Start the new form field and inject an automatic DOM id
		// This is useful to show/hide the whole field by JS.
		if( !empty(	$this->_common_params['id'] ) )
		{
			$ffield_id = ' id="ffield_'.$this->_common_params['id'].'" ';
		}
		else
		{	// No ID in case there's no id/name given for a field.
			$ffield_id = '';
		}
		$r = str_replace( '$ID$', $ffield_id, $this->fieldstart );

		if( strlen($field_label) )
		{
			$r .= $this->labelstart.$field_label;
			$r .= $this->label_suffix;
			$r .= $this->labelend;
		}
		else
		{ // Empty label:
			$r .= $this->labelempty;
		}

		$r .= $this->infostart;

		// PAYLOAD:
		$r .= format_to_output( $field_info, $format_info );


		// Taken from end_field() - but we use $infoend:
		if( !empty($this->_common_params['note']) )
		{ // We have a note
			$r .= sprintf( $this->_common_params['note_format'], $this->_common_params['note'] );
		}

		if( isset($this->_common_params['field_suffix']) )
		{
			$r .= $this->_common_params['field_suffix'];
		}

		$r .= ( isset($this->infoend) ? $this->infoend : $this->inputend ).$this->fieldend;

		return $this->display_or_return( $r );
	}


	/**
	 * Builds an info field.
	 * An info field is a fieldset containing a label div and an info div.
	 *
	 * @param string the field label
	 * @param string the field info
	 * @param string see {@link format_to_output()}
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function info( $field_label, $field_info, $field_note = NULL, $format = 'htmlbody' )
	{
		$field_params = array(
			'note' => $field_note,
			'format_info' => $format );

		return $this->info_field( $field_label, $field_info, $field_params );
	}


	/**
	 * Builds a button list.
	 *
	 * The array contains an associative array for each button (params to {@link button_input()}.
	 *
	 * @param array a two-dimension array containing the elements of the input tags
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function buttons_input( $buttons = array() )
	{
		$r = '';
		$hidden = true; // boolean that tests if the buttons are all hidden

		$save_output = $this->output;
		$this->output = false;

		foreach( $buttons as $l_button )
		{
			if( !isset($l_button['type']) || $l_button['type'] != 'hidden' )
			{ // not a hidden button
				$hidden = false;
			}

			$r .= $this->button_input( $l_button );
		}
		/*
		else
		{ // Default: Save and Reset
			$r .= $this->get_input_element( array(
				'type' => 'submit',
				'value' => T_('Save !'),
				'class' => 'SaveButton',
				'input_prefix => "\t\t\t" );
			$r .= $this->get_input_element( array(
				'type' => 'reset',
				'value' => T_('Reset'),
				'class' => 'ResetButton',
				'input_prefix => "\t\t\t" );
		}*/

		$this->output = $save_output;

		if( ! $hidden )
		{ // there are not only hidden buttons : additional tags
			$r = $this->buttonsstart.$r.$this->buttonsend;
		}

		return $this->display_or_return( $r );
	}


	/**
	 * Builds a button list.
	 *
	 * Array entries with numeric (deprecated) keys are converted to their equivalent string indexes.
	 *
	 * the two-dimension array must contain :
	 *  - the button type
	 *  - the name (optional)
	 *  - the value (optional)
	 *  - the class (optional)
	 *  - the onclick attribute (optional)
	 *  - the style (optional)
	 *
	 * @param array a two-dimension array containing the elements of the input tags
	 * @param boolean to select or not the default display
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function buttons( $buttons = array() )
	{
		$buttons_list = array();

		foreach( $buttons as $l_button )
		{
			$buttons_list[] = $this->convert_button_to_field_params( $l_button );
		}

		return $this->buttons_input( $buttons_list );
	}


	/**
	 * Builds a button.
	 *
	 * Array entries with numeric (deprecated) keys are converted to their equivalent string indexes.
	 *
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - type: The type attribute (string, default 'submit')
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function button_input( $field_params = array() )
	{
		if( empty($field_params['type']) )
		{ // default type
			$field_params['type'] = 'submit';
		}

		if( !isset($field_params['input_prefix']) )
		{ // default prefix
			$field_params['input_prefix'] = "\t\t\t";
		}

		return $this->display_or_return( $this->get_input_element( $field_params ) );
	}


	/**
	 * Builds a button
	 *
	 * the array must contain :
	 *  - the button type
	 *  - the name (optional)
	 *  - the value (optional)
	 *  - the class (optional)
	 *  - the onclick attribute (optional)
	 *  - the style (optional)
	 *
	 * @param array a two-dimension array containing the elements of the input tags
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function button( $options )
	{
		$field_params = $this->convert_button_to_field_params( $options );

		if( empty($field_params['type']) )
		{
			$field_params['type'] = 'submit'; // default type
		}

		return $this->button_input( $field_params );
	}


	/**
	 * Convert a deprecated, numeric button array to a field_params array.
	 *
	 * @deprecated
	 * @param array A button array like button() and buttons() are getting.
	 * @return array The button array converted to a string indexed button array (field_params).
	 */
	function convert_button_to_field_params( $options )
	{
		$field_params = array();

		foreach( array_keys($options) as $l_key )
		{
			if( is_int($l_key) )
			{
				switch( $l_key )
				{
					case 0: $field_params['type'] = $options[0]; break;
					case 1: $field_params['name'] = $options[1]; break;
					case 2: $field_params['value'] = $options[2]; break;
					case 3: $field_params['class'] = $options[3]; break;
					case 4: $field_params['onclick'] = $options[4]; break;
					case 5: $field_params['style'] = $options[5]; break;
				}
			}
			else
			{
				$field_params[$l_key] = $options[$l_key];
			}
		}

		return $field_params;
	}


	/**
	 * Builds an hidden input tag, overwriting any previous hidden values (except for "foo[]").
	 *
	 * @param string Field name
	 * @param string Field value
	 * @param array Optional params. This is e.g. useful for "id".
	 *              See {@link $_common_params}.
	 */
	function hidden( $field_name, $field_value, $field_params = array() )
	{
		if( is_array( $field_value ) )
		{ // this happens for example when we've POSTed an array (for PHP it's an array then)
			foreach( $field_value as $l_key => $l_value )
			{
				// Recursion:
				$this->hidden( $field_name.'['.$l_key.']', $l_value, $field_params );
			}
		}
		else
		{
			$field_params['name'] = $field_name;
			$field_params['type'] = 'hidden';
			$field_params['value'] = $field_value;

			if( strpos($field_name, '[]') )
			{ // array-style name or we don't want to overwrite, just add it:
				$this->hiddens[] = $this->get_input_element( $field_params );
			}
			else
			{
				if( isset($this->existing_hiddens[$field_name]) )
				{
					unset($this->hiddens[$this->existing_hiddens[$field_name]]);
				}

				// add the field and remember that it already exists:
				end($this->hiddens);
				$key = key($this->hiddens)+1;
				$this->hiddens[$key] = $this->get_input_element( $field_params );
				$this->existing_hiddens[$field_name] = $key;
			}
		}
	}


	/**
	 * Add the "ctrl" param, used in the backoffice, as a hidden field.
	 */
	function hidden_ctrl()
	{
		global $ctrl;
		if( !empty( $ctrl) )
		{
			$this->hidden( 'ctrl', $ctrl );
		}
	}


	/**
	 * Builds a list of hidden inputs.
	 *
	 * @param array Array of parameters to {@link hidden()}:
	 *               - 0: field_name
	 *               - 1: field_value
	 *               - 2: field_params
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function hiddens( $hiddens )
	{
		$save_output = $this->output;
		$this->output = false;
		foreach( $hiddens as $hidden )
		{
			$this->hidden( $hidden[0], $hidden[1], isset($hidden[2]) ? $hidden[2] : array() );
		}
		$this->output = $save_output;
	}


	/**
	 * Builds a list of hidden inputs from an array where the keys are the field names.
	 *
	 * It supports array values (one-dimensional) and generates appropriate key-value pairs.
	 *
	 * @uses Form::hidden()
	 * @param array associative array ( name => value ) of hidden fields.
	 * @param array|NULL A list of keys to ignore.
	 */
	function hiddens_by_key( $hiddens, $exclude = NULL )
	{
		if( $this->output )
		{ // only save output once, if necessary (recursion!)
			$save_output = $this->output;
			$this->output = false;
		}
		foreach( $hiddens as $l_name => $l_value )
		{
			if( isset($exclude) && in_array( $l_name, $exclude ) )
			{
				continue;
			}
			if( is_array( $l_value ) )
			{ // this happens for example when we've POSTed an array (for PHP it's an array then)
				foreach( $l_value as $ll_key => $ll_value )
				{
					// Recursion:
					$this->hiddens_by_key( array( $l_name.'['.$ll_key.']' => $ll_value ), $exclude );
				}
			}
			else
			{
				$this->hidden( $l_name, $l_value );
			}
		}

		if( isset($save_output) )
		{
			$this->output = $save_output;
		}
	}


	/**
	 * Builds a submit input tag
	 *
	 * the array must contain :
	 *  - the name (optional)
	 *  - the value (optional)
	 *  - the class (optional)
	 *  - the onclick attribute (optional)
	 *  - the style (optional)
	 *
	 * @todo Use <div class="input"> for layout == 'fieldset' (property).
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              Nothing yet.
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function submit_input( $field_params = array() )
	{
		$field_params['type'] = 'submit';

		return $this->button_input( $field_params );
	}


	/**
	 * Builds a submit input tag
	 *
	 * the array must contain :
	 *  - the name (optional)
	 *  - the value (optional)
	 *  - the class (optional)
	 *  - the onclick attribute (optional)
	 *  - the style (optional)
	 *
	 * @param array an array containing the elements of the input tags
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function submit( $options )
	{
		array_unshift( $options, 'submit' );

		return $this->button( $options );
	}


	/**
	 * Generate set of radio options.
	 *
	 * @param string The name of the radio options
	 * @param string The checked option's value
	 * @param array of arrays The radio options
	 *        Keys:
	 *         - 'value' (required)
	 *         - 'label' (required)
	 *         - 'note'
	 *         - 'type' (default: "radio")
	 *         - 'class' (default: "radio")
	 *         - 'checked' (default: 'value' gets compared to $field_value)
	 *         - 'name' (default: $field_name)
	 *         - 'suffix' (gets used after the radio's label)
	 *         - Plus everything for {@link get_input_element()} )
	 * @param string Label
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - lines: Options on seperate lines (DIVs) (boolean, default false)
	 *              NOTE: these params/attribs get used as default for every INPUT field,
	 *                    overridden by $field_options
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function radio_input( $field_name, $field_value, $field_options, $field_label, $field_params = array() )
	{
		if( isset($field_params['lines']) )
		{
			$field_lines = $field_params['lines'];
			unset($field_params['lines']); // no HTML attribute
		}
		else
		{
			$field_lines = false;
		}

		if( !isset($field_params['note_format']) )
		{ // Default field_note for radios:
			$field_params['note_format'] = '<span class="notes">%s</span>';
			if( $field_lines )
			{
				$field_params['note_format'] = '<div>'.$field_params['note_format'].'</div>';
			}
		}

		$field_params['id'] = false; // No ID attribute for the label
		$this->handle_common_params( $field_params, $field_name, $field_label );
		unset($field_params['id']);  // unset, so it gets handled correctly as default below

		$r = $this->begin_field();

		/*
		 * Build options list:
		 */
		$count_options = 0; // used for unique IDs (label/radio)
		foreach( $field_options as $loop_radio )
		{
			// Merge defaults from $field_params:
			$loop_radio = array_merge( $field_params, $loop_radio );

			if( $field_lines ) $r .= "<div>\n";

			// Defaults:
			if( ! isset($loop_radio['type']) )  $loop_radio['type'] = 'radio';
			if( ! isset($loop_radio['class']) ) $loop_radio['class'] = 'radio';
			if( ! isset($loop_radio['name']) )  $loop_radio['name'] = $field_name;
			if( ! isset($loop_radio['id']) )
			{ // build unique id:
				$loop_radio['id'] = $this->get_valid_id($field_params['name'].'_radio_'.(++$count_options));
			}

			if( isset($loop_radio['checked']) )
			{ // convert boolean:
				if( $loop_radio['checked'] ) $loop_radio['checked'] = 'checked';
			}
			elseif( $field_value == $loop_radio['value'] )
			{ // Current selection:
				$loop_radio['checked'] = 'checked';
			}

			// Unset non-HTML attribs:
			$label = $loop_radio['label'];
			$note = isset($loop_radio['note']) ? $loop_radio['note'] : null;
			$suffix = isset($loop_radio['suffix']) ? $loop_radio['suffix'] : '';
			unset($loop_radio['label'], $loop_radio['note'], $loop_radio['suffix']);

			// the radio element:
			$r .= $this->get_input_element( $loop_radio, false );

			// the label:
			$r .= '<label class="radiooption" for="'.$loop_radio['id'].'">'.$label.'</label>';

			if( ! empty($note) )
			{ // Add a note for the current radio option:
				$r .= '<span class="notes">'.$note.'</span>';
			}

			// optional text for radio option (like additional fieldsets or input boxes)
			$r .= $suffix;

			// Split radio options by whitespace:
			$r .= "\n";

			if( $field_lines ) $r .= "</div>\n";
		}

		$r .= $this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Generate set of radio options.
	 *
	 * @param string the name of the radio options
	 * @param string the checked option
	 * @param array of arrays the radio options (0: value, 1: label, 2: notes, 3: additional HTML [input field, ..], 4: attribs for <input tag> )
	 * @param string label
	 * @param boolean options on seperate lines (DIVs)
	 * @param string notes
	 * @return mixed true (if output) or the generated HTML if not outputting
	 */
	function radio( $field_name, $field_value, $field_options, $field_label, $field_lines = false, $field_note = '' )
	{
		$new_field_options = array();

		foreach( $field_options as $l_key => $l_options )
		{
			$new_field_options[$l_key] = array(
				'value' => $l_options[0],
				'label' => $l_options[1] );

			if( isset($l_options[2]) )
			{
				$new_field_options[$l_key]['note'] = $l_options[2];
			}
			if( isset($l_options[4]) )
			{ // Convert "inline attribs" to "params" array
				preg_match_all( '#(\w+)=[\'"](.*)[\'"]#', $l_options[4], $matches, PREG_SET_ORDER );

				foreach( $matches as $l_set_nr => $l_match )
				{
					$new_field_options[$l_key][$l_match[1]] = $l_match[2];
				}
			}

			if( isset($l_options[3]) )
			{
				$new_field_options[$l_key]['suffix'] = $l_options[3];
			}
		}

		$field_params = array( 'lines' => $field_lines, 'note' => $field_note );

		return $this->radio_input( $field_name, $field_value, $new_field_options, $field_label, $field_params );
	}


	/**
	 * Generate a general input field.
	 *
	 * This is the base function for text_input(), checkbox_input(), ..
	 *
	 * @uses get_input_element() to generate the <input> element
	 *
	 * @param array Optional params. Additionally to {@link $_common_params} you can use:
	 *              - see {@link get_input_element()}
	 * @return true|string true (if output) or the generated HTML if not outputting
	 */
	function input_field( $field_params = array() )
	{
		$element = $this->get_input_element($field_params);

		$r = $this->begin_field()
				.$element
				.$this->end_field();

		return $this->display_or_return( $r );
	}


	/**
	 * Generate a general input element.
	 *
	 * @param array Optional params.
	 *    Additionally to {@link $_common_params} you can use:
	 *    - input_prefix: Text before <input /> (string, default '')
	 *    - input_suffix: Text after <input /> (string, default "\n")
	 *    - input_help: Gets used as default value on empty input (type=text)
	 *      elements. It gets attached through JavaScript (onfocus, onblur and form.onsubmit).
	 *
	 * @return string The <input /> element.
	 */
	function get_input_element( $field_params = array(), $parse_common = true )
	{
		if( $parse_common )
		{
			$this->handle_common_params( $field_params );
		}

		if( isset($field_params['input_prefix']) )
		{
			$input_prefix = $field_params['input_prefix'];
			unset($field_params['input_prefix']); // no HTML attribute
		}
		else
		{
			$input_prefix = '';
		}

		if( isset($field_params['input_suffix']) )
		{
			$input_suffix = $field_params['input_suffix'];
			unset($field_params['input_suffix']); // no HTML attribute
		}
		else
		{
			$input_suffix = "\n";
		}

		if( isset($field_params['input_help']) && ( empty($field_params['type']) || $field_params['type'] == 'text' ) )
		{
			$this->append_javascript[] = 'input_decorated_help( "'.$field_params['id'].'", "'.format_to_output($field_params['input_help'], 'formvalue').'" );';

			unset($field_params['input_help']); // no HTML attribute
		}

		$r = $input_prefix
			.'<input'.get_field_attribs_as_string( $field_params ).' />'
			.$input_suffix;

		return $r;
	}


	/**
	 * Convert a given string (e.g. fieldname) to a valid HTML id.
	 *
	 * @static
	 * @return string
	 */
	function get_valid_id( $id )
	{
		static $id_count = 0;
		if( substr( $id, -2 ) == '[]' )
		{
			$id = substr( $id, 0, -2 ).'_A'.(++$id_count);
		}
		return str_replace( array( '[', ']' ), '_', $id );
	}


	/**
	 * Get the label of a field. This is used by {@link begin_field()} or {@link end_field()},
	 *
	 * @access protected
	 * @return string
	 */
	function get_label()
	{
		$r = '';

		$label = $this->_common_params['label'];

		if( strlen($label) )
		{
			$r .= $this->labelstart
				.'<label'
				.( !empty($this->_common_params['id'])
					? ' for="'.format_to_output( $this->_common_params['id'], 'htmlattr' ).'"'
					: '' )
				.'>'
				.format_to_output($label, 'htmlbody');

			$r .= $this->label_suffix;

			$r .= '</label>'
				.$this->labelend;
		}
		else
		{ // Empty label:
			$r .= $this->labelempty;
		}

		return $r;
	}


	/**
	 * Extract common params out of $field_params into {@link $_common_params} and unsets them in $field_params.
	 *
	 * Also handles adding errors to the note.
	 *
	 * @access protected
	 * @param array An array passed to a field generating function like {@link text_input()}. By reference!
	 * @param string|NULL The name of the field. If not empty it gets used to build the id attribute.
	 */
	function handle_common_params( & $field_params, $field_name = NULL, $field_label = NULL )
	{
		#pre_dump( 'handle_common_params (before)', $field_params );

		$this->_common_params = array(); // Reset

		// Copy optional variables, if given:
		if( isset($field_name) )
		{
			$field_params['name'] = $field_name;
		}
		if( isset($field_label) )
		{
			$field_params['label'] = $field_label;
		}

		if( isset($field_params['note']) )
		{
			$this->_common_params['note'] = $field_params['note'];
			unset($field_params['note']); // no HTML attribute
		}
		else
		{
			$this->_common_params['note'] = NULL;
		}

		if( isset($field_params['note_format']) )
		{
			$this->_common_params['note_format'] = $field_params['note_format'];
			unset($field_params['note_format']); // no HTML attribute
		}
		else
		{
			$this->_common_params['note_format'] = $this->note_format;
		}

		if( isset($field_params['label']) )
		{
			$this->_common_params['label'] = $field_params['label'];
			unset($field_params['label']); // no HTML attribute
		}
		else
		{
			$this->_common_params['label'] = '';
		}

		if( isset($field_params['field_prefix']) )
		{
			$this->_common_params['field_prefix'] = $field_params['field_prefix'];
			unset( $field_params['field_prefix'] );
		}

		if( isset($field_params['field_suffix']) )
		{
			$this->_common_params['field_suffix'] = $field_params['field_suffix'];
			unset( $field_params['field_suffix'] );
		}

		if( isset($field_params['required']) )
		{
			$this->_common_params['required'] = $field_params['required'];
			unset($field_params['required']);
		}


		if( !empty($field_params['name']) )
		{
			if( !isset($field_params['id']) )
			{ // Autogenerate id attrib (not for hidden, radio and submit types)
				if( empty($field_params['type'])
						|| ( $field_params['type'] != 'hidden'
									&& $field_params['type'] != 'radio'
									&& $field_params['type'] != 'submit'
									) )
				{ // Save ID with field_params and _common_params (for get_label())
					$field_params['id'] = $this->_common_params['id'] = $this->get_valid_id($field_params['name']);
				}
			}
			else
			{
				$this->_common_params['id'] = $field_params['id'];
			}
		}

		// Mark required fields:
		if( isset($this->_common_params['required']) && $this->_common_params['required'] )
		{ // add "field_required" class:
			if( isset($field_params['type']) && $field_params['type'] == 'checkbox' )
			{ // checkboxes need a span
				$field_params['input_prefix'] = ( isset($field_params['input_prefix']) ? $field_params['input_prefix'] : '' ).'<span class="checkbox_required">';
				$field_params['input_suffix'] = '</span>'.( isset($field_params['input_suffix']) ? $field_params['input_suffix'] : '' );
			}
			else
			{
				$field_params['class'] = isset( $field_params['class'] ) ? $field_params['class'].' field_required' : 'field_required';
			}
		}

		// Error handling:
		if( isset($field_params['name']) && param_has_error( $field_params['name'] ) )
		{ // There is an error message for this field:
			if( isset($field_params['type']) && $field_params['type'] == 'checkbox' )
			{ // checkboxes need a span
				$field_params['input_prefix'] = ( isset($field_params['input_prefix']) ? $field_params['input_prefix'] : '' ).'<span class="checkbox_error">';
				$field_params['input_suffix'] = '</span>'.( isset($field_params['input_suffix']) ? $field_params['input_suffix'] : '' );
			}
			else
			{
				$field_params['class'] = isset( $field_params['class'] ) ? $field_params['class'].' field_error' : 'field_error';
			}

			if( $this->disp_param_err_messages_with_fields )
			{
				$this->_common_params['note'] .= ' <span class="field_error">'.param_get_error_msg( $field_params['name'] ).'</span>';
			}
		}

		#pre_dump( 'handle_common_params (after)', $field_params );
	}


	/**
	 * Display or return, according to {@link $output}.
	 *
	 * @return true|string True, if we want to display, the string if not.
	 */
	function display_or_return( $r )
	{
		if( $this->output )
		{
			echo $r;
			return true;
		}
		else
		{
			return $r;
		}
	}

}


?>