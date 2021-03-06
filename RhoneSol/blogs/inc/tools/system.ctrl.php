<?php
/**
 * This file implements the UI controller for System configuration and analysis.
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 * Parts of this file are copyright (c)2006 by Daniel HAHLER - {@link http://daniel.hahler.de/}.
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
 * @author fplanque: Francois PLANQUE.
 * @author blueyed
 *
 * @version $Id: system.ctrl.php,v 1.9.4.2 2008/04/26 22:28:53 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_funcs( 'tools/model/_system.funcs.php' );

// Check minimum permission:
$current_User->check_perm( 'options', 'view', true );

$AdminUI->set_path( 'tools', 'system' );

// Display <html><head>...</head> section! (Note: should be done early if actions do not redirect)
$AdminUI->disp_html_head();

// Display title, menu, messages, etc. (Note: messages MUST be displayed AFTER the actions)
$AdminUI->disp_body_top();

// Begin payload block:
$AdminUI->disp_payload_begin();

function init_system_check( $name, $value )
{
	global $syscheck_name, $syscheck_value;
	$syscheck_name = $name;
	$syscheck_value = $value;
}

function disp_system_check( $condition, $message = '' )
{
	global $syscheck_name, $syscheck_value;
	echo '<div class="system_check">';
	echo '<div class="system_check_name">';
	echo $syscheck_name;
	echo '</div>';
	echo '<div class="system_check_value_'.$condition.'">';
	echo $syscheck_value;
	echo '&nbsp;</div>';
	if( !empty( $message ) )
	{
		echo '<div class="system_check_message_'.$condition.'">';
		echo $message;
		echo '</div>';
	}
	echo '</div>';
}

$facilitate_exploits = '<p>'.T_('When enabled, this feature is known to facilitate hacking exploits in any PHP application.')."</p>\n<p>"
	.T_('b2evolution includes additional measures in order not to be affected by this.
	However, for maximum security, we still recommend disabling this PHP feature.')."</p>\n";
$change_ini = '<p>'.T_('If possible, change this setting to <code>%s</code> in your php.ini or ask your hosting provider about it.').'</p>';


echo '<h2>'.T_('About this system').'</h2>';

$block_item_Widget = & new Widget( 'block_item' );


/**
 * b2evolution
 */
$block_item_Widget->title = 'b2evolution';
$block_item_Widget->disp_template_replaced( 'block_start' );

// Version:
$app_timestamp = mysql2timestamp( $app_date );
init_system_check( 'b2evolution version', $app_version.' released on '.date_i18n( locale_datefmt(), $app_timestamp ) );
$app_age = ($localtimenow - $app_timestamp) / 3600 / 24 / 30;	// approx age in months
if( $app_age > 12 )
{
	disp_system_check( 'error', sprintf( T_('This version is old. You should check for newer releases on <a %s>b2evolution.net</a>.'),
		' href="http://b2evolution.net/downloads/"'	) );
}
elseif( $app_age > 6 )
{
	disp_system_check( 'warning', sprintf( T_('This version is aging. You may want to check for newer releases on <a %s>b2evolution.net</a>.'),
		' href="http://b2evolution.net/downloads/"'	) );
}
else
{
	disp_system_check( 'ok' );
}


// Media folder writable?
list( $mediadir_status, $mediadir_msg ) = system_check_media_dir();
$mediadir_long = '';
if( $mediadir_status == 'error' )
{
	$mediadir_long = '<p>'.T_('You will not be able to upload files/images and b2evolution will not be able to generate thumbnails.')."</p>\n"
	.'<p>'.T_('Your host requires that you set special file permissions on your media directory.').get_manual_link('media_file_permission_errors')."</p>\n";
}
init_system_check( 'Media directory', $mediadir_msg.' - '.$media_path );
disp_system_check( $mediadir_status, $mediadir_long );


