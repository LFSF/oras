<?php
/**
 * This file implements the Archives plugin.
 *
 * Displays a list of post archives.
 *
 * This file is part of the b2evolution project - {@link http://b2evolution.net/}
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
 * @package plugins
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE - {@link http://fplanque.net/}
 * @author cafelog (group)
 *
 * @version $Id: _archives.plugin.php,v 1.46 2008/01/21 09:35:38 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );


load_funcs('_core/ui/results/_results.class.php');



/**
 * Archives Plugin
 *
 * This plugin displays
 */
class archives_plugin extends Plugin
{
	/**
	 * Variables below MUST be overriden by plugin implementations,
	 * either in the subclass declaration or in the subclass constructor.
	 */

	var $name = 'Archives Widget';
	var $code = 'evo_Arch';
	var $priority = 50;
	var $version = '2.2';
	var $author = 'The b2evo Group';
	var $group = 'widget';


	/**
	 * Init
	 */
	function PluginInit( & $params )
	{
		$this->short_desc = T_('This skin tag displays a list of post archives.');
		$this->long_desc = T_('Archives can be grouped monthly, daily, weekly or post by post.');

		$this->dbtable = 'T_items__item';
		$this->dbprefix = 'post_';
		$this->dbIDname = 'post_ID';
	}


