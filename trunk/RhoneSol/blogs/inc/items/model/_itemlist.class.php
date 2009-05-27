<?php
/**
 * This file implements the ItemList class 2.
 *
 * This is the object handling item/post/article lists.
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
 * @package evocore
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _itemlist.class.php,v 1.7 2008/02/08 22:24:46 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('/items/model/_itemlistlight.class.php');


/**
 * Item List Class 2
 *
 * This SECOND implementation will deprecate the first one when finished.
 *
 * @package evocore
 */
class ItemList2 extends ItemListLight
{
  /**
	 * @var array
	 */
	var $prevnext_Item = array();

	/**
	 * Constructor
	 *
	 * @todo  add param for saved session filter set
	 *
	 * @param Blog
	 * @param mixed Default filter set: Do not show posts before this timestamp, can be 'now'
	 * @param mixed Default filter set: Do not show posts after this timestamp, can be 'now'
	 * @param integer|NULL Limit
	 * @param string name of cache to be used
	 * @param string prefix to differentiate page/order params when multiple Results appear one same page
	 * @param array restrictions for itemlist (position, contact, firm, ...) key: restriction name, value: ID of the restriction
	 */
	function ItemList2(
			& $Blog,
			$timestamp_min = NULL,       // Do not show posts before this timestamp
			$timestamp_max = NULL,   		 // Do not show posts after this timestamp
			$limit = 20,
			$cache_name = 'ItemCache',	 // name of cache to be used
			$param_prefix = '',
			$filterset_name = '',				// Name to be used when saving the filterset (leave empty to use default for collection)
			$restrict_to = array()			// Restrict the item list to a position, or contact, firm..... /* not used yet(?) */
		)
	{
		global $Settings;

		// Call parent constructor:
		parent::ItemListLight( $Blog, $timestamp_min, $timestamp_max, $limit, $cache_name, $param_prefix, $filterset_name, $restrict_to );
	}


