<?php
/**
 * This is b2evolution's basic config file.
 *
 * You need to edit this file to your settings before attempting to install the database!
 * Last significant changes to this file: version 1.6
 *
 *
 * Reminder: every line starting with # or // is a comment, multiline comments are
 *           surrounded by '/*' and '* /' (without space).
 *
 * IMPORTANT: Take special care not to erase quotes (') around text parameters
 * and semicolums (;) at the end of the lines. Otherwise you'll get some
 * "unexpected T_STRING" parse errors!
 *
 * Contributors: you should override this file by creating a file named _config_TEST.php
 * (see end of this file).
 *
 * @package conf
 */
if( !defined('EVO_CONFIG_LOADED') ) die( 'Please, do not access this page directly.' );


// TODO: dh> this file was meant to be used for things where you only need the basic config..
// fp> also:
// - At least _admin.php should only be called when in the backoffice.
// - Also we should probably start by moving as many conf options to the backoffice as possible and see how much stuff is left in conf files
//    Note: some stuff does not make sense in the back-office (for example stuff that depends on the physical path where the files are installed)
// - In view of reorganization, please list (all or examples) of situations where only a subset of the conf should be loaded.


/**
 * Maintenance mode. Set this to 1 in order to temporarily disable access to the application.
 *
 * Note: it is still possible to access the install script during maintenance mode.
 */
$maintenance_mode = 0;


// Below is an alternative hardcore version of maintenance mode.
// This one will block the install script too.
// Remove /* and */ to activate.
/*
header('HTTP/1.0 503 Service Unavailable');
echo '<h1>503 Service Unavailable</h1>';
die( 'The site is temporarily down for maintenance.' );
*/


/**
 * MySQL DB settings.
 * Fill in your database details (check carefully or nothing will work!)
 */
$db_config = array(
	'user'     => 'rhoneblog',     // your MySQL username
	'password' => '24031967',     // ...and password
	'name'     => 'wordblog',  // the name of the database
	'host'     => 'localhost',    // MySQL Server (typically 'localhost')
);


/**
 * the tables prefix (gets placed before each b2evo table name),
 * use this to have multiple installations in one DB.
 *
 * @global string $tableprefix
 */
$tableprefix = 'e_';


/**
 * If you want to be able to reset your existing b2evolution tables and start anew
 * you must set $allow_evodb_reset to 1.
 *
 * NEVER LEAVE THIS SETTING ON ANYTHING ELSE THAN 0 (ZERO) ON A PRODUCTION SERVER.
 * IF THIS IS ON (1) AND YOU FORGET TO DELETE THE INSTALL FOLDER, ANYONE WOULD BE ABLE TO
 * ERASE YOUR B2EVOLUTION TABLES AND DATA BY A SINGLE CLICK!
 */
$allow_evodb_reset = 0;	// Set to 1 to enable. Do not leave this on 1 on production servers


/**
 * $baseurl is where your blogs reside by default. CHECK THIS CAREFULLY or nothing will work.
 * It should be set to the URL where you can find the blog templates and/or the blog stub files,
 * that means index.php, blog_b.php, etc.
 * Note: Blogs can be in subdirectories of the baseurl. However, no blog should be outside
 * of there, or some tricky things may fail (e-g: pingback)
 *
 * IMPORTANT: If you want to test b2evolution on your local machine, do NOT use that machine's
 * name in the $baseurl!
 * For example, if your machine is called HOMER, do not use http://homer/b2evolution/blogs/ !
 * Use http://localhost/b2evolution/blogs/ instead. And log in on localhost too, not homer!
 * If you don't, login cookies will not hold.
 *
 * @global string $baseurl
 */
$baseurl = 'http://rhone-solidarite.com/blogs/';
// Use the following if you want to use the current domain:
/*
if( isset($_SERVER['HTTP_HOST']) )
{	// This only works if HOSt provided by webserver (i-e DOES NOT WORK IN PHP CLI MODE)
	$baseurl = ( (isset($_SERVER['HTTPS']) && ( $_SERVER['HTTPS'] != 'off' ) ) ?'https://':'http://')
							.$_SERVER['HTTP_HOST'].'/';
}
*/

/**
 * This is used only to create the Admin account.
 * @todo move to installer.
 */
$admin_email = 'ozounguet@msn.fr';


/**
 * Once you have edited this file to your settings, set the following to 1 (one):
 */
$config_is_done = 1;


# IMPORTANT: you will find more parameters in the other files of the /conf folder.
# IT IS RECOMMENDED YOU DO NOT TOUCH THOSE SETTINGS
# UNTIL YOU ARE FAMILIAR WITH THE DEFAULT INSTALLATION.
#
# It is however strongly recommended you browse through these files as soon as you've
# got your basic installation working. They'll let you customize a lot of things!
?>