// /install/ folder deleted?
$install_removed = system_check_install_removed();
init_system_check( 'Install folder', $install_removed ?  T_('Deleted') : T_('Not deleted').' - '.$basepath.$install_subdir );
if( ! $install_removed )
{
	disp_system_check( 'warning', T_('For maximum security, it is recommended that you delete your /blogs/install/ folder once you are done with install or upgrade.') );

	// Database reset allowed?
	init_system_check( 'Database reset', $allow_evodb_reset ?  T_('Allowed!') : T_('Forbidden') );
	if( $allow_evodb_reset )
	{
  	disp_system_check( 'error', '<p>'.T_('Currently, anyone who accesses your install folder could entirely reset your b2evolution database.')."</p>\n"
  	 .'<p>'.T_('ALL YOUR DATA WOULD BE LOST!')."</p>\n"
  	 .'<p>'.T_('As soon as possible, change the setting <code>$allow_evodb_reset = 0;</code> in your /conf/_basic.config.php.').'</p>' );
	}
	else
	{
		disp_system_check( 'ok' );
	}
}
else
{
	disp_system_check( 'ok' );
}


$block_item_Widget->disp_template_raw( 'block_end' );


/*
 * Time
 */
$block_item_Widget->title = T_('Time');
$block_item_Widget->disp_template_replaced( 'block_start' );

init_system_check( 'Server time', date_i18n( locale_datetimefmt( ' - ' ), $servertimenow ) );
disp_system_check( 'note' );

init_system_check( 'GMT / UTC time', gmdate( locale_datetimefmt( ' - ' ), $servertimenow ) );
disp_system_check( 'note' );

init_system_check( 'b2evolution time', date_i18n( locale_datetimefmt( ' - ' ), $localtimenow ) );
disp_system_check( 'note' );

$block_item_Widget->disp_template_raw( 'block_end' );


/*
 * MySQL Version
 */
$block_item_Widget->title = T_('MySQL');
$block_item_Widget->disp_template_replaced( 'block_start' );

// Version:
$mysql_version = $DB->get_version();
init_system_check( 'MySQL version', $DB->version_long );
if( version_compare( $mysql_version, '4.0' ) < 0 )
{
	disp_system_check( 'warning', T_('This version is not guaranteed to work.') );
}
else
{
	disp_system_check( 'ok' );
}

// UTF8 support?
$ok = system_check_db_utf8();
init_system_check( 'MySQL UTF-8 support', $ok ?  T_('Yes') : T_('No') );
if( ! $ok )
{
	disp_system_check( 'warning', T_('UTF-8 is not supported by your MySQL server.') ); // fp> TODO: explain why this is bad. Better yet: try to detect if we really need it, base don other conf variables.
}
else
{
	disp_system_check( 'ok' );
}

$block_item_Widget->disp_template_raw( 'block_end' );


/**
 * PHP
 */
$block_item_Widget->title = T_('PHP');
$block_item_Widget->disp_template_replaced( 'block_start' );


// User ID:
list( $uid, $uname, $running_as ) = system_check_process_user();
init_system_check( 'PHP running as USER:', $running_as );
disp_system_check( 'note' );


// Group ID:
list( $gid, $gname, $running_as ) = system_check_process_group();
init_system_check( 'PHP running as GROUP:', $running_as );
disp_system_check( 'note' );


// PHP version
init_system_check( 'PHP version', PHP_VERSION );
if( version_compare( PHP_VERSION, '4.1', '<' ) )
{
	disp_system_check( 'error', T_('This version is too old. b2evolution will not run correctly. You must ask your host to upgrade PHP before you can run b2evolution.') );
}
elseif( version_compare( PHP_VERSION, '4.3', '<' ) )
{
	disp_system_check( 'warning', T_('This version is old. b2evolution may run but some features may fail. You should ask your host to upgrade PHP before running b2evolution.') );
}
else
{
	disp_system_check( 'ok' );
}