	/**
	 * We want to preview a single post, we are going to fake a lot of things...
	 */
	function preview_from_request()
	{
		global $current_User;

		if( empty($current_User) )
		{ // dh> only logged in user's can preview. Alternatively we need those checks where $current_User gets used below.
			return;
		}

		global $DB, $localtimenow, $Messages, $BlogCache;
		global $Plugins;

		$preview_userid = param( 'preview_userid', 'integer', true );
		$post_status = param( 'post_status', 'string', true );
		$post_locale = param( 'post_locale', 'string', $current_User->locale );
		$content = param( 'content', 'html', true );
		$post_title = param( 'post_title', 'html', true );
		$post_excerpt = param( 'post_excerpt', 'string', true );
		$post_url = param( 'post_url', 'string', '' );
		$post_category = param( 'post_category', 'integer', true );
		$post_views = param( 'post_views', 'integer', 0 );
		$renderers = param( 'renderers', 'array', array('default') );
		if( ! is_array($renderers) )
		{ // dh> workaround for param() bug. See rev 1.93 of /inc/_misc/_misc.funcs.php
			$renderers = array('default');
		}
		$comment_Blog = & $BlogCache->get_by_ID( get_catblog( $post_category ) );
		if( $comment_Blog->allowcomments == 'post_by_post' )
		{ // param is required
			$post_comment_status = param( 'post_comment_status', 'string', true );
		}
		else
		{
			$post_comment_status = $comment_Blog->allowcomments;
		}


		// Get issue date, using the user's locale (because it's entered like this in the form):
		locale_temp_switch( $current_User->locale );

		param_date( 'item_issue_date', T_('Please enter a valid issue date.'), false );
		// TODO: dh> get_param() is always true here, also on invalid dates:
		if( strlen(get_param('item_issue_date')) )
		{ // only set it, if a date was given:
			param_time( 'item_issue_time' );
			$item_issue_date = form_date( get_param( 'item_issue_date' ), get_param( 'item_issue_time' ) ); // TODO: cleanup...
		}
		else
		{
			$item_issue_date = date( 'Y-m-d H:i:s', $localtimenow );
		}
		locale_restore_previous();


		if( !($item_typ_ID = param( 'item_typ_ID', 'integer', NULL )) )
			$item_typ_ID = NULL;
		if( !($item_st_ID = param( 'item_st_ID', 'integer', NULL )) )
			$item_st_ID = NULL;
		if( !($item_assigned_user_ID = param( 'item_assigned_user_ID', 'integer', NULL )) )
			$item_assigned_user_ID = NULL;
		if( !($item_deadline = param( 'item_deadline', 'string', NULL )) )
			$item_deadline = NULL;
		$item_priority = param( 'item_priority', 'integer', NULL ); // QUESTION: can this be also empty/NULL?

		// Do some optional filtering on the content
		// Typically stuff that will help the content to validate
		// Useful for code display.
		// Will probably be used for validation also.
		$Plugins_admin = & get_Cache('Plugins_admin');
		$Plugins_admin->filter_contents( $post_title /* by ref */, $content /* by ref */, $renderers );

		$post_title = format_to_post( $post_title );
		$content = format_to_post( $content );

		$this->sql = "SELECT
			0 AS post_ID,
			$preview_userid AS post_creator_user_ID,
			$preview_userid AS post_lastedit_user_ID,
			'$item_issue_date' AS post_datestart,
			'$item_issue_date' AS post_datecreated,
			'$item_issue_date' AS post_datemodified,
			'".$DB->escape($post_status)."' AS post_status,
			'".$DB->escape($post_locale)."' AS post_locale,
			'".$DB->escape($content)."' AS post_content,
			'".$DB->escape($post_title)."' AS post_title,
			'".$DB->escape($post_excerpt)."' AS post_excerpt,
			NULL AS post_urltitle,
			'".$DB->escape($post_url)."' AS post_url,
			$post_category AS post_main_cat_ID,
			$post_views AS post_views,
			'' AS post_flags,
			'noreq' AS post_notifications_status,
			NULL AS post_notifications_ctsk_ID,
			".bpost_count_words( $content )." AS post_wordcount,
			".$DB->quote($post_comment_status)." AS post_comment_status,
			'".$DB->escape( implode( '.', $renderers ) )."' AS post_renderers,
			".$DB->quote($item_assigned_user_ID)." AS post_assigned_user_ID,
			".$DB->quote($item_typ_ID)." AS post_ptyp_ID,
			".$DB->quote($item_st_ID)." AS post_pst_ID,
			".$DB->quote($item_deadline)." AS post_datedeadline,
			".$DB->quote($item_priority)." AS post_priority";

		$this->total_rows = 1;
		$this->total_pages = 1;
		$this->page = 1;

		// ATTENTION: we skip the parent on purpose here!! fp> refactor
		DataObjectList2::query( false, false, false, 'PREVIEW QUERY' );

		$Item = & $this->Cache->instantiate( $this->rows[0] );

		// Trigger plugin event, allowing to manipulate or validate the item before it gets previewed
		$Plugins->trigger_event( 'AppendItemPreviewTransact', array( 'Item' => & $Item ) );

		if( $errcontent = $Messages->display( T_('Invalid post, please correct these errors:'), '', false, 'error' ) )
		{
			$Item->content = $errcontent."\n<hr />\n".$content;
		}

		// little funky fix for IEwin, rawk on that code
		global $Hit;
		if( ($Hit->is_winIE) && (!isset($IEWin_bookmarklet_fix)) )
		{ // QUESTION: Is this still needed? What about $IEWin_bookmarklet_fix? (blueyed)
			$Item->content = preg_replace('/\%u([0-9A-F]{4,4})/e', "'&#'.base_convert('\\1',16,10). ';'", $Item->content);
		}
	}


