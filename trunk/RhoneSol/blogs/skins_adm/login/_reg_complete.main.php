<?php
/**
 * This is displayed when registration is complete
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


/**
 * Include page header:
 */
$page_title = T_('Registration complete');
$page_icon = 'icon_register.gif';
require dirname(__FILE__).'/_html_header.inc.php';

// dh> TODO: this form is not really required and only used for the info fields below.
$Form =& new Form( $htsrv_url_sensitive.'login.php', 'login', 'post', 'fieldset' );

$Form->begin_form( 'fform' );

$Form->hidden( 'login', $login );
$Form->hidden( 'redirect_to', url_rel_to_same_host($redirect_to, $htsrv_url_sensitive) );

$Form->begin_fieldset();
$Form->info( T_('Login'), $login );
$Form->info( T_('Email'), $email );
$Form->end_fieldset();

// Now the user has been logged in automatically at the end of the registration progress.
// Allow him to proceed or go to the blogs, though he will see the "validate account" screen then,
// if he has not clicked the validation link yet and validation is required.
if( empty($redirect_to) )
{
	$redirect_to = $baseurl; // dh> this was the old behaviour, I think there could be a better default
}
echo '<p class="center"><a href="'
	.htmlspecialchars(url_rel_to_same_host($redirect_to, $htsrv_url_sensitive))
	.'">'.T_('Continue').' &raquo;</a> '; // dh> TODO: this does not seem to be sensible for dir=rtl.
echo '</p>';


$Form->end_form();

require dirname(__FILE__).'/_html_footer.inc.php';


?>