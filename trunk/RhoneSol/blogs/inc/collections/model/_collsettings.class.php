<?php
/**
 * This file implements the CollectionSettings class which handles
 * coll_ID/name/value triplets for collections/blogs.
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
 * @author fplanque: Francois PLANQUE
 *
 * @version $Id: _collsettings.class.php,v 1.14.4.1 2008/02/18 20:23:20 fplanque Exp $
 *
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('settings/model/_abstractsettings.class.php');

/**
 * Class to handle the settings for collections/blogs
 *
 * @package evocore
 */
class CollectionSettings extends AbstractSettings
{
	/**
	 * The default settings to use, when a setting is not defined in the database.
	 *
	 * @access protected
	 */
	var $_defaults = array(
			'new_feedback_status' => 'draft',  	// 'draft', 'published' or 'deprecated'

			'ping_plugins'   => 'ping_pingomatic,ping_b2evonet', // ping plugin codes, separated by comma
			'orderby'        => 'datestart',
			'orderdir'       => 'DESC',
			'what_to_show'   => 'posts',        // posts, days
			'posts_per_page' => '5',
			'feed_content'   => 'normal',
			'posts_per_feed' => '8',
			'allow_subscriptions' => 0,					// Don't all email subscriptions by default
			'use_workflow' => 0,								// Don't use workflow by default
			'aggregate_coll_IDs' => '',
			'allow_rating'   => 'never',

			'canonical_item_urls' => 1,					// Redirect posts to their canonical Url?
			'default_noindex' => '0',						// META NOINDEX on Default blog page

			'paged_noindex' => '1',							// META NOINDEX on following blog pages
			'paged_nofollowto' => '0',          // NOFOLLOW on links to following blog pages

			'archive_mode'   => 'monthly',			// monthly, weekly, daily, postbypost
			'archive_links'  => 'extrapath',		// param, extrapath
			'archive_posts_per_page' => '100',
			'archive_noindex' => '1',						// META NOINDEX on Archive pages
			'archive_nofollowto' => '0',        // NOFOLLOW on links to archive pages

			'chapter_links'  => 'chapters',			// 'param_num', 'subchap', 'chapters'
			'canonical_cat_urls' => 1,					// Redirect categories to their canonical Url?
			'chapter_posts_per_page' => NULL,
			'chapter_noindex' => '1',						// META NOINDEX on Category pages
			'category_prefix' => '',

			'tag_links'  => 'semicol',					// 'param', 'semicol'
			'canonical_tag_urls' => 1,					// Redirect tag pages to their canonical Url?
			'tag_posts_per_page' => NULL,
			'tag_noindex' => '1',				      	// META NOINDEX on Tag pages
			'tag_prefix' => '',

			'single_links'   => 'ymd',
			'permalinks'     => 'single',				// single, archive, subchap

			'filtered_noindex' => '1',					// META NOINDEX on other filtered pages
			'arcdir_noindex' => '1',						// META NOINDEX on Archive directory
			'catdir_noindex' => '1',						// META NOINDEX on Category directory
			'feedback-popup_noindex' => '1',		// META NOINDEX on Feedback popups
			'msgform_noindex' => '1',						// META NOINDEX on Message forms
			'special_noindex' => '1',						// META NOINDEX on other special pages
			'title_link_type' => 'permalink',

			'blog_footer_text' => '&copy;$year$ by $owner$',
			'single_item_footer_text' => '',
			'xml_item_footer_text' => '<p><small><a href="$item_perm_url$">Original post</a> blogged on <a href="http://b2evolution.net/">b2evolution</a>.</small></p>',
		);


	/**
	 * Constructor
	 */
	function CollectionSettings()
	{
		parent::AbstractSettings( 'T_coll_settings', array( 'cset_coll_ID', 'cset_name' ), 'cset_value', 1 );
	}

	/**
	 * Loads the settings. Not meant to be called directly, but gets called
	 * when needed.
	 *
	 * @access protected
	 * @param string First column key
	 * @param string Second column key
	 * @return boolean
	 */
	function _load( $coll_ID, $arg )
	{
		if( empty( $coll_ID ) )
		{
			return false;
		}

		return parent::_load( $coll_ID, $arg );
	}

}



?>