	/**
	 * Event handler: SkinTag
	 *
	 * @param array Associative array of parameters. Valid keys are:
	 *                - 'block_start' : (Default: '<div class="bSideItem">')
	 *                - 'block_end' : (Default: '</div>')
	 *                - 'title' : (Default: T_('Archives'))
	 *                - 'mode' : 'monthly'|'daily'|'weekly'|'postbypost' (Default: conf.)
	 *                - 'sort_order' : 'date'|'title' (Default: date - used only if the mode is 'postbypost')
	 *                - 'link_type' : 'canonic'|'context' (default: canonic)
	 *                - 'context_isolation' : what params need override when changing date/range (Default: 'm,w,p,title,unit,dstart' )
	 *                - 'form' : true|false (default: false)
	 *                - 'limit' : # of archive entries to display or '' (Default: 12)
	 *                - 'more_link' : more link text (Default: 'More...')
	 *                - 'list_start' : (Default '<ul>')
	 *                - 'list_end' : (Default '</ul>')
	 *                - 'line_start' : (Default '<li>')
	 *                - 'line_end' : (Default '</li>')
	 *                - 'day_date_format' : (Default: conf.)
	 * @return boolean did we display?
	 */
	function SkinTag( $params )
	{
	 	global $month;

		/**
		 * @todo get rid of this global:
		 */
		global $m;

		/**
		 * @var Blog
		 */
		global $Blog;

		if( empty($Blog) )
		{
			return false;
		}

		/**
		 * Default params:
		 */
		// This is what will enclose the block in the skin:
		if(!isset($params['block_start'])) $params['block_start'] = '<div class="bSideItem">';
		if(!isset($params['block_end'])) $params['block_end'] = "</div>\n";

		// Title:
		if(!isset($params['block_title_start'])) $params['block_title_start'] = '<h3>';
		if(!isset($params['block_title_end'])) $params['block_title_end'] = '</h3>';
		if(!isset($params['title'])) $params['title'] = T_('Archives');

		// Archive mode:
		if(!isset($params['mode']))
			$params['mode'] = $Blog->get_setting('archive_mode');

		//Sort order (used only in postbypost mode):
		if($params['mode'] !='postbypost'){
			$params['sort_order'] = 'date';
		}
		elseif(!isset($params['sort_order']) || $params['sort_order'] == '') {
			$params['sort_order'] = 'date';
		}

		// Link type:
		if(!isset($params['link_type'])) $params['link_type'] = 'canonic';
		if(!isset($params['context_isolation'])) $params['context_isolation'] = 'm,w,p,title,unit,dstart';

		// Add form fields?:
		if(!isset($params['form']))
			$params['form'] = false;

		// Number of archive entries to display:
		if(!isset($params['limit'])) $params['limit'] = 12;

		// More link text:
		if(!isset($params['more_link'])) $params['more_link'] = T_('More...');

		// This is what will enclose the list:
		if(!isset($params['list_start'])) $params['list_start'] = '<ul>';
		if(!isset($params['list_end'])) $params['list_end'] = "</ul>\n";

		// This is what will separate the archive links:
		if(!isset($params['line_start'])) $params['line_start'] = '<li>';
		if(!isset($params['line_end'])) $params['line_end'] = "</li>\n";

		// Daily archive date format?
		if( (!isset($params['day_date_format'])) || ($params['day_date_format'] == '') )
		{
		 	$dateformat = locale_datefmt();
			$params['day_date_format'] = $dateformat;
		}

		$ArchiveList = & new ArchiveList( $params['mode'], $params['limit'], $params['sort_order'], ($params['link_type'] == 'context'),
																			$this->dbtable, $this->dbprefix, $this->dbIDname );

		echo $params['block_start'];

		if( !empty($params['title']) )
		{	// We want to display a title for the widget block:
			echo $params['block_title_start'];
			echo $params['title'];
			echo $params['block_title_end'];
		}

		echo $params['list_start'];
		while( $ArchiveList->get_item( $arc_year, $arc_month, $arc_dayofmonth, $arc_w, $arc_count, $post_ID, $post_title) )
		{
			echo $params['line_start'];
			switch( $params['mode'] )
			{
				case 'monthly':
					// --------------------------------- MONTHLY ARCHIVES -------------------------------------
					$arc_m = $arc_year.zeroise($arc_month,2);

					if( $params['form'] )
					{ // We want a radio button:
						echo '<input type="radio" name="m" value="'.$arc_m.'" class="checkbox"';
						if( $m == $arc_m ) echo ' checked="checked"' ;
						echo ' /> ';
					}

					$text = T_($month[zeroise($arc_month,2)]).' '.$arc_year;

					if( $params['link_type'] == 'context' )
					{	// We want to preserve current browsing context:
						echo '<a rel="nofollow" href="'.regenerate_url( $params['context_isolation'], 'm='.$arc_m ).'">'.$text.'</a>';
					}
					else
					{	// We want to link to the absolute canonical URL for this archive:
						echo $Blog->gen_archive_link( $text, T_('View monthly archive'), $arc_year, $arc_month );
					}

					echo ' <span class="dimmed">('.$arc_count.')</span>';
					break;

				case 'daily':
					// --------------------------------- DAILY ARCHIVES ---------------------------------------
					$arc_m = $arc_year.zeroise($arc_month,2).zeroise($arc_dayofmonth,2);

					if( $params['form'] )
					{ // We want a radio button:
						echo '<input type="radio" name="m" value="'. $arc_m. '" class="checkbox"';
						if( $m == $arc_m ) echo ' checked="checked"' ;
						echo ' /> ';
					}

					$text = mysql2date($params['day_date_format'], $arc_year.'-'.zeroise($arc_month,2).'-'.zeroise($arc_dayofmonth,2).' 00:00:00');

					if( $params['link_type'] == 'context' )
					{	// We want to preserve current browsing context:
						echo '<a rel="nofollow" href="'.regenerate_url( $params['context_isolation'], 'm='.$arc_m ).'">'.$text.'</a>';
					}
					else
					{	// We want to link to the absolute canonical URL for this archive:
						echo $Blog->gen_archive_link( $text, T_('View daily archive'), $arc_year, $arc_month, $arc_dayofmonth );
					}

					echo ' <span class="dimmed">('.$arc_count.')</span>';
					break;

				case 'weekly':
					// --------------------------------- WEEKLY ARCHIVES --------------------------------------

					$text = $arc_year.', '.T_('week').' '.$arc_w;

					if( $params['link_type'] == 'context' )
					{	// We want to preserve current browsing context:
						echo '<a rel="nofollow" href="'.regenerate_url( $params['context_isolation'], 'm='.$arc_year.'&amp;w='.$arc_w ).'">'.$text.'</a>';
					}
					else
					{	// We want to link to the absolute canonical URL for this archive:
						echo $Blog->gen_archive_link( $text, T_('View weekly archive'), $arc_year, NULL, NULL, $arc_w );
					}
					echo ' <span class="dimmed">('.$arc_count.')</span>';
					break;

				case 'postbypost':
				default:
					// -------------------------------- POST BY POST ARCHIVES ---------------------------------

					if( $post_title)
					{
						$text = strip_tags($post_title);
					}
					else
					{
						$text = $post_ID;
					}

					if( $params['link_type'] == 'context' )
					{	// We want to preserve current browsing context:
						echo '<a rel="nofollow" href="'.regenerate_url( $params['context_isolation'], 'p='.$post_ID ).'">'.$text.'</a>';
					}
					else
					{	// We want to link to the absolute (canonical) URL for this archive:
						// fp> TODO: This is NOT canonical. To go to the canonical, we'd need a 'light' itemlist (which does not load too much data)
						// fp> Note: there may be a "redirect to canonical" anyway. Not optimal, but at least this is less broken than it was before.
						// fp> THIS IS ALL OBSOLETE. There is a better way to have a post list with a specific widget.
						// TO BE DELETED (waiting for photoblog cleanup)
						echo '<a href="'.url_add_param( $Blog->get('url'), 'p='.$post_ID.'&amp;more=1&amp;c=1&amp;tb=1&amp;pb=1' ).'">'.$text.'</a>';
					}
			}

			echo $params['line_end'];
		}

		// Display more link:
		if( !empty($params['more_link']) )
		{
			echo $params['line_start'];
			echo '<a href="';
			$Blog->disp( 'arcdirurl', 'raw' );
			echo '">'.format_to_output($params['more_link']).'</a>';
			echo $params['line_end'];
		}

		echo $params['list_end'];

		echo $params['block_end'];

		return true;
	}
}


