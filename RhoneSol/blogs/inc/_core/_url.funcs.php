<?php
/**
 * URL manipulation functions
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2006 by Daniel HAHLER - {@link http://daniel.hahler.de/}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * {@internal Open Source relicensing agreement:
 * Daniel HAHLER grants Francois PLANQUE the right to license
 * Daniel HAHLER's contributions to this file and the b2evolution project
 * under any OSI approved OSS license (http://www.opensource.org/licenses/).
 * }}
 *
 * @package evocore
 *
 * @author blueyed: Daniel HAHLER
 * @author Danny Ferguson
 *
 * @version $Id: _url.funcs.php,v 1.9.2.4 2008/04/14 16:02:14 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


/**
 * Check the validity of a given URL
 *
 * Checks allowed URI schemes and URL ban list.
 * URL can be empty.
 *
 * Note: We have a problem when trying to "antispam" a keyword which is already blacklisted
 * If that keyword appears in the URL... then the next page has a bad referer! :/
 *
 * {@internal This function gets tested in misc.funcs.simpletest.php.}}
 *
 * @param string Url to validate
 * @param string
 * @param boolean also do an antispam check on the url
 * @return mixed false (which means OK) or error message
 */
function validate_url( $url, $context = 'posting', $antispam_check = true )
{
	global $Debuglog, $debug;

	if( empty($url) )
	{ // Empty URL, no problem
		return false;
	}

	$verbose = $debug || $context != 'commenting';

	$allowed_uri_schemes = get_allowed_uri_schemes( $context );

	// Validate URL structure
	if( $url[0] == '$' )
	{	// This is a 'special replace code' URL (used in footers)
 		if( ! preg_match( '�\$([a-z_]+)\$�', $url ) )
		{
			return T_('Invalid URL $code$ format');
		}
	}
	elseif( preg_match( '~^\w+:~', $url ) )
	{ // there's a scheme and therefor an absolute URL:
		if( substr($url, 0, 7) == 'mailto:' )
		{ // mailto:link
			if( ! in_array( 'mailto', $allowed_uri_schemes ) )
			{ // Scheme not allowed
				$scheme = 'mailto:';
				$Debuglog->add( 'URI scheme &laquo;'.$scheme.'&raquo; not allowed!', 'error' );
				return $verbose
					? sprintf( T_('URI scheme "%s" not allowed.'), htmlspecialchars($scheme) )
					: T_('URI scheme not allowed.');
			}

			preg_match( '~^(mailto):(.*?)(\?.*)?$~', $url, $match );
			if( ! $match )
			{
				return $verbose
					? sprintf( T_('Invalid email link: %s.'), htmlspecialchars($url) )
					: T_('Invalid email link.');
			}
      elseif( ! is_email($match[2]) )
			{
				return $verbose
					? sprintf( T_('Supplied email address (%s) is invalid.'), htmlspecialchars($match[2]) )
					: T_('Invalid email address.');
			}
		}
		elseif( substr($url, 0, 6) == 'clsid:' )
		{ // clsid:link
			if( ! in_array( 'clsid', $allowed_uri_schemes ) )
			{ // Scheme not allowed
				$scheme = 'clsid:';
				$Debuglog->add( 'URI scheme &laquo;'.$scheme.'&raquo; not allowed!', 'error' );
				return $verbose
					? sprintf( T_('URI scheme "%s" not allowed.'), htmlspecialchars($scheme) )
					: T_('URI scheme not allowed.');
			}

			if( ! preg_match( '�^(clsid):([a-fA-F0-9\-]+)$�', $url, $match) )
			{
				return T_('Invalid class ID format');
			}
		}
		elseif( substr($url, 0, 11) == 'javascript:' )
		{ // javascript:
			// Basically there could be anything here
			if( ! in_array( 'javascript', $allowed_uri_schemes ) )
			{ // Scheme not allowed
				$scheme = 'javascript:';
				$Debuglog->add( 'URI scheme &laquo;'.$scheme.'&raquo; not allowed!', 'error' );
				return $verbose
					? sprintf( T_('URI scheme "%s" not allowed.'), htmlspecialchars($scheme) )
					: T_('URI scheme not allowed.');
			}

			preg_match( '�^(javascript):�', $url, $match );
		}
		else
		{
			// convert URL to IDN:
			load_funcs('_ext/idna/_idna_convert.class.php');
			$IDNA = new Net_IDNA_php4();
			global $evo_charset;
			$url = $IDNA->encode( convert_charset($url, 'utf-8', $evo_charset) );

			if( ! preg_match('~^           # start
				([a-z][a-z0-9+.\-]*)             # scheme
				://                              # authorize absolute URLs only ( // not present in clsid: -- problem? ; mailto: handled above)
				(\w+(:\w+)?@)?                   # username or username and password (optional)
				( localhost |
						[a-z0-9]([a-z0-9\-])*            # Don t allow anything too funky like entities
						\.                               # require at least 1 dot
						[a-z0-9]([a-z0-9.\-])+           # Don t allow anything too funky like entities
				)
				(:[0-9]+)?                       # optional port specification
				[^ ]*                            # allow no space
				$~ix', $url, $match) )
			{ // Cannot validate URL structure
				$Debuglog->add( 'URL &laquo;'.$url.'&raquo; does not match url pattern!', 'error' );
				return $verbose
					? sprintf( T_('Invalid URL format (%s).'), htmlspecialchars($url) )
					: T_('Invalid URL format.');
			}

			$scheme = strtolower($match[1]);
			if( ! in_array( $scheme, $allowed_uri_schemes ) )
			{ // Scheme not allowed
				$Debuglog->add( 'URI scheme &laquo;'.$scheme.'&raquo; not allowed!', 'error' );
				return $verbose
					? sprintf( T_('URI scheme "%s" not allowed.'), htmlspecialchars($scheme) )
					: T_('URI scheme not allowed.');
			}
		}
	}
	else
	{ // URL is relative..
		if( $context == 'commenting' )
		{	// We do not allow relative URLs in comments
			return $verbose ? sprintf( T_('URL "%s" must be absolute.'), htmlspecialchars($url) ) : T_('URL must be absolute.');
		}

		$char = substr($url, 0, 1);
		if( $char != '/' && $char != '#' )
		{ // must start with a slash or hash (for HTML anchors to the same page)
			return $verbose
				? sprintf( T_('URL "%s" must be a full path starting with "/" or an anchor starting with "#".'), htmlspecialchars($url) )
				: T_('URL must be a full path starting with "/" or an anchor starting with "#".');
		}
	}


	if( $antispam_check )
	{	// Search for blocked keywords:
		if( $block = antispam_check($url) )
		{
			return $verbose
				? sprintf( T_('URL "%s" not allowed: blacklisted word "%s".'), htmlspecialchars($url), $block )
				: T_('URL not allowed');
		}
	}

	return false; // OK
}


/**
 *
 * @param string
 * @return array
 */
function get_allowed_uri_schemes( $context = 'posting' )
{
  /**
	 * @var User
	 */
	global $current_User;

	$schemes = array(
			'http',
			'https',
			'ftp',
			'gopher',
			'nntp',
			'news',
			'mailto',
			'irc',
			'aim',
			'icq'
		);

	if( $context == 'commenting' )
	{
		return $schemes;
	}

	if( !empty( $current_User ) )
	{	// Add additional permissions the current User may have:

		$Group = & $current_User->get_Group();

	  if( $Group->perm_xhtml_javascript )
		{
			$schemes[] = 'javascript';
		}

		if( $Group->perm_xhtml_objects )
		{
			$schemes[] = 'clsid';
		}

	}

	return $schemes;
}


/**
 * Fetch remote page
 *
 * Attempt to retrieve a remote page, first with cURL, then fsockopen, then fopen.
 *
 * @todo dh> Should we try remaining methods, if the previous one(s) failed?
 * @param string URL
 * @param array Info (by reference)
 *        'error': holds error message, if any
 *        'status': HTTP status (e.g. 200 or 404)
 *        'used_method': Used method ("curl", "fopen", "fsockopen" or null if no method
 *                       is available)
 * @return string|false The remote page as a string; false in case of error
 */
function fetch_remote_page( $url, & $info )
{
	$info = array(
		'error' => '',
		'status' => NULL );

	// CURL:
	if( extension_loaded('curl') )
	{
		$info['used_method'] = 'curl';

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		if( ! empty($params['method']) && $params['method'] == 'HEAD'  )
		{
			curl_setopt($ch, CURLOPT_NOBODY, true);
		}
		$r = curl_exec($ch);
		$info['status'] = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		$info['error'] = curl_error($ch);
		if( curl_errno($ch) )
		{
			$info['error'] .= '(#'.curl_errno($ch).')';
		}
		curl_close($ch);

		return $r;
	}


	// FSOCKOPEN:
	if( function_exists('fsockopen') ) // may have been disabled
	{
		$info['used_method'] = 'fsockopen';
		$url_parsed = parse_url($url);
		if( empty($url_parsed['scheme']) )
		{
			$url_parsed = parse_url('http://'.$url);
		}

		$host = $url_parsed['host'];
		$port = ( empty($url_parsed['port']) ? 80 : $url_parsed['port'] );
		$path = empty($url_parsed['path']) ? '/' : $url_parsed['path'];
		if( ! empty($url_parsed['query']) )
		{
			$path .= '?'.$url_parsed['query'];
		}

		$out = "GET $path HTTP/1.1\r\n";
		$out .= 'Host: '.$host;
		if( !empty($url_parsed['port']) )
		{	// we don't want to add :80 if not specified. remote end may not resolve it. (e-g b2evo multiblog does not)
			$out .= ':'.$port;
		}
		$out .= "\r\nConnection: Close\r\n\r\n";

		// pre_dump($out);

		$fp = @fsockopen($host, $port, $errno, $errstr, 30);
		if( ! $fp )
		{
			$info['error'] = $errstr.' (#'.$errno.')';
			return false;
		}

		// Set timeout for data:
		if( function_exists('stream_set_timeout') )
			stream_set_timeout( $fp, 20 ); // PHP 4.3.0
		else
			socket_set_timeout( $fp, 20 ); // PHP 4

		// Send request:
		fwrite($fp, $out);

		// Read response:
		$r = '';
		// First line:
		$s = fgets($fp, 4096);
		if( ! preg_match( '~^HTTP/\d+\.\d+ (\d+)~', $s, $match ) )
		{
			$info['error'] = 'Invalid response.';
			$r = false;
		}
		else
		{
			$info['status'] = $match[1];

			$foundBody = false;
			while( ! feof($fp) )
			{
				$s = fgets($fp, 4096);
				if( $s == "\r\n" )
				{
					$foundBody = true;
					continue;
				}
				if( $foundBody )
				{
					$r .= $s;
				}
			}
		}
		fclose($fp);
		return $r;
	}


	// URL FOPEN:
	if( ini_get('allow_url_fopen') && function_exists('stream_get_meta_data') /* PHP 4.3, may also be disabled!? */ )
	{
		$info['used_method'] = 'fopen';

		$fp = @fopen($url, 'r');
		if( $fp )
		{ // this will be false e.g. for "404", but it's not trivial to get the status error for this, so we retry with fsockopen further down
			// headers:
			$meta = stream_get_meta_data($fp);
			if( ! $meta || ! preg_match( '~^HTTP/\d+\.\d+ (\d+)~', $meta['wrapper_data'][0], $match ) )
			{
				$info['error'] = 'Invalid response.';
				$r = false;
			}
			else
			{
				$info['status'] = $match[1];
				$r = '';
				while( $buf = fread($fp, 4096) )
				{ //read the complete file (binary safe)
					$r .= $buf;
				}
			}
			fclose($fp);

			return $r;
		}
	}


	// All failed:
	$info['used_method'] = null;
	$info['error'] = 'No method available to access URL!';
	return false;
}


/**
 * Get $url with the same protocol (http/https) as $other_url.
 *
 * @param string URL
 * @param string other URL (defaults to {@link $ReqHost})
 * @return string
 */
function url_same_protocol( $url, $other_url = NULL )
{
	if( is_null($other_url) )
	{
		global $ReqHost;

		$other_url = $ReqHost;
	}

	// change protocol of $url to same of admin ('https' <=> 'http')
	if( substr( $url, 0, 7 ) == 'http://' )
	{
		if( substr( $other_url, 0, 8 ) == 'https://' )
		{
			$url = 'https://'.substr( $url, 7 );
		}
	}
	elseif( substr( $url, 0, 8 ) == 'https://' )
	{
		if( substr( $other_url, 0, 7 ) == 'http://' )
		{
			$url = 'http://'.substr( $url, 8 );
		}
	}

	return $url;
}


/**
 * Add param(s) at the end of an URL, using either "?" or "&amp;" depending on existing url
 *
 * @param string existing url
 * @param string params to add
 * @param string delimiter to use for more params
 */
function url_add_param( $url, $param, $glue = '&amp;' )
{
	if( empty($param) )
	{
		return $url;
	}

	if( ($anchor_pos = strpos($url, '#')) !== false )
	{ // There's an "#anchor" in the URL
		$anchor = substr($url, $anchor_pos);
		$url = substr($url, 0, $anchor_pos);
	}
	else
	{ // URL without "#anchor"
		$anchor = '';
	}

	if( strpos( $url, '?' ) !== false )
	{ // There are already params in the URL
		return $url.$glue.$param.$anchor;
	}


	// These are the first params
	return $url.'?'.$param.$anchor;
}


/**
 * Add a tail (starting with "/") at the end of an URL before any params (starting with "?")
 *
 * @param string existing url
 * @param string tail to add
 */
function url_add_tail( $url, $tail )
{
	$parts = explode( '?', $url );
	if( substr($parts[0], -1) == '/' )
	{
		$parts[0] = substr($parts[0], 0, -1);
	}
	if( isset($parts[1]) )
	{
		return $parts[0].$tail.'?'.$parts[1];
	}

	return $parts[0].$tail;
}


/**
 * Try to make $url relative to $target_url, if scheme, host, user and pass matches.
 *
 * This is useful for redirect_to params, to keep them short and avoid mod_security
 * rejecting the request as "Not Acceptable" (whole URL as param).
 *
 * @param string URL to handle
 * @param string URL where we want to make $url relative to
 * @return string
 */
function url_rel_to_same_host( $url, $target_url )
{
	$parsed_url = @parse_url( $url );
	if( ! $parsed_url )
	{ // invalid url
		return $url;
	}
	if( empty($parsed_url['scheme']) || empty($parsed_url['host']) )
	{ // no protocol or host information
		return $url;
	}

	$target_url = @parse_url( $target_url );
	if( ! $target_url )
	{ // invalid url
		return $url;
	}
	if( ! empty($target_url['scheme']) && $target_url['scheme'] != $parsed_url['scheme'] )
	{ // scheme/protocol is different
		return $url;
	}
	if( ! empty($target_url['host']) )
	{
		if( empty($target_url['scheme']) || $target_url['host'] != $parsed_url['host'] )
		{ // target has no scheme (but a host) or hosts differ
			return $url;
		}

		if( @$target_url['port'] != @$parsed_url['port'] )
			return $url;
		if( @$target_url['user'] != @$parsed_url['user'] )
			return $url;
		if( @$target_url['pass'] != @$parsed_url['pass'] )
			return $url;
	}

	// We can make the URL relative:
	$r = '';
	if( ! empty($parsed_url['path']) )
		$r .= $parsed_url['path'];
	if( ! empty($parsed_url['query']) )
		$r .= '?'.$parsed_url['query'];
	if( ! empty($parsed_url['fragment']) )
		$r .= '?'.$parsed_url['fragment'];

	return $r;
}


/**
 * Make an $url absolute according to $host, if it is not absolute yet.
 *
 * @param string URL
 * @param string Host (including protocol, e.g. 'http://example.com'); defaults to {@link $ReqHost}
 * @return string
 */
function url_absolute( $url, $host = NULL )
{
	if( preg_match( '~^(\w+:)?//~', $url ) )
	{ // URL is relative already ("//foo/bar" is absolute - leaving the protocol out):
		return $url;
	}

	if( empty($host) )
	{
		global $ReqHost;
		$host = $ReqHost;
	}
	return $host.$url;
}


/**
 * Make links in $s absolute.
 *
 * It searches for "src" and "href" HTML tag attributes and makes the absolute.
 *
 * @uses url_absolute()
 * @param string content
 * @param string Hostname including scheme, e.g. http://example.com; defaults to $ReqHost
 * @return string
 */
function make_rel_links_abs( $s, $host = NULL )
{
	if( empty($host) )
	{
		global $ReqHost;
		$host = $ReqHost;
	}

	$s = preg_replace_callback( '~(<[^>]+?)\b((?:src|href)\s*=\s*)(["\'])?([^\\3]+?)(\\3)~i', create_function( '$m', '
		return $m[1].$m[2].$m[3].url_absolute($m[4], "'.$host.'").$m[5];' ), $s );
	return $s;
}


/**
 * Display an URL, constrained to a max length
 *
 * @param string
 * @param integer
 */
function disp_url( $url, $max_length = NULL )
{
	if( !empty($max_length) && strlen($url) > $max_length )
	{
		$disp_url = htmlspecialchars(substr( $url, 0, $max_length-1 )).'&hellip;';
	}
	else
	{
		$disp_url = htmlspecialchars($url);
	}
	echo '<a href="'.$url.'">'.$disp_url.'</a>';
}


/* {{{ Revision log:
 * $Log: _url.funcs.php,v $
 * Revision 1.9.2.4  2008/04/14 16:02:14  fplanque
 * MFH
 *
 * Revision 1.9.2.3  2008/02/18 20:23:20  fplanque
 * no message
 *
 * Revision 1.9.2.2  2008/02/11 23:51:58  fplanque
 * MFH
 *
 * Revision 1.10  2008/02/09 16:19:31  fplanque
 * fixed commenting bugs
 *
 * Revision 1.9  2008/01/21 09:35:23  fplanque
 * (c) 2008
 *
 * Revision 1.8  2008/01/20 15:31:12  fplanque
 * configurable validation/security rules
 *
 * Revision 1.7  2008/01/19 18:24:24  fplanque
 * antispam checking refactored
 *
 * Revision 1.6  2008/01/19 15:45:28  fplanque
 * refactoring
 *
 * Revision 1.5  2008/01/18 15:53:42  fplanque
 * Ninja refactoring
 *
 * Revision 1.4  2008/01/05 02:25:23  fplanque
 * refact
 *
 * Revision 1.3  2007/11/27 22:31:57  fplanque
 * debugged blog moderation
 *
 * Revision 1.2  2007/07/03 22:16:15  blueyed
 * Solved todo: changed order to "cURL, fsockopen, fopen" for fetch_remote_page
 *
 * Revision 1.1  2007/06/25 10:58:54  fplanque
 * MODULES (refactored MVC)
 *
 * Revision 1.10  2007/04/26 00:11:08  fplanque
 * (c) 2007
 *
 * Revision 1.9  2007/03/12 22:39:42  blueyed
 * Fixed just introduced E_PARSE
 *
 * Revision 1.8  2007/03/12 22:12:58  blueyed
 * fetch_remote_page(): handle case when fsockopen is disabled
 *
 * Revision 1.7  2007/03/08 22:55:21  blueyed
 * fetch_remote_page: Added "used_method" to $info and errno to "curl" method.
 *
 * Revision 1.6  2006/12/22 00:25:15  blueyed
 * Do not send URL fragment in GET
 *
 * Revision 1.5  2006/12/21 21:50:52  fplanque
 * doc
 *
 * Revision 1.4  2006/12/19 21:35:26  blueyed
 * fetch_remote_page(): if url_fopen fails, use fsockopen-fallback (for errstr and status). Plus minor fixes.
 *
 * Revision 1.3  2006/12/01 17:31:38  blueyed
 * Fixed url_fopen method for fetch_remote_page
 *
 * Revision 1.2  2006/11/29 20:48:46  blueyed
 * Moved url_rel_to_same_host() from _misc.funcs.php to _url.funcs.php
 *
 * Revision 1.1  2006/11/25 23:00:39  blueyed
 * Added file for URL handling. Includes fetch_remote_page()
 *
 * }}}
 */
?>