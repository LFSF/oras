<?php
/**
 * This page displays an error message if the user is denied access to the admin section
 *
 * @package evocore
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

header('HTTP/1.0 403 Forbidden');
header( 'Content-type: text/html; charset='.$io_charset );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><?php echo T_('Access denied') ?></title>
	</head>
<body>
	<div style="background-color:#fee; border: 1px solid red; text-align:center;">
		<h1><?php echo T_('Access denied') ?></h1>
		<p><?php echo T_('Sorry, you have no permission to access this section.') ?></p>
	</div>
	<p style="text-align:center;"><?php
		echo '<a href="'.$htsrv_url_sensitive.'login.php?action=logout&amp;redirect_to='.rawurlencode(url_rel_to_same_host($ReqHost.$ReqURI, $htsrv_url_sensitive)).'">'.T_('Logout').'</a>
					&bull;
					<a href="'.$baseurl.'">'.T_('Exit to blogs').'</a>';
	?></p>
	<?php debug_info(); ?>
</body>
</html>
<?php
	exit;
?>