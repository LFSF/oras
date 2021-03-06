<?php
/**
 * This file implements the UI view for the General blog properties.
 *
 * b2evolution - {@link http://b2evolution.net/}
 * Released under GNU GPL License - {@link http://b2evolution.net/about/license.html}
 * @copyright (c)2003-2008 by Francois PLANQUE - {@link http://fplanque.net/}
 *
 * {@internal Open Source relicensing agreement:
 * }}
 *
 * @package admin
 * {@internal Below is a list of authors who have contributed to design/coding of this file: }}
 * @author fplanque: Francois PLANQUE.
 *
 * @version $Id: _coll_sel_type.view.php,v 1.2 2008/01/21 09:35:27 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

echo '<h2>'.T_('What kind of blog would you like to create?').'</h2>';

echo '<table class="coll_kind">';

	echo '<tr>';
		echo '<td class="coll_kind"><h3><a href="?ctrl=collections&amp;action=new-selskin&amp;kind=std">'.T_('Standard').' &raquo;</a></h3></td>';
		echo '<td>'.T_('A standard blog with the most common features.').'<td>';
	echo '</tr>';

	echo '<tr>';
		echo '<td class="coll_kind"><h3><a href="?ctrl=collections&amp;action=new-selskin&amp;kind=photo">'.T_('Photoblog').' &raquo;</a></h3></td>';
		echo '<td>'.T_('A blog optimized to publishing photos.').'<td>';
	echo '</tr>';

	echo '<tr>';
		echo '<td class="coll_kind"><h3><a href="?ctrl=collections&amp;action=new-selskin&amp;kind=group">'.T_('Group blog').' &raquo;</a></h3></td>';
		echo '<td>'.T_('A blog optimized for team/collaborative editing. Posts can be assigned to different reviewers before being published. Look for the workflow properties at the bottom of the post editing form.').'<td>';
	echo '</tr>';

echo '</table>';

echo '<p>'.T_('Your selection here will pre-configure your blog in order to optimize it for a particular use. Nothing is final though. You can change all the settings at any time and any kind of blog can be transformed into any other at any time.').'</p>';



?>