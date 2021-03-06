<?php
/**
 * This file implements the BBcode plugin for b2evolution
 *
 * BB style formatting, like [b]bold[/b]
 *
 * b2evolution - {@link http://b2evolution.net/}
 * Released under GNU GPL License - {@link http://b2evolution.net/about/license.html}
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 *
 * @package plugins
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * @package plugins
 */
class bbcode_plugin extends Plugin
{
	var $code = 'b2evBBco';
	var $name = 'BB code';
	var $priority = 50;
	var $version = '1.9-dev';
	var $apply_rendering = 'opt-in';
	var $group = 'rendering';
	var $short_desc;
	var $long_desc;
	var $number_of_installs = 1;

	/*
	 * Internal
	 */
	var $post_search_list;
	var $post_replace_list;
	var $comment_search_list;
	var $comment_replace_list;

	/**
	 * Init
	 */
	function PluginInit( & $params )
	{
		$this->short_desc = T_('BB formatting e-g [b]bold[/b]');
		$this->long_desc = T_('Available tags are: [b] [i] [u] [s] [color=...] [size=...] [font=...] [code] [quote] [list=1] [list=a] [list] [*]');
	}

	/**
	 * Get the default settings of the plugin.
	 *
	 * @return array
	 */
	function GetDefaultSettings()
	{
		return array(
			'post_settings_begin' => array(
				'layout' => 'begin_fieldset',
				'label' => $this->T_( 'Settings for posts' ),
			),
			'post_search_list' => array(
				'label' => $this->T_( 'Search list'),
				'note' => $this->T_( 'This is the BBcode search array for posts (one per line) ONLY CHANGE THESE IF YOU KNOW WHAT YOU\'RE DOING' ),
				'type' => 'html_textarea',
				'rows' => 10,
				'defaultvalue' => '#\[b](.+?)\[/b]#is
#\[i](.+?)\[/i]#is
#\[u](.+?)\[/u]#is
#\[s](.+?)\[/s]#is
!\[color=(#?[A-Za-z0-9]+?)](.+?)\[/color]!is
#\[size=([0-9]+?)](.+?)\[/size]#is
#\[font=([A-Za-z0-9 ;\-]+?)](.+?)\[/font]#is
#\[code](.+?)\[/code]#is
#\[quote](.+?)\[/quote]#is
#\[list=1](.+?)\[/list]#is
#\[list=a](.+?)\[/list]#is
#\[list](.+?)\[/list]#is
#\[\*](.+?)\n#is
!\[bg=(#?[A-Za-z0-9]+?)](.+?)\[/bg]!is',
			),
			'post_replace_list' => array(
				'label' => $this->T_( 'Replace list'),
				'note' => $this->T_( 'This is the replace array for posts (one per line) it must match the exact order of the search array' ),
				'type' => 'html_textarea',
				'rows' => 10,
				'defaultvalue' => '<strong>$1</strong>
<em>$1</em>
<span style="text-decoration:underline">$1</span>
<span style="text-decoration:line-through">$1</span>
<span style="color:$1">$2</span>
<span style="font-size:$1px">$2</span>
<span style="font-family:$1">$2</span>
<pre>$1</pre>
&laquo;&nbsp;$1&nbsp;&raquo;
<ol type="1">$1</ol>
<ol type="a">$1</ol>
<ul>$1</ul>
<li>$1</li>
<span style="background-color:$1">$2</span>',
			),
			'post_settings_end' => array(
				'layout' => 'end_fieldset',
			),
			'comment_settings_begin' => array(
				'type' => 'layout',
				'layout' => 'begin_fieldset',
				'label' => $this->T_( 'Settings for comments' ),
			),
			'render_comments' => array(
				'label' => $this->T_('Render comments' ),
				'note' => $this->T_('If enabled the BBcode in comments will be rendered'),
				'defaultvalue' => 0,
				'type' => 'checkbox',
			),
			'comment_search_list' => array(
				'label' => $this->T_( 'Search list'),
				'note' => $this->T_( 'This is the BBcode search array for COMMENTS (one per line) ONLY CHANGE THESE IF YOU KNOW WHAT YOU\'RE DOING' ),
				'type' => 'html_textarea',
				'rows' => 10,
				'defaultvalue' => '#\[b](.+?)\[/b]#is
#\[i](.+?)\[/i]#is
#\[u](.+?)\[/u]#is
#\[s](.+?)\[/s]#is
!\[color=(#?[A-Za-z0-9]+?)](.+?)\[/color]!is
#\[size=([0-9]+?)](.+?)\[/size]#is
#\[font=([A-Za-z0-9 ;\-]+?)](.+?)\[/font]#is
#\[code](.+?)\[/code]#is
#\[quote](.+?)\[/quote]#is
#\[list=1](.+?)\[/list]#is
#\[list=a](.+?)\[/list]#is
#\[list](.+?)\[/list]#is
#\[\*](.+?)\n#is
!\[bg=(#?[A-Za-z0-9]+?)](.+?)\[/bg]!is',
			),
			'comment_replace_list' => array(
				'label' => $this->T_( 'Replace list'),
				'note' => $this->T_( 'This is the replace array for COMMENTS (one per line) it must match the exact order of the search array' ),
				'type' => 'html_textarea',
				'rows' => 10,
				'defaultvalue' => '<strong>$1</strong>
<em>$1</em>
<span style="text-decoration:underline">$1</span>
<span style="text-decoration:line-through">$1</span>
<span style="color:$1">$2</span>
<span style="font-size:$1px">$2</span>
<span style="font-family:$1">$2</span>
<pre>$1</pre>
&laquo;&nbsp;$1&nbsp;&raquo;
<ol type="1">$1</ol>
<ol type="a">$1</ol>
<ul>$1</ul>
<li>$1</li>
<span style="background-color:$1">$2</span>',
			),
			'comment_settings_end' => array(
				'type' => 'layout',
				'layout' => 'end_fieldset',
			),
		);
	}

	/**
	 * Perform rendering
	 *
	 * @see Plugin::RenderItemAsHtml()
	 */
	function RenderItemAsHtml( & $params )
	{
		$content = & $params['data'];
		if( !isset( $this->post_search_list ) )
			$this->post_search_list = explode( "\n", str_replace( "\r", '', $this->Settings->get( 'post_search_list' ) ) );

		if( !isset( $this->post_replace_list ) )
			$this->post_replace_list = explode( "\n", str_replace( "\r", '', $this->Settings->get( 'post_replace_list' ) ) );

		$content = preg_replace( $this->post_search_list, $this->post_replace_list, $content );

		return true;
	}


	/**
	 * Do the same as for HTML.
	 *
	 * @see RenderItemAsHtml()
	 */
	function RenderItemAsXml( & $params )
	{
		$this->RenderItemAsHtml( $params );
	}

	/**
	 *
	 * Render comments if required
	 *
	 * @see Plugin::FilterCommentContent()
	 */
	function FilterCommentContent( & $params )
	{
		if( $this->Settings->get( 'render_comments' ) )
		{
		$content = & $params['data'];
		if( !isset( $this->comment_search_list ) )
			$this->comment_search_list = explode( "\n", str_replace( "\r", '', $this->Settings->get( 'comment_search_list' ) ) );

		if( !isset( $this->comment_replace_list ) )
			$this->comment_replace_list = explode( "\n", str_replace( "\r", '', $this->Settings->get( 'comment_replace_list' ) ) );

		$content = preg_replace( $this->comment_search_list, $this->comment_replace_list, $content );
		}
	}
}



?>