  /**
	 * Run Query: GET DATA ROWS *** HEAVY ***
	 */
	function query()
	{
		global $DB;

		if( !is_null( $this->rows ) )
		{ // Query has already executed:
			return;
		}

		// INNIT THE QUERY:
		$this->query_init();

		// Results style orders:
		// $this->ItemQuery->ORDER_BY_prepend( $this->get_order_field_list() );


		// We are going to proceed in two steps (we simulate a subquery)
		// 1) we get the IDs we need
		// 2) we get all the other fields matching these IDs
		// This is more efficient than manipulating all fields at once.

		// *** STEP 1 ***
		// walter> Accordding to the standart, to DISTINCT queries, all columns used
		// in ORDER BY must appear in the query. This make que query work with PostgreSQL and
		// other databases.
		// fp> That can dramatically fatten the returned data. You must handle this in the postgres class (check that order fields are in select)
		$step1_sql = 'SELECT DISTINCT '.$this->Cache->dbIDname // .', '.implode( ', ', $order_cols_to_select )
									.$this->ItemQuery->get_from()
									.$this->ItemQuery->get_where()
									.$this->ItemQuery->get_group_by()
									.$this->ItemQuery->get_order_by()
									.$this->ItemQuery->get_limit();

		// echo $DB->format_query( $step1_sql );

		// Get list of the IDs we need:
		$ID_list = implode( ',', $DB->get_col( $step1_sql, 0, 'ItemList2::Query() Step 1: Get ID list' ) );

		// *** STEP 2 ***
		$this->sql = 'SELECT *
			              FROM '.$this->Cache->dbtablename;
		if( !empty($ID_list) )
		{
			$this->sql .= ' WHERE '.$this->Cache->dbIDname.' IN ('.$ID_list.') '
										.$this->ItemQuery->get_order_by();
		}
		else
		{
			$this->sql .= ' WHERE 0';
		}

		//echo $DB->format_query( $this->sql );

		// ATTENTION: we skip the parent on purpose here!! fp> refactor
		DataObjectList2::query( false, false, false, 'ItemList2::Query() Step 2' );
	}


	/**
	 * If the list is sorted by category...
 	 *
 	 * This is basically just a stub for backward compatibility
	 */
	function & get_item()
	{
		if( $this->group_by_cat == 1 )
		{	// This is the first call to get_item() after get_category_group()
			$this->group_by_cat = 2;
			// Return the object we already got in get_category_group():
			return $this->current_Obj;
		}

		$Item = & parent::get_next();

		if( !empty($Item) && $this->group_by_cat == 2 && $Item->main_cat_ID != $this->main_cat_ID )
		{	// We have just hit a new category!
			$this->group_by_cat == 0; // For info only.
			$r = false;
			return $r;
		}

		//pre_dump( $Item );

		return $Item;
	}


	/**
	 * Returns values needed to make sort links for a given column
	 *
	 * Returns an array containing the following values:
	 *  - current_order : 'ASC', 'DESC' or ''
	 *  - order_asc : url needed to order in ascending order
	 *  - order_desc
	 *  - order_toggle : url needed to toggle sort order
	 *
	 * @param integer column to sort
	 * @return array
	 */
	function get_col_sort_values( $col_idx )
	{
		$col_order_fields = $this->cols[$col_idx]['order'];

		// pre_dump( $col_order_fields, $this->filters['orderby'], $this->filters['order'] );

		// Current order:
		if( $this->filters['orderby'] == $col_order_fields )
		{
			$col_sort_values['current_order'] = $this->filters['order'];
		}
		else
		{
			$col_sort_values['current_order'] = '';
		}


		// Generate sort values to use for sorting on the current column:
		$col_sort_values['order_asc'] = regenerate_url( array($this->param_prefix.'order',$this->param_prefix.'orderby'),
																			$this->param_prefix.'order=ASC&amp;'.$this->param_prefix.'orderby='.$col_order_fields );
		$col_sort_values['order_desc'] = regenerate_url(  array($this->param_prefix.'order',$this->param_prefix.'orderby'),
																			$this->param_prefix.'order=DESC&amp;'.$this->param_prefix.'orderby='.$col_order_fields );

		if( !$col_sort_values['current_order'] && isset( $this->cols[$col_idx]['default_dir'] ) )
		{	// There is no current order on this column and a default order direction is set for it
			// So set a default order direction for it

			if( $this->cols[$col_idx]['default_dir'] == 'A' )
			{	// The default order direction is A, so set its toogle  order to the order_asc
				$col_sort_values['order_toggle'] = $col_sort_values['order_asc'];
			}
			else
			{ // The default order direction is A, so set its toogle order to the order_desc
				$col_sort_values['order_toggle'] = $col_sort_values['order_desc'];
			}
		}
		elseif( $col_sort_values['current_order'] == 'ASC' )
		{	// There is an ASC current order on this column, so set its toogle order to the order_desc
			$col_sort_values['order_toggle'] = $col_sort_values['order_desc'];
		}
		else
		{ // There is a DESC or NO current order on this column,  so set its toogle order to the order_asc
			$col_sort_values['order_toggle'] = $col_sort_values['order_asc'];
		}

		// pre_dump( $col_sort_values );

		return $col_sort_values;
	}



