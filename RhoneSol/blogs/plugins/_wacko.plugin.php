<?php
/**
 * This file implements the Wacko plugin for b2evolution
 *
 * Wacko style formatting
 *
 * b2evolution - {@link http://b2evolution.net/}
 * Released under GNU GPL License - {@link http://b2evolution.net/about/license.html}
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 *
 * @package plugins
 * @ignore
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * @package plugins
 */
class wacko_plugin extends Plugin
{
	var $code = 'b2evWcko';
	var $name = 'Wacko formatting';
	var $priority = 30;
	var $version = '1.9-dev';
	var $apply_rendering = 'opt-in';
	var $group = 'rendering';
	var $short_desc;
	var $long_desc;
	var $number_of_installs = 1;

	/**
	 * GreyMatter formatting search array
	 *
	 * @access private
	 */
	var $search = array(
			'#( ^ | \s ) ====== (.+?) ====== #x',
			'#( ^ | \s ) ===== (.+?) ===== #x',
			'#( ^ | \s ) ==== (.+?) ==== #x',
			'#( ^ | \s ) === (.+?) === #x',
			'#( ^ | \s ) == (.+?) == #x',
			'#^ \s* --- \s* $#xm',	// multiline start/stop checking
			'/ %%%
				( \s*? \n )? 				# Eat optional blank line after %%%
				(.+?)
				( \n \s*? )? 				# Eat optional blank line before %%%
				%%%
			/sxe'		// %%%escaped codeblock%%%
		);

	/**
	 * HTML replace array
	 *
	 * @access private
	 */
	var $replace = array(
			'$1<h6>$2</h6>',
			'$1<h5>$2</h5>',
			'$1<h4>$2</h4>',
			'$1<h3>$2</h3>',
			'$1<h2>$2</h2>',
			'<hr />',
			'\'<div class="codeblock"><pre><code>\'.
			htmlspecialchars(stripslashes(\'$2\'),ENT_NOQUOTES).
			\'</code></pre></div>\''
		);

	/**
	 * Init
	 */
	function PluginInit( & $params )
	{
		$this->short_desc = T_('Wacko style formatting');
		$this->long_desc = T_('Accepted formats:<br />
			== h2 ==<br />
			=== h3 ===<br />
			==== h4 ====<br />
			===== h5 =====<br />
			====== h6 ======<br />
			--- (horinzontal rule)<br />
			%%%codeblock%%%<br />');
	}


	/**
	 * Perform rendering
	 *
	 * @param array Associative array of parameters
	 *   'data': the data (by reference). You probably want to modify this.
	 *   'format': see {@link format_to_output()}. Only 'htmlbody' and 'entityencoded' will arrive here.
	 * @return boolean true if we can render something for the required output format
	 */
	function RenderItemAsHtml( & $params )
	{
		$content = & $params['data'];

		$content = preg_replace( $this->search, $this->replace, $content );

		// Find bullet lists
		$lines = explode( "\n", $content );
		$lists = array();
		$current_depth = 0;
		$content = '';
		foreach( $lines as $line )
		{
			if( ! preg_match( '#^ /s $#xm', $line ) )
			{	 // If not blank line
				$matches = array();

				if( preg_match( '#^((  )+)\*(.*)$#m', $line, $matches ) )
				{	// We have a list item
					$req_depth = strlen( $matches[1] ) / 2;
					while( $current_depth < $req_depth )
					{	// We must indent
						$content .= "<ul>\n";
						array_push( $lists, 'ul' );
						$current_depth++;
					}

					while( $current_depth > $req_depth )
					{	// We must close lists
						$content .= '</'.array_pop( $lists ).">\n";
						$current_depth--;
					}

					$content .= $matches[1].'<li>'.$matches[3]."</li>\n";
					continue;
				}

				if( preg_match( '#^((  )+)([0-9]+)(.*)$#m', $line, $matches ) )
				{	// We have an ordered list item
					$req_depth = strlen( $matches[1] ) / 2;
					while( $current_depth < $req_depth )
					{	// We must indent
						$content .= '<ol start="'.$matches[3].'">'."\n";
						array_push( $lists, 'ol' );
						$current_depth++;
					}

					while( $current_depth > $req_depth )
					{	// We must close lists
						$content .= '</'.array_pop( $lists ).">\n";
						$current_depth--;
					}

					$content .= $matches[1].'<li>'.$matches[4]."</li>\n";
					continue;
				}

				// Normal line.

				if( $current_depth )
				{ // We must go back to 0
					$content .= '</'.implode( ">\n</", $lists ).">\n";
					$lists = array();
					$current_depth = 0;
				}

				$content .= $line."\n";

			}
		}

		if( $current_depth )
		{ // We must go back to 0
			$content .= '</'.implode( ">\n</", $lists ).">\n";
		}

		return true;
	}
}



?>