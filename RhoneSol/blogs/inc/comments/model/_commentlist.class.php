<?php
/**
 * This file implements the CommentList class.
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2004-2005 by Daniel HAHLER - {@link http://thequod.de/contact}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
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
 * @author blueyed: Daniel HAHLER.
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _commentlist.class.php,v 1.6 2008/01/21 09:35:27 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('_core/model/dataobjects/_dataobjectlist.class.php');

/**
 * CommentList Class
 *
 * @package evocore
 */
class CommentList extends DataObjectList
{
	/**
	 * Constructor
	 *
	 * @param Blog can pass NULL if $p is passed
	 * @param string
	 * @param array
	 * @param
	 * @param string Order ("ASC"/"DESC")
	 * @param string List of fields to order by (separated by " ")
	 * @param integer Limit
	 */
	function CommentList(
		$Blog,
		$comment_types = "'comment'",
		$show_statuses = array( 'published' ),	// Restrict to these statuses
		$p = '',															// Restrict to specific post
		$author = '',													// Not used yet
		$order = 'DESC',											// ASC or DESC
		$orderby = '',												// list of fields to order by
		$limit = '' 													// # of comments to display on the page
		)
	{
		global $DB;
		global $cache_categories;
		global $pagenow;		// Bleh !

		// Call parent constructor:
		parent::DataObjectList( 'T_comments', 'comment_', 'comment_ID', 'Item', NULL, $limit );

		$this->sql = 'SELECT DISTINCT T_comments.*
									FROM T_comments INNER JOIN T_items__item ON comment_post_ID = post_ID ';

		if( !empty( $p ) )
		{	// Restrict to comments on selected post
			$this->sql .= 'WHERE comment_post_ID = '.$p;
		}
		else
		{
			$this->sql .= 'INNER JOIN T_postcats ON post_ID = postcat_post_ID
										INNER JOIN T_categories othercats ON postcat_cat_ID = othercats.cat_ID ';

			$aggregate_coll_IDs = $Blog->get_setting('aggregate_coll_IDs');
			if( empty( $aggregate_coll_IDs ) )
			{	// We only want posts from the current blog:
				$this->sql .= 'WHERE othercats.cat_blog_ID = '.$Blog->ID;
			}
			else
			{	// We are aggregating posts from several blogs:
				$this->sql .= 'WHERE othercats.cat_blog_ID IN ('.$aggregate_coll_IDs.')';
			}
		}

		$this->sql .= ' AND comment_type IN ('.$comment_types.') ';

		/*
		 * ----------------------------------------------------
		 *  Restrict to the statuses we want to show:
		 * ----------------------------------------------------
		 */
		if( ! empty( $show_statuses ) )
		{
			$this->sql .= ' AND comment_status IN (\''.implode( "', '", $show_statuses ).'\')';
		}

		// This one restricts to post statuses, but it doesn't work completely right:
		// TODO: handle status dependencies with post
		$this->sql .= ' AND '.statuses_where_clause();


		// order by stuff
		if( (!empty($order)) && !in_array( strtoupper($order), array( 'ASC', 'DESC', 'RANDOM' ) ) )
		{
			$order='DESC';
		}

		if(empty($orderby))
		{
			$orderby = 'comment_date '.$order.', comment_ID '.$order;
		}
		else
		{
			$orderby_array = explode(' ',$orderby);
			$orderby = $orderby_array[0].' '.$order;
			if (count($orderby_array)>1)
			{
				for($i = 1; $i < (count($orderby_array)); $i++)
				{
					$orderby .= ', comment_'.$orderby_array[$i].' '.$order;
				}
			}
		}

		if( $order == 'RANDOM' ) $orderby = 'RAND()';

		$this->sql .= "ORDER BY $orderby";
		if( !empty( $this->limit ) )
		{
			$this->sql .= ' LIMIT '.$this->limit;
		}

		// echo $this->sql;

		$this->rows = $DB->get_results( $this->sql, ARRAY_A );

		// Prebuild and cache objects:
		if( $this->result_num_rows = $DB->num_rows )
		{	// fplanque>> why this test??

			$i = 0;
			foreach( $this->rows as $row )
			{
				// Prebuild object:
				$this->Obj[$i] = new Comment( $row ); // COPY (function)

				// To avoid potential future waste, cache this object:
				// $this->DataObjectCache->add( $this->Obj[$i] );

				$i++;
			}
		}
	}


	/**
	 * Template function: display message if list is empty
	 *
	 * @return boolean true if empty
	 */
	function display_if_empty( $params = array() )
	{
		// Make sure we are not missing any param:
		$params = array_merge( array(
				'msg_empty'   => T_('No comment yet...'),
			), $params );

		return parent::display_if_empty( $params );
	}

}


?>