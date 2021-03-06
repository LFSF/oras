<?php
/**
 * This file implements the comment browsing
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
 * @version $Id: _browse_comments.view.php,v 1.4 2008/01/21 09:35:27 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

/**
 * @var Comment
 */
global $Comment;
/**
 * @var Blog
 */
global $Blog;
/**
 * @var CommentList
 */
global $CommentList;

global $dispatcher;


/*
 * Display comments:
 */
$block_item_Widget = & new Widget( 'block_item' );

$block_item_Widget->title = T_('Feedback (Comments, Trackbacks...)');
$block_item_Widget->disp_template_replaced( 'block_start' );


$CommentList->display_if_empty();

// Display list of comments:
require dirname(__FILE__).'/_comment_list.inc.php';

$block_item_Widget->disp_template_replaced( 'block_end' );



?>