/**
 * Archive List Class
 *
 * @package evocore
 */
class ArchiveList extends Results
{
	var $archive_mode;
	var $arc_w_last;

	/**
	 * Constructor
	 *
	 * Note: Weekly archives use MySQL's week numbering and MySQL default if applicable.
	 * In MySQL < 4.0.14, WEEK() always uses mode 0: Week starts on Sunday;
	 * Value range is 0 to 53; week 1 is the first week that starts in this year.
	 *
	 * @link http://dev.mysql.com/doc/mysql/en/date-and-time-functions.html
	 *
	 * @todo categories combined with 'ALL' are not supported (will output too many archives,
	 * some of which will resolve to no results). We need subqueries to support this efficiently.
	 *
	 * @param string
	 * @param integer
	 * @param boolean
	 */
	function ArchiveList(
		$archive_mode = 'monthly',
		$limit = 100,
		$sort_order = 'date',
		$preserve_context = false,
		$dbtable = 'T_items__item',
		$dbprefix = 'post_',
		$dbIDname = 'ID' )
	{
		global $DB;
		global $blog, $cat, $catsel;
		global $show_statuses;
		global $author, $assgn, $status;
		global $timestamp_min, $timestamp_max;
		global $s, $sentence, $exact;

		$this->dbtable = $dbtable;
		$this->dbprefix = $dbprefix;
		$this->dbIDname = $dbIDname;
		$this->archive_mode = $archive_mode;


		/*
		 * WE ARE GOING TO CONSTRUCT THE WHERE CLOSE...
		 */
		$this->ItemQuery = & new ItemQuery( $this->dbtable, $this->dbprefix, $this->dbIDname ); // TEMPORARY OBJ

		// - - Select a specific Item:
		// $this->ItemQuery->where_ID( $p, $title );

		if( $preserve_context )
		{	// We want to preserve the current context:
			// * - - Restrict to selected blog/categories:
			$this->ItemQuery->where_chapter( $blog, $cat, $catsel );

			// * Restrict to the statuses we want to show:
			$this->ItemQuery->where_visibility( $show_statuses );

			// Restrict to selected authors:
			$this->ItemQuery->where_author( $author );

			// Restrict to selected assignees:
			$this->ItemQuery->where_assignees( $assgn );

			// Restrict to selected satuses:
			$this->ItemQuery->where_statuses( $status );

			// - - - + * * timestamp restrictions:
			$this->ItemQuery->where_datestart( '', '', '', '', $timestamp_min, $timestamp_max );

			// Keyword search stuff:
			$this->ItemQuery->where_keywords( $s, $sentence, $exact );
		}
		else
		{	// We want to preserve only the minimal context:
			// * - - Restrict to selected blog/categories:
			$this->ItemQuery->where_chapter( $blog, '', array() );

			// * Restrict to the statuses we want to show:
			$this->ItemQuery->where_visibility( $show_statuses );

			// - - - + * * timestamp restrictions:
			$this->ItemQuery->where_datestart( '', '', '', '', $timestamp_min, $timestamp_max );
		}


		$this->from = $this->ItemQuery->get_from();
		$this->where = $this->ItemQuery->get_where();
		$this->group_by = $this->ItemQuery->get_group_by();

		switch( $this->archive_mode )
		{
			case 'monthly':
				// ------------------------------ MONTHLY ARCHIVES ------------------------------------
				$sql = 'SELECT EXTRACT(YEAR FROM '.$this->dbprefix.'datestart) AS year, EXTRACT(MONTH FROM '.$this->dbprefix.'datestart) AS month,
																	COUNT(DISTINCT postcat_post_ID) AS count '
													.$this->from
													.$this->where.'
													GROUP BY year, month
													ORDER BY year DESC, month DESC';
				break;

			case 'daily':
				// ------------------------------- DAILY ARCHIVES -------------------------------------
				$sql = 'SELECT EXTRACT(YEAR FROM '.$this->dbprefix.'datestart) AS year, MONTH('.$this->dbprefix.'datestart) AS month,
																	DAYOFMONTH('.$this->dbprefix.'datestart) AS day,
																	COUNT(DISTINCT postcat_post_ID) AS count '
													.$this->from
													.$this->where.'
													GROUP BY year, month, day
													ORDER BY year DESC, month DESC, day DESC';
				break;

			case 'weekly':
				// ------------------------------- WEEKLY ARCHIVES -------------------------------------
				$sql = 'SELECT EXTRACT(YEAR FROM '.$this->dbprefix.'datestart) AS year, '.
															$DB->week( $this->dbprefix.'datestart', locale_startofweek() ).' AS week,
															COUNT(DISTINCT postcat_post_ID) AS count '
													.$this->from
													.$this->where.'
													GROUP BY year, week
													ORDER BY year DESC, week DESC';
				break;

			case 'postbypost':
			default:
				// ----------------------------- POSY BY POST ARCHIVES --------------------------------
				$sql = 'SELECT DISTINCT '.$this->dbIDname.', '.$this->dbprefix.'datestart, '.$this->dbprefix.'title '
													.$this->from
													.$this->where
													.$this->group_by.'
													ORDER BY ';
				if($sort_order == 'title'){
					$sql .= $this->dbprefix.'title ASC';
				}
				else if($sort_order == 'date'){
					$sql .= $this->dbprefix.'datestart DESC';
				}
		}


		// dh> Temp fix for MySQL bug - apparently in/around 4.1.21/5.0.24.
		// See http://forums.b2evolution.net/viewtopic.php?p=42529#42529
		if( in_array($this->archive_mode, array('monthly', 'daily', 'weekly')) )
		{
			$sql_version = $DB->get_var('SELECT VERSION()'); // fp> TODO: $DB->get_mysql_version()
			if( version_compare($sql_version, '4', '>') )
			{
				$sql = 'SELECT SQL_CALC_FOUND_ROWS '.substr( $sql, 7 ); // "SQL_CALC_FOUND_ROWS" available since MySQL 4
			}
		}


		parent::Results( $sql, 'archivelist_', '', $limit );

		$this->restart();
	}


