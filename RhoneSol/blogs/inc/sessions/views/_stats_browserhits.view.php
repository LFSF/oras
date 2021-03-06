<?php
/**
 * This file implements the UI view for the browser hits summary.
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
 * @package admin
 *
 * @version $Id: _stats_browserhits.view.php,v 1.5.2.2 2008/02/14 05:47:22 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

global $blog, $admin_url, $AdminUI;


echo '<h2>'.T_('Browser hits summary').'</h2>';


echo '<p class="notes">'.sprintf( T_('This page only includes hits identified as made by a <a %s>web browser</a>.'), ' href="?ctrl=stats&amp;tab=useragents&amp;agnt_browser=1&amp;blog='.$blog.'"' ).'</p>';


// fplanque>> I don't get it, it seems that GROUP BY on the referer type ENUM fails pathetically!!
// Bug report: http://lists.mysql.com/bugs/36
// Solution : CAST to string
// waltercruz >> MySQL sorts ENUM columns according to the order in which the enumeration
// members were listed in the column specification, not the lexical order. Solution: CAST to string using using CONCAT
// or CAST (but CAST only works from MySQL 4.0.2)
// References:
// http://dev.mysql.com/doc/refman/5.0/en/enum.html
// http://dev.mysql.com/doc/refman/4.1/en/cast-functions.html
// TODO: I've also limited this to agnt_type "browser" here, according to the change for "referers" (Rev 1.6)
//       -> an RSS service that sends a referer is not a real referer (though it should be listed in the robots list)! (blueyed)
$sql = '
	SELECT COUNT(*) AS hits, CONCAT(hit_referer_type) AS referer_type, EXTRACT(YEAR FROM hit_datetime) AS year,
			   EXTRACT(MONTH FROM hit_datetime) AS month, EXTRACT(DAY FROM hit_datetime) AS day
		FROM T_hitlog INNER JOIN T_useragents ON hit_agnt_ID = agnt_ID
	 WHERE agnt_type = "browser"';
if( $blog > 0 )
{
	$sql .= ' AND hit_blog_ID = '.$blog;
}
$sql .= ' GROUP BY year, month, day, referer_type
					ORDER BY year DESC, month DESC, day DESC, referer_type';
$res_hits = $DB->get_results( $sql, ARRAY_A, 'Get hit summary' );


/*
 * Chart
 */
