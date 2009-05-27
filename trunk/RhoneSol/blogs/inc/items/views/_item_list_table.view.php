<?php
/**
 * This file implements the post browsing in tracker mode
 *
 * This file is part of the b2evolution/evocms project - {@link http://b2evolution.net/}.
 * See also {@link http://sourceforge.net/projects/evocms/}.
 *
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}.
 * Parts of this file are copyright (c)2005 by Daniel HAHLER - {@link http://thequod.de/contact}.
 *
 * @license http://b2evolution.net/about/license.html GNU General Public License (GPL)
 *
 * @package admin
 *
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _item_list_table.view.php,v 1.5 2008/01/21 09:35:31 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Blog
 */
global $Blog;
/**
 * @var ItemList2
 */
global $ItemList;

global $edit_item_url, $delete_item_url;

if( $highlight = param( 'highlight', 'integer', NULL ) )
{	// There are lines we want to highlight:
	$result_fadeout = array( 'post_ID' => array($highlight) );
}
else
{	// Nothing to highlight
	$result_fadeout = NULL;
}


// Display title depending on selection params:
echo $ItemList->get_filter_title( '<h2>', '</h2>', '<br />', NULL, 'htmlbody' );


/*
	**
	 * Callback to add filters on top of the result set
	 *
	function filter_on_post_title( & $Form )
	{
		global $pagenow, $post_filter;

		$Form->hidden( 'filter_on_post_title', 1 );
		$Form->text( 'post_filter', $post_filter, 20, T_('Task title'), '', 60 );
	}
	$ItemList->filters_callback = 'filter_on_post_title';
*/


$ItemList->title = T_('Post list');

// Issue date:
$ItemList->cols[] = array(
		'th' => T_('Date'),
		'order' => 'datestart',
		'default_dir' => 'D',
		'th_class' => 'nowrap',
		'td_class' => 'nowrap',
		'td' => '@get_permanent_link( get_icon(\'permalink\') )@ <span class="date">@get_issue_date()@</span>',
	);


// Blog name:
if( $Blog->get_setting( 'aggregate_coll_IDs' ) )
{ // Aggregated blog: display name of blog
	$ItemList->cols[] = array(
			'th' => T_('Blog'),
			'th_class' => 'nowrap',
			'td_class' => 'nowrap',
			'td' => '@load_Blog()@<a href="¤regenerate_url( \'blog,results_order\', \'blog=@blog_ID@\' )¤">@Blog->dget(\'shortname\')@</a>',
		);
}


// Author:
$ItemList->cols[] = array(
		'th' => T_('Author'),
		'th_class' => 'nowrap',
		'td_class' => 'nowrap',
		'order' => 'creator_user_ID',
		'td' => '@get(\'t_author\')@',
	);


/**
 * Task title
 */
function task_title_link( $Item )
{
	global $current_User;

	$col = locale_flag( $Item->locale, 'w16px', 'flag', '', false ).' ';

	$Item->get_Blog();

	if( $Item->Blog->allowcomments != 'never' )
	{	// The current blog can have comments:
		$nb_comments = generic_ctp_number($Item->ID, 'feedback');
		$col .= '<a href="?ctrl=items&amp;blog='.$Item->blog_ID.'&amp;p='.$Item->ID.'"
						title="'.sprintf( T_('%d feedbacks'), $nb_comments ).'" class="">';
		if( $nb_comments )
		{
			$col .= get_icon( 'comments' );
		}
		else
		{
			$col .= get_icon( 'nocomment' );
		}
		$col .= '</a> ';
	}

	$col .= '<a href="?ctrl=items&amp;blog='.$Item->blog_ID.'&amp;p='.$Item->ID.'" class="" title="'.
								T_('View this post...').'">'.$Item->dget('title').'</a></strong>';

	return $col;
}
$ItemList->cols[] = array(
						'th' => T_('Title'),
						'order' => 'title',
						'td_class' => 'tskst_$post_pst_ID$',
						'td' => '<strong lang="@get(\'locale\')@">%task_title_link( {Obj} )%</strong>',
					);


/**
 * Visibility:
 */
function item_visibility( $Item )
{
	// Display publish NOW button if current user has the rights:
	$r = $Item->get_publish_link( ' ', ' ', get_icon( 'publish' ), '#', '' );

	// Display deprecate if current user has the rights:
	$r .= $Item->get_deprecate_link( ' ', ' ', get_icon( 'deprecate' ), '#', '' );

	if( empty($r) )
	{	// for IE
		$r = '&nbsp;';
	}

	return $r;
}
$ItemList->cols[] = array(
						'th' => T_('Visibility'),
						'order' => 'status',
						'td_class' => 'shrinkwrap',
						'td' => '%item_visibility( {Obj} )%',
				);
$ItemList->cols[] = array(
						'th' => T_('Visibility'),
						'order' => 'status',
						'td_class' => 'tskst_$post_pst_ID$ nowrap',
						'td' => '@get( \'t_status\' )@',
				);


$ItemList->cols[] = array(
	'th' => /* TRANS: abbrev for info */ T_('i'),
	'order' => 'datemodified',
	'default_dir' => 'D',
	'th_class' => 'shrinkwrap',
	'td_class' => 'shrinkwrap',
	'td' => '@history_info_icon()@',
);



/**
 * Edit Actions:
 *
 * @param Item
 */
function item_edit_actions( $Item )
{
	// Display edit button if current user has the rights:
	$r = $Item->get_edit_link( array(
		'before' => ' ',
		'after' => ' ',
		'text' => get_icon( 'edit' ),
		'title' => '#',
		'class' => '' ) );

	// Display delete button if current user has the rights:
	$r .= $Item->get_delete_link( ' ', ' ', get_icon( 'delete' ), '#', '', false );

	return $r;
}
$ItemList->cols[] = array(
		'th' => T_('Act.'),
		'td_class' => 'shrinkwrap',
		'td' => '%item_edit_actions( {Obj} )%',
	);


if( $ItemList->is_filtered() )
{	// List is filtered, offer option to reset filters:
	$ItemList->global_icon( T_('Reset all filters!'), 'reset_filters', '?ctrl=items&amp;blog='.$Blog->ID.'&amp;filter=reset', T_('Reset filters') );
}

if( $current_User->check_perm( 'blog_post_statuses', 'edit', false, $Blog->ID ) )
{	// We have permission to add a post with at least one status:
	$ItemList->global_icon( T_('Write a new post...'), 'new', '?ctrl=items&amp;action=new&amp;blog='.$Blog->ID, T_('New post').' &raquo;', 3, 4 );
}


// EXECUTE the query now:
$ItemList->restart();

// Initialize funky display vars now:
global $postIDlist, $postIDarray;
$postIDlist = $ItemList->get_page_ID_list();
$postIDarray = $ItemList->get_page_ID_array();

// DISPLAY table now:
$ItemList->display( NULL, $result_fadeout );



?>