	/**
	 * Count the number of rows of the SQL result
	 *
	 * These queries are complex enough for us not to have to rewrite them:
	 * dh> ???
	 */
	function count_total_rows()
	{
		global $DB;

		switch( $this->archive_mode )
		{
			case 'monthly':
				// ------------------------------ MONTHLY ARCHIVES ------------------------------------
				$sql_count = 'SELECT COUNT( DISTINCT EXTRACT(YEAR FROM '.$this->dbprefix.'datestart), EXTRACT(MONTH FROM '.$this->dbprefix.'datestart) ) '
													.$this->from
													.$this->where;
				break;

			case 'daily':
				// ------------------------------- DAILY ARCHIVES -------------------------------------
				$sql_count = 'SELECT COUNT( DISTINCT EXTRACT(YEAR FROM '.$this->dbprefix.'datestart), EXTRACT(MONTH FROM '.$this->dbprefix.'datestart),
																	EXTRACT(DAY FROM '.$this->dbprefix.'datestart) ) '
													.$this->from
													.$this->where;
				break;

			case 'weekly':
				// ------------------------------- WEEKLY ARCHIVES -------------------------------------
				$sql_count = 'SELECT COUNT( DISTINCT EXTRACT(YEAR FROM '.$this->dbprefix.'datestart), '
													.$DB->week( $this->dbprefix.'datestart', locale_startofweek() ).' ) '
													.$this->from
													.$this->where;
				break;

			case 'postbypost':
			default:
				// ----------------------------- POSY BY POST ARCHIVES --------------------------------
				$sql_count = 'SELECT COUNT( DISTINCT '.$this->dbIDname.' ) '
													.$this->from
													.$this->where
													.$this->group_by;
		}

