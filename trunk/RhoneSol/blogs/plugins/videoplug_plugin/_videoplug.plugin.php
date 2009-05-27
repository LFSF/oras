<?php
/**
 * This file implements the Video Plug plugin for b2evolution
 *
 * b2evolution - {@link http://b2evolution.net/}
 * Released under GNU GPL License - {@link http://b2evolution.net/about/license.html}
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 *
 * @package plugins
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * Replaces Video Plug markup in HTML (not XML).
 *
 * @package plugins
 */
class videoplug_plugin extends Plugin
{
	var $code = 'evo_videoplug';
	var $name = 'Video Plug';
	var $priority = 65;
	var $apply_rendering = 'opt-out';
	var $group = 'rendering';
	var $short_desc;
	var $long_desc;
	var $version = '2.2';
	var $number_of_installs = 1;


	/**
	 * Init
	 */
	function PluginInit( & $params )
	{
		$this->short_desc = T_('Video plug for a few popular video sites.');
		$this->long_desc = T_('This is a basic video plug pluigin. Use it by entering [video:youtube:123xyz] or [video:dailymotion:123xyz] into your post, where 123xyz is the ID of the video.');
	}


	/**
	 * Perform rendering
	 *
	 * @todo add more video sites, anyone...
	 *
	 * @see Plugin::RenderItemAsHtml()
	 */
	function RenderItemAsHtml( & $params )
	{
		$content = & $params['data'];

		// fp> removed some embeds to make it xhtml compliant, using only object. (Hari style ;)
		// anyone, feel free to clean up the ones that have no object tag at all.

		// Youtube:
		$content = preg_replace( '¤\[video:youtube:(.+?)]¤', '<div class="videoblock"><object data="http://www.youtube.com/v/\\1" type="application/x-shockwave-flash" wmode="transparent" width="425" height="350"><param name="movie" value="http://www.youtube.com/v/\\1"></param><param name="wmode" value="transparent"></param></object></div>', $content );

		// Dailymotion:
		$content = preg_replace( '¤\[video:dailymotion:(.+?)]¤', '<div class="videoblock"><object data="http://www.dailymotion.com/swf/\\1" type="application/x-shockwave-flash" width="425" height="335" allowfullscreen="true"><param name="movie" value="http://www.dailymotion.com/swf/\\1"></param><param name="allowfullscreen" value="true"></param></object></div>', $content );

		// Google video:
		$content = preg_replace( '¤\[video:google:(.+?)]¤', '<div class="videoblock"><embed style="width:400px; height:326px;" id="VideoPlayback" type="application/x-shockwave-flash" src="http://video.google.com/googleplayer.swf?docId=\\1&hl=en" flashvars=""></embed></div>', $content );

		// LiveVideo
		$content = preg_replace( '¤\[video:livevideo:(.+?)]¤', '<div class="videoblock"><object src="http://www.livevideo.com/flvplayer/embed/\\1" type="application/x-shockwave-flash" wmode="transparent" width="425" height="350"><param name="movie" value="http://www.livevideo.com/flvplayer/embed/\\1"></param><param name="wmode" value="transparent"></param></object></div>', $content );

		// iFilm
		$content = preg_replace( '¤\[video:ifilm:(.+?)]¤', '<div class="videoblock"><embed width="425" height="350" src="http://www.ifilm.com/efp" quality="high" bgcolor="000000" name="efp" align="middle" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="flvbaseclip=\\1"> </embed></div>', $content );

		return true;
	}



	/**
	 * Perform rendering for XML feeds
	 *
	 * @see Plugin::RenderItemAsXml()
	 */
	function RenderItemAsXml( & $params )
	{
		$this->RenderItemAsHtml( $params );

		/*
		$content = & $params['data'];
		$Item = & $params['Item'];

		$content = preg_replace( '¤\[video:.+?]¤', '<p>'.$Item->get_permanent_link( T_('See video').' &raquo;' ).'</p>', $content );
		*/

		return true;
	}

	/**
	 * Display a toolbar in admin
	 * dh>> Do the service names, e.g. "YouTube" have to be marked for i18n?
	 * fp> nope
	 *
	 * @param array Associative array of parameters
	 * @return boolean did we display a toolbar?
	 */
	function AdminDisplayToolbar( & $params )
	{
		if( $params['edit_layout'] == 'simple' )
		{	// This is too complex for simple mode, don't display it:
			return false;
		}

		echo '<div class="edit_toolbar">';
		echo T_('Video').': ';
		echo '<input type="button" id="video_youtube" title="'.T_('Insert Youtube video').'" class="quicktags" onclick="videotag(\'youtube\');" value="'.T_('YouTube').'" />';
		echo '<input type="button" id="video_google" title="'.T_('Insert Google video').'" class="quicktags" onclick="videotag(\'google\');" value="'.T_('Google video').'" />';
		echo '<input type="button" id="video_dailymotion" title="'.T_('Insert DailyMotion video').'" class="quicktags" onclick="videotag(\'dailymotion\');" value="'.T_('DailyMotion').'" />';
		echo '<input type="button" id="video_livevideo" title="'.T_('Insert LiveVideo video').'" class="quicktags" onclick="videotag(\'livevideo\');" value="'.T_('LiveVideo').'" />';
		echo '<input type="button" id="video_ifilm" title="'.T_('Insert iFilm video').'" class="quicktags" onclick="videotag(\'ifilm\');" value="'.T_('iFilm').'" />';

		echo '</div>';

		?>
		<script type="text/javascript">
			//<![CDATA[
			function videotag( tag )
			{
				var p = '<?php echo TS_('Enter video ID from %s:') ?>';
				var video_ID = prompt( p.replace( /%s/, tag ), '' );
				if( ! video_ID )
				{
					return;
				}

				tag = '[video:'+tag+':'+video_ID+']';

				textarea_wrap_selection( b2evoCanvas, tag, '', 1 );
			}
			//]]>
		</script>
		<?php

		return true;
	}

}



?>
