<?php
/**
 * This file implements the Antispam poll Cron controller
 *
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _antispam_poll.job.php,v 1.1 2007/06/25 10:59:45 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


if( antispam_poll_abuse() )
{ // Success
	$job_ret = 1;
}
else
{	// Error
	$job_ret = 100;
}

global $Messages;
$result_message = $Messages->get_string( '', '', 'all', "\n" );

return $job_ret;


?>