		// echo $sql_count;

		$this->total_rows = $DB->get_var( $sql_count ); //count total rows

		// echo 'total rows='.$this->total_rows;
	}


	/**
	 * Rewind resultset
	 */
	function restart()
	{
		// Make sure query has executed at least once:
		$this->query();

		$this->current_idx = 0;
		$this->arc_w_last = '';
	}

	/**
	 * Getting next item in archive list
	 *
	 * WARNING: these are *NOT* Item objects!
	 */
	function get_item( & $arc_year, & $arc_month, & $arc_dayofmonth, & $arc_w, & $arc_count, & $post_ID, & $post_title )
	{
		// echo 'getting next item<br />';

		if( $this->current_idx >= $this->result_num_rows )
		{	// No more entry
			return false;
		}

		$arc_row = $this->rows[ $this->current_idx++ ];

		switch( $this->archive_mode )
		{
			case 'monthly':
				$arc_year  = $arc_row->year;
				$arc_month = $arc_row->month;
				$arc_count = $arc_row->count;
				return true;

			case 'daily':
				$arc_year  = $arc_row->year;
				$arc_month = $arc_row->month;
				$arc_dayofmonth = $arc_row->day;
				$arc_count = $arc_row->count;
				return true;

			case 'weekly':
				$arc_year  = $arc_row->year;
				$arc_w = $arc_row->week;
				$arc_count = $arc_row->count;
				return true;

			case 'postbypost':
			default:
				$post_ID = $arc_row->post_ID;
				$post_title = $arc_row->{$this->dbprefix.'title'};
				return true;
		}
	}
}





?>