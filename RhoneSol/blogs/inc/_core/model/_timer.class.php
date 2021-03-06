<?php
/**
 * This file implements the Timer class.
 *
 * This file is part of the evoCore framework - {@link http://evocore.net/}
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 * Parts of this file are copyright (c)2004-2006 by Daniel HAHLER - {@link http://thequod.de/contact}.
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
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 * @author blueyed: Daniel HAHLER.
 *
 * @version $Id: _timer.class.php,v 1.2 2008/01/21 09:35:24 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * This is a simple class to allow timing/profiling of code portions.
 */
class Timer
{
	/**
	 * Remember times.
	 *
	 * We store for each category (primary key) the state, start/resume time and the total passed time.
	 *
	 * @access protected
	 */
	var $_times = array();


	/**
	 * Constructor.
	 *
	 * @param string|NULL If a category is given the timer starts right away.
	 */
	function Timer( $category = NULL )
	{
		if( is_string($category) )
		{
			$this->start( $category );
		}
	}


	/**
	 * Reset a timer category.
	 */
	function reset( $category )
	{
		$this->_times[$category] = array( 'total' => 0, 'count' => 0 );
	}


	/**
	 * Start a timer.
	 */
	function start( $category, $log = true )
	{
		global $Debuglog;
		if( $log && is_object( $Debuglog ) ) $Debuglog->add( 'Starting timer '.$category, 'timer' );
		$this->reset( $category );
		$this->resume( $category );
	}


	/**
	 * Stops a timer category. It may me resumed later on, see {@link resume()}. This is an alias for {@link pause()}.
	 *
	 * @return boolean false, if the timer had not been started.
	 */
	function stop( $category )
	{
		global $Debuglog;

		if( ! $this->pause( $category ) )
			return false;

		if( is_object( $Debuglog ) )
		{
			$Debuglog->add( 'Stopped timer '.$category.' at '.$this->get_duration( $category, 3 ), 'timer' );
		}

		return true;
	}


	/**
	 * Pauses a timer category. It may me resumed later on, see {@link resume()}.
	 *
	 * NOTE: The timer needs to be started, either through the {@link Timer() Constructor} or the {@link start()} method.
	 *
	 * @return boolean false, if the timer had not been started.
	 */
	function pause( $category )
	{
		if( !isset($this->_times[$category]['resumed']) )
		{ // Timer has not been started!
			return false;
		}
		$since_resume = $this->get_current_microtime() - $this->_times[$category]['resumed'];
		$this->_times[$category]['total'] += $since_resume;
		$this->_times[$category]['state'] = 'paused';

		return true;
	}


	/**
	 * Resumes the timer on a category.
	 */
	function resume( $category )
	{
		if( !isset($this->_times[$category]['total']) )
		{
			$this->start($category);
		}
		else
		{
			$this->_times[$category]['resumed'] = $this->get_current_microtime();
			$this->_times[$category]['count']++;

			$this->_times[$category]['state'] = 'running';
		}
	}


	/**
	 * Get the duration for a given category.
	 *
	 * @param string Category name
	 * @param integer Number of decimals after dot.
	 * @return string
	 */
	function get_duration( $category, $decimals = 3 )
	{
		return number_format( $this->get_microtime($category), $decimals ); // TODO: decimals/seperator by locale!
	}


	/**
	 * Get number of timer resumes (includes start).
	 *
	 * @return integer
	 */
	function get_count( $category )
	{
		if( isset( $this->_times[$category] ) )
		{
			return $this->_times[$category]['count'];
		}

		return false;
	}


	/**
	 * Get the time in microseconds that was spent in the given category.
	 *
	 * @return float
	 */
	function get_microtime( $category )
	{
		switch( $this->get_state($category) )
		{
			case 'running':
				// The timer is running, we need to return the additional time since the last resume.
				return $this->_times[$category]['total']
					+ $this->get_current_microtime() - $this->_times[$category]['resumed'];

			case 'paused':
				return $this->_times[$category]['total'];

			default:
				return (float)0;
		}
	}


	/**
	 * Get the state a category timer is in.
	 *
	 * @return string 'unknown', 'not initialised', 'running', 'paused'
	 */
	function get_state( $category )
	{
		if( !isset($this->_times[$category]) )
		{
			return 'unknown';
		}

		if( !isset($this->_times[$category]['state']) )
		{
			return 'not initialised';
		}

		return $this->_times[$category]['state'];
	}


	/**
	 * Get a list of used categories.
	 *
	 * @return array
	 */
	function get_categories()
	{
		return array_keys( $this->_times );
	}


	/**
	 * Get the current time in microseconds.
	 *
	 * @return float
	 */
	function get_current_microtime()
	{
		list($usec, $sec) = explode(' ', microtime());
		return ((float)$usec + (float)$sec);
	}
}


?>