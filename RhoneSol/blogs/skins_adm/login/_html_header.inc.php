<?php
/**
 * This is the header file for login/registering services
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
 * @package htsrv
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

header( 'Content-type: text/html; charset='.$io_charset );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php locale_lang() ?>" lang="<?php locale_lang() ?>">
<head>
	<title><?php echo $app_shortname.' &rsaquo; '.$page_title ?></title>
	<meta name="ROBOTS" content="NOINDEX" />
	<meta name="viewport" content="width = 600" />
	<link href="<?php echo $rsc_url ?>css/login.css" rel="stylesheet" type="text/css" />
	<?php include_headlines() /* Add javascript and css files included by plugins and skin */ ?>
</head>
<body>


<div class="loginblock">

<div style="float:left">
	<h1 class="logintitle"><?php echo $app_banner; ?></h1>
</div>

<?php if( isset($page_icon) ) { ?>
<img src="<?php echo $rsc_url.'icons/'.$page_icon ?>" width="24" height="24" style="float:right;" alt="" />
<?php } ?>
<div style="float:right">
<h2 class="logintitle"><?php echo $page_title ?></h2>
</div>

<div class="clear"></div>

<?php
$Messages->display( '', '', true, 'all', array( 'login_error' => array( 'class' => 'log_error' ) ) );


?>