  /**
	 * Link to previous and next link in collection
	 */
	function prevnext_item_links( $params )
	{
		$params = array_merge( array(
									'template' => '$prev$$next$',
									'prev_text' => '&laquo; $title$',
									'prev_no_item' => '',
									'next_text' => '$title$ &raquo;',
									'next_no_item' => '',
								), $params );

		$prev = $this->prev_item_link( $params['prev_start'], $params['prev_end'], $params[ 'prev_text' ], $params[ 'prev_no_item' ], false );
		$next = $this->next_item_link( $params['next_start'], $params['next_end'], $params[ 'next_text' ], $params[ 'next_no_item' ], false );

		$output = str_replace( '$prev$', $prev, $params['template'] );
		$output = str_replace( '$next$', $next, $output );

		if( !empty( $output ) )
		{	// we have some output, lets wrap it
			echo( $params['block_start'] );
			echo $output;
			echo( $params['block_end'] );
		}
	}


	/**
	 * Skip to previous
	 */
	function prev_item_link( $before = '', $after = '', $text = '&laquo; $title$', $no_item = '', $display = true )
	{
    /**
		 * @var Item
		 */
		$prev_Item = & $this->get_prevnext_Item( 'prev' );

		if( !is_null($prev_Item) )
		{
			$output = $before;
			$output .= $prev_Item->get_permanent_link( $text );
			$output .= $after;
		}
		else
		{
			$output = $no_item;
		}
		if( $display ) echo $output;
		return $output;
	}


	/**
	 * Skip to next
	 */
	function next_item_link(  $before = '', $after = '', $text = '$title$ &raquo;', $no_item = '', $display = true )
	{
    /**
		 * @var Item
		 */
		$next_Item = & $this->get_prevnext_Item( 'next' );

		if( !is_null($next_Item) )
		{
			$output = $before;
			$output .= $next_Item->get_permanent_link( $text );
			$output .= $after;
		}
		else
		{
			$output = $no_item;
		}
		if( $display ) echo $output;
		return $output;
	}