// register_globals?
init_system_check( 'PHP register_globals', ini_get('register_globals') ?  T_('On') : T_('Off') );
if( ini_get('register_globals' ) )
{
	disp_system_check( 'warning', $facilitate_exploits.' '.sprintf( $change_ini, 'register_globals = Off' )  );
}
else
{
	disp_system_check( 'ok' );
}


// allow_url_include? (since 5.2, supercedes allow_url_fopen for require()/include()
if( version_compare(PHP_VERSION, '5.2', '>=') )
{
	init_system_check( 'PHP allow_url_include', ini_get('allow_url_include') ?  T_('On') : T_('Off') );
	if( ini_get('allow_url_include' ) )
	{
		disp_system_check( 'warning', $facilitate_exploits.' '.sprintf( $change_ini, 'allow_url_include = Off' )  );
	}
	else
	{
		disp_system_check( 'ok' );
	}
}


/*
 * allow_url_fopen
 * Note: this allows including of remote files (PHP 4 only) as well as opening remote files with fopen() (all versions of PHP)
 * Both have potential for exploits. (The first is easier to exploit than the second).
 * dh> Should we check for curl etc then also and warn the user until there's no method for us anymore to open remote files?
 * fp> Yes
 */
init_system_check( 'PHP allow_url_fopen', ini_get('allow_url_fopen') ?  T_('On') : T_('Off') );
if( ini_get('allow_url_fopen' ) )
{
	disp_system_check( 'warning', $facilitate_exploits.' '.sprintf( $change_ini, 'allow_url_fopen = Off' )  );
}
else
{
	disp_system_check( 'ok' );
}


// Magic quotes:
if( !strcasecmp( ini_get('magic_quotes_sybase'), 'on' ) )
{
	$magic_quotes = T_('On').' (magic_quotes_sybase)';
	$message = 'magic_quotes_sybase = Off';
}
elseif( get_magic_quotes_gpc() )
{
	$magic_quotes = T_('On').' (magic_quotes_gpc)';
	$message = 'magic_quotes_gpc = Off';
}
else
{
	$magic_quotes = T_('Off');
	$message = '';
}
init_system_check( 'PHP Magic Quotes', $magic_quotes );
if( !empty( $message ) )
{
	disp_system_check( 'warning', T_('PHP is adding extra quotes to all inputs. This leads to unnecessary extra processing.')
		.' '.sprintf( $change_ini, $message ) );
}
else
{
	disp_system_check( 'ok' );
}


// Max upload size:
$upload_max_filesize = system_check_upload_max_filesize();
init_system_check( 'PHP upload_max_filesize', ini_get('upload_max_filesize') );
disp_system_check( 'ok' );

// Max post size:
$post_max_size = system_check_post_max_size();
init_system_check( 'PHP post_max_size', ini_get('post_max_size') );
if( $post_max_size > $upload_max_filesize )
{
	disp_system_check( 'ok' );
}
else
{
	disp_system_check( 'error', T_('post_max_size should be larger than upload_max_filesize') );
}

// Memory limit:
$memory_limit = system_check_memory_limit();
if( empty($memory_limit) )
{
	init_system_check( 'PHP memory_limit', T_('n.a.') );
	disp_system_check( 'note' );
}
else
{
	init_system_check( 'PHP memory_limit', ini_get('memory_limit') );
	if( $memory_limit < 8096 )
	{
		disp_system_check( 'error', T_('The memory_limit is very low. Some features of b2evolution will fail to work;') );
	}
	elseif( $memory_limit < 12288 )
	{
		disp_system_check( 'warining', T_('The memory_limit is low. Some features of b2evolution may fail to work;') );
	}
	else
	{
		disp_system_check( 'ok' );
	}
}


// mbstring extension
init_system_check( 'PHP mbstring extension', extension_loaded('mbstring') ?  T_('Loaded') : T_('Not loaded') );
if( ! extension_loaded('mbstring' ) )
{
	disp_system_check( 'warning', T_('b2evolution will not be able to convert character sets and special characters/languages may not be displayed correctly. Enable the mbstring extension in your php.ini file or ask your hosting provider about it.') );
}
else
{
	disp_system_check( 'ok' );
}