if( count($res_hits) )
{
	$last_date = 0;

	$col_mapping = array(
			'search' => 1,
			'referer' => 2,
			'direct' => 3,
			'self' => 4,
			'blacklist' => 5,
			'spam' => 6,
			'admin' => 7,
		);

	$chart[ 'chart_data' ][ 0 ] = array();
	$chart[ 'chart_data' ][ 1 ] = array();
	$chart[ 'chart_data' ][ 2 ] = array();
	$chart[ 'chart_data' ][ 3 ] = array();
	$chart[ 'chart_data' ][ 4 ] = array();
	$chart[ 'chart_data' ][ 5 ] = array();
	$chart[ 'chart_data' ][ 6 ] = array();
	$chart[ 'chart_data' ][ 7 ] = array();

	$count = 0;
	foreach( $res_hits as $row_stats )
	{
		$this_date = mktime( 0, 0, 0, $row_stats['month'], $row_stats['day'], $row_stats['year'] );
		if( $last_date != $this_date )
		{ // We just hit a new day, let's display the previous one:
				$last_date = $this_date;	// that'll be the next one
				$count ++;
				array_unshift( $chart[ 'chart_data' ][ 0 ], date( locale_datefmt(), $last_date ) );
				array_unshift( $chart[ 'chart_data' ][ 1 ], 0 );
				array_unshift( $chart[ 'chart_data' ][ 2 ], 0 );
				array_unshift( $chart[ 'chart_data' ][ 3 ], 0 );
				array_unshift( $chart[ 'chart_data' ][ 4 ], 0 );
				array_unshift( $chart[ 'chart_data' ][ 5 ], 0 );
				array_unshift( $chart[ 'chart_data' ][ 6 ], 0 );
				array_unshift( $chart[ 'chart_data' ][ 7 ], 0 );
		}
		$col = $col_mapping[$row_stats['referer_type']];
		$chart [ 'chart_data' ][$col][0] = $row_stats['hits'];
	}

	array_unshift( $chart[ 'chart_data' ][ 0 ], '' );
	array_unshift( $chart[ 'chart_data' ][ 1 ], 'Refering searches' );
	array_unshift( $chart[ 'chart_data' ][ 2 ], 'Referers' );
	array_unshift( $chart[ 'chart_data' ][ 3 ], 'Direct accesses' );	// Translations need to be UTF-8
	array_unshift( $chart[ 'chart_data' ][ 4 ], 'Self referred' );
	array_unshift( $chart[ 'chart_data' ][ 5 ], 'Special referrers' );
	array_unshift( $chart[ 'chart_data' ][ 6 ], 'Referer spam' );
	array_unshift( $chart[ 'chart_data' ][ 7 ], 'Admin' );

	// Include common chart properties:
	require dirname(__FILE__).'/inc/_bar_chart.inc.php';

	$chart[ 'series_color' ] = array (
			'0099ff',
			'00ccff',
			'00ffcc',
			'00ff99',

			'ff00ff',
			'ff0000',

			'999999',
		);

	echo '<div class="center">';
	DrawChart( $chart );
	echo '</div>';


	/*
	 * Table:
	 */
	$hits = array(
		'direct' => 0,
		'referer' => 0,
		'search' => 0,
		'self' => 0,
		'blacklist' => 0,
		'spam' => 0,
		'admin' => 0,
	);
	$hits_total = $hits;

	$last_date = 0;

	?>

	<table class="grouped" cellspacing="0">
		<tr>
			<th class="firstcol"><?php echo T_('Date') ?></th>
			<th style="background-color: #0099ff"><?php echo T_('Refering searches') ?></th>
			<th style="background-color: #00ccff"><?php echo T_('Referers') ?></th>
			<th style="background-color: #00ffcc"><?php echo T_('Direct accesses') ?></th>
			<th style="background-color: #00ff99"><?php echo T_('Self referred') ?></th>
			<th style="background-color: #ff00ff"><?php	echo T_('Special referrers') ?></th>
			<th style="background-color: #ff0000"><?php echo T_('Referer spam') ?></th>
			<th style="background-color: #999999"><?php echo T_('Admin') ?></th>
			<th class="lastcol"><?php echo T_('Total') ?></th>
		</tr>
		<?php
		$count = 0;
		foreach( $res_hits as $row_stats )
		{
			$this_date = mktime( 0, 0, 0, $row_stats['month'], $row_stats['day'], $row_stats['year'] );
			if( $last_date == 0 ) $last_date = $this_date;	// that'll be the first one
			if( $last_date != $this_date )
			{ // We just hit a new day, let's display the previous one:
				?>
				<tr class="<?php echo ( $count%2 == 1 ) ? 'odd' : 'even'; ?>">
					<td class="firstcol"><?php if( $current_User->check_perm( 'stats', 'edit' ) )
						{
							echo action_icon( T_('Prune hits for this date!'), 'delete', url_add_param( $admin_url, 'ctrl=stats&amp;action=prune&amp;date='.$last_date.'&amp;show=summary&amp;blog='.$blog ) );
						}
						echo date( locale_datefmt(), $last_date ) ?>
					</td>
					<td class="right"><?php echo $hits['search'] ?></td>
					<td class="right"><?php echo $hits['referer'] ?></td>
					<td class="right"><?php echo $hits['direct'] ?></td>
					<td class="right"><?php echo $hits['self'] ?></td>
					<td class="right"><?php echo $hits['blacklist'] ?></td>
					<td class="right"><?php echo $hits['spam'] ?></td>
					<td class="right"><?php echo $hits['admin'] ?></td>
					<td class="lastcol right"><?php echo array_sum($hits) ?></td>
				</tr>
				<?php
					$hits = array(
						'direct' => 0,
						'referer' => 0,
						'search' => 0,
						'self' => 0,
						'blacklist' => 0,
						'spam' => 0,
						'admin' => 0,
					);
					$last_date = $this_date;	// that'll be the next one
					$count ++;
			}

			// Increment hitcounter:
			$hits[$row_stats['referer_type']] = $row_stats['hits'];
			$hits_total[$row_stats['referer_type']] += $row_stats['hits'];
		}

		if( $last_date != 0 )
		{ // We had a day pending:
			?>
				<tr class="<?php echo ( $count%2 == 1 ) ? 'odd' : 'even'; ?>">
				<td class="firstcol"><?php if( $current_User->check_perm( 'stats', 'edit' ) )
					{
						echo action_icon( T_('Prune hits for this date!'), 'delete', url_add_param( $admin_url, 'ctrl=stats&amp;action=prune&amp;date='.$last_date.'&amp;show=summary&amp;blog='.$blog ) );
					}
					echo date( locale_datefmt(), $this_date ) ?>
				</td>
				<td class="right"><?php echo $hits['search'] ?></td>
				<td class="right"><?php echo $hits['referer'] ?></td>
				<td class="right"><?php echo $hits['direct'] ?></td>
				<td class="right"><?php echo $hits['self'] ?></td>
				<td class="right"><?php echo $hits['blacklist'] ?></td>
				<td class="right"><?php echo $hits['spam'] ?></td>
				<td class="right"><?php echo $hits['admin'] ?></td>
				<td class="lastcol right"><?php echo array_sum($hits) ?></td>
			</tr>
			<?php
		}

		// Total numbers:
		?>

		<tr class="total">
		<td class="firstcol"><?php echo T_('Total') ?></td>
		<td class="right"><?php echo $hits_total['search'] ?></td>
		<td class="right"><?php echo $hits_total['referer'] ?></td>
		<td class="right"><?php echo $hits_total['direct'] ?></td>
		<td class="right"><?php echo $hits_total['self'] ?></td>
		<td class="right"><?php echo $hits_total['blacklist'] ?></td>
		<td class="right"><?php echo $hits_total['spam'] ?></td>
		<td class="right"><?php echo $hits_total['admin'] ?></td>
		<td class="lastcol right"><?php echo array_sum($hits_total) ?></td>
		</tr>

	</table>

	<img src="<?php global $rsc_url; echo $rsc_url ?>img/blank.gif" width="1" height="1" /><!-- for IE -->
	<?php
}


?>