	/**
	 * Skip to previous/next Item
	 *
	 * If several items share the same spot (like same issue datetime) then they'll get all skipped at once.
	 *
	 * @param string prev | next  (relative to the current sort order)
	 */
	function & get_prevnext_Item( $direction = 'next' )
	{
		global $DB, $ItemCache;

		if( ! $this->single_post )
		{	// We are not on a single post:
			$r = NULL;
			return $r;
		}

    /**
		 * @var Item
		 */
		$current_Item = $this->get_by_idx(0);

		if( is_null($current_Item) )
		{	// This happens if we are on a single post that we do not actually have permission to view
			$r = NULL;
			return $r;
		}

		if( $current_Item->ptyp_ID == 1000 ) // page
		{	// We are not on a REGULAR post:
			$r = NULL;
			return $r;
		}

		if( !empty( $this->prevnext_Item[$direction] ) )
		{
			return $this->prevnext_Item[$direction];
		}

		$next_Query = & new ItemQuery( $this->Cache->dbtablename, $this->Cache->dbprefix, $this->Cache->dbIDname );

		// GENERATE THE QUERY:

		/*
		 * filtering stuff:
		 */
		$next_Query->where_chapter2( $this->Blog, $this->filters['cat_array'], $this->filters['cat_modifier'],
																 $this->filters['cat_focus'] );
		$next_Query->where_author( $this->filters['authors'] );
		$next_Query->where_assignees( $this->filters['assignees'] );
		$next_Query->where_author_assignee( $this->filters['author_assignee'] );
		$next_Query->where_locale( $this->filters['lc'] );
		$next_Query->where_statuses( $this->filters['statuses'] );
		$next_Query->where_types( $this->filters['types'] );
		$next_Query->where_keywords( $this->filters['keywords'], $this->filters['phrase'], $this->filters['exact'] );
		// $next_Query->where_ID( $this->filters['post_ID'], $this->filters['post_title'] );
		$next_Query->where_datestart( $this->filters['ymdhms'], $this->filters['week'],
		                                   $this->filters['ymdhms_min'], $this->filters['ymdhms_max'],
		                                   $this->filters['ts_min'], $this->filters['ts_max'] );
		$next_Query->where_visibility( $this->filters['visibility_array'] );

		/*
		 * ORDER BY stuff:
		 */
		if( ($direction == 'next' && $this->filters['order'] == 'DESC')
			|| ($direction == 'prev' && $this->filters['order'] == 'ASC') )
		{
			$order = 'DESC';
			$operator = ' < ';
		}
		else
		{
			$order = 'ASC';
			$operator = ' > ';
		}

		$orderby = str_replace( ' ', ',', $this->filters['orderby'] );
		$orderby_array = explode( ',', $orderby );

		// Format each order param with default column names:
		$orderbyorder_array = preg_replace( '#^(.+)$#', $this->Cache->dbprefix.'$1 '.$order, $orderby_array );

		// Add an ID parameter to make sure there is no ambiguity in ordering on similar items:
		$orderbyorder_array[] = $this->Cache->dbIDname.' '.$order;

		$order_by = implode( ', ', $orderbyorder_array );


		$next_Query->order_by( $order_by );


		// LIMIT to 1 single result
		$next_Query->LIMIT( '1' );

		// fp> TODO: I think some additional limits need to come back here (for timespans)


    /*
		 * Position right after the current element depending on current sorting params
		 *
		 * If there are several items on the same issuedatetime for example, we'll then differentite on post ID
		 * WARNING: you cannot combine criterias with AND here; you need stuf like a>a0 OR (a=a0 AND b>b0)
		 */
		switch( $orderby_array[0] )
		{
			case 'datestart':
				// special var name:
				$next_Query->WHERE_and( '( '
																	.$this->Cache->dbprefix.$orderby_array[0]
																	.$operator
																	.$DB->quote($current_Item->issue_date)
																	.' OR ( '
                                    .$this->Cache->dbprefix.$orderby_array[0]
																		.' = '
																		.$DB->quote($current_Item->issue_date)
																		.' AND '
																		.$this->Cache->dbIDname
																		.$operator
																		.$current_Item->ID
																	.') )'
																 );
				break;

			case 'title':
			case 'datecreated':
			case 'datemodified':
			case 'urltitle':
			case 'priority':	// Note: will skip to next priority level
				$next_Query->WHERE_and( '( '
																.$this->Cache->dbprefix.$orderby_array[0]
																.$operator
																.$DB->quote($current_Item->{$orderby_array[0]})
																.' OR ( '
                                  .$this->Cache->dbprefix.$orderby_array[0]
																	.' = '
																	.$DB->quote($current_Item->{$orderby_array[0]})
																	.' AND '
																	.$this->Cache->dbIDname
																	.$operator
																	.$current_Item->ID
																.') )'
															);
				break;

			default:
				echo 'WARNING: unhandled sorting: '.htmlspecialchars( $orderby_array[0] );
		}



		// GET DATA ROWS:


		// We are going to proceed in two steps (we simulate a subquery)
		// 1) we get the IDs we need
		// 2) we get all the other fields matching these IDs
		// This is more efficient than manipulating all fields at once.

		// Step 1:
		$step1_sql = 'SELECT DISTINCT '.$this->Cache->dbIDname
									.$next_Query->get_from()
									.$next_Query->get_where()
									.$next_Query->get_group_by()
									.$next_Query->get_order_by()
									.$next_Query->get_limit();

		// echo $DB->format_query( $step1_sql );

		// Get list of the IDs we need:
		$next_ID = $DB->get_var( $step1_sql, 0, 0, 'Get ID of next item' );

		// Step 2: get the item (may be NULL):
		$this->prevnext_Item[$direction] = & $ItemCache->get_by_ID( $next_ID, true, false );

		return $this->prevnext_Item[$direction];

	}
}


?>