// XML extension
init_system_check( 'PHP XML extension', extension_loaded('xml') ?  T_('Loaded') : T_('Not loaded') );
if( ! extension_loaded('xml' ) )
{
	disp_system_check( 'warning', T_('The XML extension is not loaded.') ); // fp> This message only repeats the exact same info that is already displayed. Not helpful.
	// fp>TODO: explain what we need it for. Is it a problem or not.
	// furthermore I think xmlrpc does dynamic loading (or has it been removed?), in which case this should be tested too.
	// dh> You mean the deprecated dl() loading? (fp>yes) We might just try this then here also before any warning.
}
else
{
	disp_system_check( 'ok' );
}


// pre_dump( get_loaded_extensions() );

$block_item_Widget->disp_template_raw( 'block_end' );



/*
 * GD Library
 * windows: extension=php_gd2.dll
 * unix: ?
 * fp> Note: I'm going to use this for thumbnails for now, but I plan to use it for other things like small stats & status graphics.
 */
$block_item_Widget->title = T_('GD Library (image handling)');
$block_item_Widget->disp_template_replaced( 'block_start' );

$gd_version = system_check_gd_version();
init_system_check( 'GD Library version', isset($gd_version) ? $gd_version : T_('Not installed') );
if( ! isset($gd_version) )
{
	disp_system_check( 'warning', T_('You will not be able to automatically generate thumbnails for images. Enable the gd2 extension in your php.ini file or ask your hosting provider about it.') );
}
else
{
	disp_system_check( 'ok' );

	$gd_info = gd_info();

	// JPG:
	init_system_check( 'GD JPG Support', !empty($gd_info['JPG Support']) ? T_('Read/Write') : T_('No') );
	if( empty($gd_info['JPG Support']) )
	{
		disp_system_check( 'warning', T_('You will not be able to automatically generate thumbnails for JPG images.') );
	}
	else
	{
		disp_system_check( 'ok' );
	}

	// PNG:
	init_system_check( 'GD PNG Support', !empty($gd_info['JPG Support']) ? T_('Read/Write') : T_('No') );
	if( empty($gd_info['PNG Support']) )
	{
		disp_system_check( 'warning', T_('You will not be able to automatically generate thumbnails for PNG images.') );
	}
	else
	{
		disp_system_check( 'ok' );
	}

	// GIF:
	if( !empty($gd_info['GIF Create Support']) )
	{
		$gif_support = T_('Read/Write');
	}
	elseif( !empty($gd_info['GIF Read Support']) )
	{
		$gif_support = T_('Read');
	}
	else
	{
		$gif_support = T_('No');
	}
	init_system_check( 'GD GIF Support', $gif_support );
	if( $gif_support == T_('No') )
	{
		disp_system_check( 'warning', T_('You will not be able to automatically generate thumbnails for GIF images.') );
	}
	elseif( $gif_support == T_('Read') )
	{
		disp_system_check( 'warning', T_('Thumbnails for GIF images will be generated as PNG or JPG.') );
	}
	else
	{
		disp_system_check( 'ok' );
	}

	// pre_dump( $gd_info );
}
$block_item_Widget->disp_template_raw( 'block_end' );



// TODO: dh> memory_limit!
// TODO: dh> output_buffering (recommend off)
// TODO: dh> session.auto_start (recommend off)
// TODO: dh> How to change ini settings in .htaccess (for mod_php), link to manual
// fp> all good ideas :)
// fp> MySQL version
// TODO: dh> link to phpinfo()? It's included in the /install/ folder, but that is supposed to be deleted
// fp> we can just include it a second time as an 'action' here.
// TODO: dh> submit the report into a central database
// fp>yope, with a Globally unique identifier in order to avoid duplicates.

// pre_dump( ini_get_all() );


// End payload block:
$AdminUI->disp_payload_end();

// Display body bottom, debug info and close </html>:
$AdminUI->disp_global_footer();


?>
