<?php
/**
 * This file implements the Comment class.
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
 * @version $Id: _comment.class.php,v 1.14 2008/01/21 09:35:27 fplanque Exp $
 */
if( !defined('EVO_MAIN_INIT') ) die( 'Please, do not access this page directly.' );

load_class('_core/model/dataobjects/_dataobject.class.php');

/**
 * Comment Class
 *
 * @package evocore
 */
class Comment extends DataObject
{
	/**
	 * The item (parent) of this Comment (lazy-filled).
	 * @see Comment::get_Item()
	 * @see Comment::set_Item()
	 * @access protected
	 * @var Item
	 */
	var $Item;
	/**
	 * The ID of the comment's Item.
	 * @var integer
	 */
	var $item_ID;
	/**
	 * The comment's user, this is NULL for (anonymous) visitors (lazy-filled).
	 * @see Comment::get_author_User()
	 * @see Comment::set_author_User()
	 * @access protected
	 * @var User
	 */
	var $author_User;
	/**
	 * The ID of the author's user. NULL for anonymous visitors.
	 * @var integer
	 */
	var $author_ID;
	/**
	 * Comment type: 'comment', 'linkback', 'trackback' or 'pingback'
	 * @var string
	 */
	var $type;
	/**
	 * Comment visibility status: 'published', 'deprecated', 'redirected', 'protected', 'private' or 'draft'
	 * @var string
	 */
	var $status;
	/**
	 * Name of the (anonymous) visitor (if any).
	 * @var string
	 */
	var $author;
	/**
	 * Email address of the (anonymous) visitor (if any).
	 * @var string
	 */
	var $author_email;
	/**
	 * URL/Homepage of the (anonymous) visitor (if any).
	 * @var string
	 */
	var $author_url;
	/**
	 * IP address of the comment's author (while posting).
	 * @var string
	 */
	var $author_IP;
	/**
	 * Date of the comment (MySQL DATETIME - use e.g. {@link mysql2timestamp()}); local time ({@link $localtimenow})
	 * @var string
	 */
	var $date;
	/**
	 * @var string
	 */
	var $content;
	/**
	 * Spam karma of the comment (0-100), 0 being "probably no spam at all"
	 * @var integer
	 */
	var $spam_karma;
	/**
	 * Does an anonymous commentator allow to send messages through a message form?
	 * @var boolean
	 */
	var $allow_msgform;

	var $nofollow;

	/**
	 * Constructor
	 */
	function Comment( $db_row = NULL )
	{
		// Call parent constructor:
		parent::DataObject( 'T_comments', 'comment_', 'comment_ID' );

		if( $db_row == NULL )
		{
			// echo 'null comment';
			$this->rating = NULL;
			$this->featured = 0;
			$this->nofollow = 1;
		}
		else
		{
			$this->ID = $db_row['comment_ID'];
			$this->item_ID = $db_row['comment_post_ID'];
			if( ! empty($db_row['comment_author_ID']) )
			{
				$this->author_user_ID = $db_row['comment_author_ID'];
			}
			$this->type = $db_row['comment_type'];
			$this->status = $db_row['comment_status'];
			$this->author = $db_row['comment_author'];
			$this->author_email = $db_row['comment_author_email'];
			$url = trim( $db_row['comment_author_url'] );
			if( ! empty($url) && ! preg_match( '~^\w+://~', $url ) )
			{ // URL given and does not start with a protocol:
				$url = 'http://'.$url;
			}
			$this->author_url = $url;
			$this->author_IP = $db_row['comment_author_IP'];
			$this->date = $db_row['comment_date'];
			$this->content = $db_row['comment_content'];
			$this->rating = $db_row['comment_rating'];
			$this->featured = $db_row['comment_featured'];
			$this->nofollow = $db_row['comment_nofollow'];
			$this->spam_karma = $db_row['comment_spam_karma'];
			$this->allow_msgform = $db_row['comment_allow_msgform'];
		}
	}


	/**
	 * Get the author User of the comment. This is NULL for anonymous visitors.
	 *
	 * @return User
	 */
	function & get_author_User()
	{
		if( isset($this->author_user_ID) && ! isset($this->author_User) )
		{
			$UserCache = & get_Cache( 'UserCache' );
			$this->author_User = & $UserCache->get_by_ID( $this->author_user_ID );
		}

		return $this->author_User;
	}


	/**
	 * Get the Item this comment relates to
	 *
	 * @return Item
	 */
	function & get_Item()
	{
		if( ! isset($this->Item) )
		{
			$ItemCache = & get_Cache( 'ItemCache' );
			$this->Item = & $ItemCache->get_by_ID( $this->item_ID );
		}

		return $this->Item;
	}


	/**
	 * Get a member param by its name
	 *
	 * @param mixed Name of parameter
	 * @return mixed Value of parameter
	 */
	function get( $parname )
	{
		global $post_statuses;

		switch( $parname )
		{
			case 't_status':
				// Text status:
				return T_( $post_statuses[$this->status] );
		}

		return parent::get( $parname );
	}


	/**
	 * Set param value
	 *
	 * @param string parameter name
	 * @param mixed parameter value
	 * @return boolean true, if a value has been set; false if it has not changed
	 */
	function set( $parname, $parvalue )
	{
		switch( $parname )
		{
			case 'rating':
				return parent::set_param( $parname, 'string', $parvalue, true );

			default:
				return parent::set_param( $parname, 'string', $parvalue );
		}
	}


	/**
	 * Set Item this comment relates to
	 * @param Item
	 */
	function set_Item( & $Item )
	{
		$this->Item = & $Item;
		$this->item_ID = $Item->ID;
		parent::set_param( 'post_ID', 'number', $Item->ID );
	}


	/**
	 * Set author User of this comment
	 */
	function set_author_User( & $author_User )
	{
		$this->author_User = & $author_User;
		parent::set_param( 'author_ID', 'number', $author_User->ID );
	}


	/**
	 * Set the spam karma, as a number.
	 * @param integer Spam karma (-100 - 100)
	 * @access protected
	 */
	function set_spam_karma( $spam_karma )
	{
		return parent::set_param( 'spam_karma', 'number', $spam_karma );
	}


	/**
	 * Get the anchor-ID of the comment
	 *
	 * @return string
	 */
	function get_anchor()
	{
		return 'c'.$this->ID;
	}


	/**
	 * Template function: display anchor for permalinks to refer to
	 */
	function anchor()
	{
		echo '<a id="'.$this->get_anchor().'"></a>';
	}


	/**
	 * Get the comment author's name.
	 *
	 * @return string
	 */
	function get_author_name()
	{
		if( $this->get_author_User() )
		{
			return $this->author_User->preferred_name( 'raw', false );
		}
		else
		{
			return $this->author;
		}
	}


	/**
	 * Get the EMail of the comment's author.
	 *
	 * @return string
	 */
	function get_author_email()
	{
		if( $this->get_author_User() )
		{ // Author is a user
			return $this->author_User->get('email');
		}
		else
		{
			return $this->author_email;
		}
	}


	/**
	 * Get the URL of the comment's author.
	 *
	 * @return string
	 */
	function get_author_url()
	{
		if( $this->get_author_User() )
		{ // Author is a user
			return $this->author_User->get('url');
		}
		else
		{
			return $this->author_url;
		}
	}


	/**
	 * Template function: display author of comment
	 *
	 * @param string String to display before author name if not a user
	 * @param string String to display after author name if not a user
	 * @param string String to display before author name if he's a user
	 * @param string String to display after author name if he's a user
	 * @param string Output format, see {@link format_to_output()}
	 * @param boolean true for link, false if you want NO html link
	 */
	function author( $before = '', $after = '#', $before_user = '', $after_user = '#',
										$format = 'htmlbody', $makelink = false )
	{
		global $Plugins;

		if( $this->get_author_User() )
		{ // Author is a user
			if( strlen( $this->author_User->url ) <= 10 )
			{
				$makelink = false;
			}
			if( $after_user == '#' ) $after_user = ' ['.T_('Member').']';

			$author_name = format_to_output( $this->author_User->get_preferred_name(), $format );

			$before = $before_user;
			$after = $after_user;

		}
		else
		{ // Display info recorded at edit time:
			if( strlen( $this->author_url ) <= 10 )
			{
				$makelink = false;
			}
			if( $after == '#' ) $after = ' ['.T_('Visitor').']';

			$author_name = $this->dget( 'author', $format );

		}

		if( $makelink )
		{	// Make a link:
			$r = $this->get_author_url_link( $author_name, $before, $after, true );
		}
		else
		{	// Display the name: (NOTE: get_author_url_link( with nolink option ) would NOT handle this correctly when url is empty
			$r = $before.$author_name.$after;
		}

		$Plugins->trigger_event( 'FilterCommentAuthor', array( 'data' => & $r, 'makelink' => $makelink, 'Comment' => $this ) );

		echo $r;
	}


	/**
	 * Template function: display comment's author's IP
	 *
	 * @param string String to display before IP, if IP exists
	 * @param string String to display after IP, if IP exists
	 */
	function author_ip( $before='', $after='' )
	{
		if( !empty( $this->author_IP ) )
		{
			global $Plugins;

			echo $before;
			// Filter the IP by plugins for display, allowing e.g. the DNSBL plugin to add a link that displays info about the IP:
			echo $Plugins->get_trigger_event( 'FilterIpAddress', array(
					'format'=>'htmlbody',
					'data' => $this->author_IP ),
				'data' );
			echo $after;
		}
	}


	/**
	 * Template function: display link to comment author's provided email
	 *
	 * @param string String to display for link: leave empty to display email
	 * @param string String to display before email, if email exists
	 * @param string String to display after email, if email exists
	 * @param boolean false if you want NO html link
	 */
	function author_email( $linktext='', $before='', $after='', $makelink = true )
	{
		$email = $this->get_author_email();

		if( strlen( $email ) > 5 )
		{ // If email exists:
			echo $before;
			if( $makelink ) echo '<a href="mailto:'.$email.'">';
			echo ($linktext != '') ? $linktext : $email;
			if( $makelink ) echo '</a>';
			echo $after;
		}
	}


	/**
	 * Get link to comment author's provided URL
	 *
	 * @param string String to display for link: leave empty to display URL
	 * @param string String to display before link, if link exists
	 * @param string String to display after link, if link exists
	 * @param boolean false if you want NO html link
	 * @return boolean true if URL has been displayed
	 */
	function get_author_url_link( $linktext='', $before='', $after='', $makelink = true )
	{
		global $Plugins;

		$url = $this->get_author_url();

		if( strlen( $url ) < 10 )
		{
			return false;
		}

		// If URL exists:
		$r = $before;
		if( $makelink )
		{
			$r .= '<a ';
			if( $this->nofollow )
			{
				$r .= 'rel="nofollow" ';
			}
			$r .= 'href="'.$url.'">';
		}
		$r .= ( empty($linktext) ? $url : $linktext );
		if( $makelink ) $r .= '</a>';
		$r .= $after;

		$Plugins->trigger_event( 'FilterCommentAuthorUrl', array( 'data' => & $r, 'makelink' => $makelink, 'Comment' => $this ) );

		return $r;
	}


  /**
	 * Template function: display link to comment author's provided URL
	 *
	 * @param string String to display for link: leave empty to display URL
	 * @param string String to display before link, if link exists
	 * @param string String to display after link, if link exists
	 * @param boolean false if you want NO html link
	 * @return boolean true if URL has been displayed
	 */
	function author_url( $linktext='', $before='', $after='', $makelink = true )
	{
		$r = $this->get_author_url_link( $linktext, $before, $after, $makelink );
		if( !empty( $r ) )
		{
			echo $r;
			return true;
		}
		return false;
	}


	/**
	 * Template function: display spam karma of the comment (in percent)
	 *
	 * "%s" gets replaced by the karma value
	 *
	 * @param string Template string to display, if we have a karma value
	 * @param string Template string to display, if we have no karma value (pre-Phoenix)
	 */
	function spam_karma( $template = '%s%', $template_unknown = NULL )
	{
		if( isset($this->spam_karma) )
		{
			echo str_replace( '%s', $this->spam_karma, $template );
		}
		else
		{
			if( ! isset($template_unknown) )
			{
				echo /* TRANS: "not available" */ T_('N/A');
			}
			else
			{
				echo $template_unknown;
			}
		}
	}


	/**
	 * Provide link to edit a comment if user has edit rights
	 *
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 * @return boolean
	 */
	function edit_link( $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '', $glue = '&amp;', $save_context = true )
	{
		global $current_User, $admin_url;

		if( ! is_logged_in() ) return false;

		if( empty($this->ID) )
		{	// Happens in Preview
			return false;
		}

		$this->get_Item();

		if( ! $current_User->check_perm( 'blog_comments', '', false, $this->Item->get( 'blog_ID' ) ) )
		{ // If User has no permission to edit comments:
			return false;
		}

		if( $text == '#' ) $text = get_icon( 'edit' ).' '.T_('Edit...');
		if( $title == '#' ) $title = T_('Edit this comment');

		echo $before;
		echo '<a href="'.$admin_url.'?ctrl=comments&amp;action=edit&amp;comment_ID='.$this->ID;
   	if( $save_context )
		{
			echo $glue.'redirect_to='.rawurlencode( regenerate_url( '', '', '', '&' ) );
		}
		echo '" title="'.$title.'"';
		if( !empty( $class ) ) echo ' class="'.$class.'"';
		echo '>'.$text.'</a>';
		echo $after;

		return true;
	}


	/**
	 * Displays button for deleeing the Comment if user has proper rights
	 *
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 * @param boolean true to make this a button instead of a link
	 */
	function delete_link( $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '', $button = false, $glue = '&amp;', $save_context = true )
	{
		global $current_User, $admin_url;

		if( ! is_logged_in() ) return false;

		if( empty($this->ID) )
		{	// Happens in Preview
			return false;
		}

		$this->get_Item();

		if( ! $current_User->check_perm( 'blog_comments', '', false, $this->Item->get( 'blog_ID' ) ) )
		{ // If User has permission to edit comments:
			return false;
		}

		if( $text == '#' )
		{ // Use icon+text as default, if not displayed as button (otherwise just the text)
			if( ! $button )
			{
				$text = get_icon( 'delete', 'imgtag' ).' '.T_('Delete!');
			}
			else
			{
				$text = T_('Delete!');
			}
		}
		if( $title == '#' ) $title = T_('Delete this comment');

		$url = $admin_url.'?ctrl=comments&amp;action=delete&amp;comment_ID='.$this->ID;
   	if( $save_context )
		{
			$url .= $glue.'redirect_to='.rawurlencode( regenerate_url( '', '', '', '&' ) );
		}

		echo $before;
		if( $button )
		{ // Display as button
			echo '<input type="button"';
			echo ' value="'.$text.'" title="'.$title.'" onclick="if ( confirm(\'';
			echo TS_('You are about to delete this comment!\\nThis cannot be undone!');
			echo '\') ) { document.location.href=\''.$url.'\' }"';
			if( !empty( $class ) ) echo ' class="'.$class.'"';
			echo '/>';
		}
		else
		{ // Display as link
			echo '<a href="'.$url.'" title="'.$title.'" onclick="return confirm(\'';
			echo TS_('You are about to delete this comment!\\nThis cannot be undone!');
			echo '\')"';
			if( !empty( $class ) ) echo ' class="'.$class.'"';
			echo '>'.$text.'</a>';
		}
		echo $after;

		return true;
	}


	/**
	 * Provide link to deprecate a comment if user has edit rights
	 *
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 * @param string glue between url params
	 * @param boolean save context?
	 */
	function get_deprecate_link( $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '', $glue = '&amp;', $save_context = true )
	{
		global $current_User, $admin_url;

		if( ! is_logged_in() ) return false;

		$this->get_Item();

		if( ($this->status == 'deprecated') // Already deprecateded!
			|| ! $current_User->check_perm( 'blog_comments', '', false, $this->Item->get( 'blog_ID' ) ) )
		{ // If User has permission to edit comments:
			return false;
		}

		if( $text == '#' ) $text = get_icon( 'deprecate', 'imgtag' ).' '.T_('Deprecate!');
		if( $title == '#' ) $title = T_('Deprecate this comment!');

		$r = $before;
		$r .= '<a href="';
		$r .= $admin_url.'?ctrl=comments'.$glue.'action=deprecate'.$glue.'comment_ID='.$this->ID;
   	if( $save_context )
		{
			$r .= $glue.'redirect_to='.rawurlencode( regenerate_url( '', '', '', '&' ) );
		}
		$r .= '" title="'.$title.'"';
		if( !empty( $class ) ) $r .= ' class="'.$class.'"';
		$r .= '>'.$text.'</a>';
		$r .= $after;

		return $r;
	}


	/**
	 * Display link to deprecate a comment if user has edit rights
	 *
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 * @param string glue between url params
	 * @param boolean save context?
	 */
	function deprecate_link( $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '', $glue = '&amp;', $save_context = true )
	{
		echo $this->get_deprecate_link( $before, $after, $text, $title, $class, $glue, $save_context );
	}


	/**
	 * Provide link to publish a comment if user has edit rights
	 *
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 * @param string glue between url params
	 * @param boolean save context?
	 */
	function get_publish_link( $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '', $glue = '&amp;', $save_context = true )
	{
		global $current_User, $admin_url;

		if( ! is_logged_in() ) return false;

		$this->get_Item();

		if( ($this->status == 'published') // Already published!
			|| ! $current_User->check_perm( 'blog_comments', '', false, $this->Item->get( 'blog_ID' ) ) )
		{ // If User has permission to edit comments:
			return false;
		}

		if( $text == '#' ) $text = get_icon( 'publish', 'imgtag' ).' '.T_('Publish!');
		if( $title == '#' ) $title = T_('Publish this comment!');

		$r = $before;
		$r .= '<a href="';
		$r .= $admin_url.'?ctrl=comments'.$glue.'action=publish'.$glue.'comment_ID='.$this->ID;
   	if( $save_context )
		{
			$r .= $glue.'redirect_to='.rawurlencode( regenerate_url( '', '', '', '&' ) );
		}
		$r .= '" title="'.$title.'"';
		if( !empty( $class ) ) $r .= ' class="'.$class.'"';
		$r .= '>'.$text.'</a>';
		$r .= $after;

		return $r;
	}


	/**
	 * Display link to publish a comment if user has edit rights
	 *
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 * @param string glue between url params
	 * @param boolean save context?
	 */
	function publish_link( $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '', $glue = '&amp;', $save_context = true )
	{
		echo $this->get_publish_link( $before, $after, $text, $title, $class, $glue, $save_context );
	}


	/**
	 * Provide link to message form for this comment's author
	 *
	 * @param string url of the message form
	 * @param string to display before link
	 * @param string to display after link
	 * @param string link text
	 * @param string link title
	 * @param string class name
	 */
	function msgform_link( $form_url, $before = ' ', $after = ' ', $text = '#', $title = '#', $class = '' )
	{
		if( $this->get_author_User() )
		{ // This comment is from a registered user:
			if( empty($this->author_User->email) )
			{ // We have no email for this Author :(
				return false;
			}
			elseif( empty($this->author_User->allow_msgform) )
			{ // User does not allow message form
				return false;
			}
			$form_url = url_add_param( $form_url, 'recipient_id='.$this->author_User->ID );
		}
		else
		{ // This comment is from a visitor:
			if( empty($this->author_email) )
			{ // We have no email for this comment :(
				return false;
			}
			elseif( empty($this->allow_msgform) )
			{ // Anonymous commentator does not allow message form (for this comment)
				return false;
			}
		}

		$form_url = url_add_param( $form_url, 'comment_id='.$this->ID.'&amp;post_id='.$this->item_ID
				.'&amp;redirect_to='.rawurlencode(url_rel_to_same_host(regenerate_url('','','','&'), $form_url)) );

		if( $title == '#' ) $title = T_('Send email to comment author');
		if( $text == '#' ) $text = get_icon( 'email', 'imgtag', array( 'class' => 'middle', 'title' => $title ) );

		echo $before;
		echo '<a href="'.$form_url.'" title="'.$title.'"';
		if( !empty( $class ) ) echo ' class="'.$class.'"';
		echo '>'.$text.'</a>';
		echo $after;

		return true;
	}


	/**
	 * Generate permalink to this comment.
	 *
	 * Note: This actually only returns the URL, to get a real link, use Comment::get_permanent_link()
	 */
	function get_permanent_url()
	{
		$this->get_Item();

		$post_permalink = $this->Item->get_single_url( 'auto' );

		return $post_permalink.'#'.$this->get_anchor();
	}


	/**
	 * Template function: display permalink to this comment
	 *
	 * Note: This actually only returns the URL, to get a real link, use Comment::permanent_link()
	 *
	 * @param string 'urltitle', 'pid', 'archive#id' or 'archive#title'
	 * @param string url to use
	 */
	function permanent_url( $mode = '', $blogurl='' )
	{
		echo $this->get_permanent_url( $mode, $blogurl );
	}


	/**
	 * Returns a permalink link to the Comment
	 *
	 * Note: If you only want the permalink URL, use Comment::get_permanent_url()
	 *
	 * @param string link text or special value: '#', '#icon#', '#text#'
	 * @param string link title
	 * @param string class name
	 */
	function get_permanent_link( $text = '#', $title = '#', $class = '', $nofollow = false )
	{
		global $current_User, $baseurl;

		switch( $text )
		{
			case '#':
				$text = get_icon( 'permalink' ).T_('Permalink');
				break;

			case '#icon#':
				$text = get_icon( 'permalink' );
				break;

			case '#text#':
				$text = T_('Permalink');
				break;
		}

		if( $title == '#' ) $title = T_('Permanent link to this comment');

		$url = $this->get_permanent_url();

		// Display as link
		$r = '<a href="'.$url.'" title="'.$title.'"';
		if( !empty( $class ) ) $r .= ' class="'.$class.'"';
		if( !empty( $nofollow ) ) $r .= ' rel="nofollow"';
		$r .= '>'.$text.'</a>';

		return $r;
	}


	/**
	 * Displays a permalink link to the Comment
	 *
	 * Note: If you only want the permalink URL, use Comment::permanent_url()
	 */
	function permanent_link( $params = array() )
	{
		// Make sure we are not missing any param:
		$params = array_merge( array(
				'before'      => ' ',
				'after'       => ' ',
				'text'        => '#',
				'title'       => '#',
				'class'       => '',
				'nofollow'    => false,
			), $params );

		echo $params['before'];
		echo $this->get_permanent_link( $params['text'], $params['title'], $params['class'], $params['nofollow'] );
		echo $params['after'];
	}


	/**
	 * Template function: get content of comment
	 *
	 * @param string Output format, see {@link format_to_output()}
	 * @return string
	 */
	function get_content( $format = 'htmlbody' )
	{
		global $Plugins;

		$comment = $this->content;
		// fp> obsolete: $comment = str_replace('<trackback />', '', $comment);
		$Plugins->trigger_event( 'FilterCommentContent', array( 'data' => & $comment, 'Comment' => $this ) );
		$comment = format_to_output( $comment, $format );

		return $comment;
	}


	/**
	 * Template function: display content of comment
	 *
	 * @param string Output format, see {@link format_to_output()}
	 */
	function content( $format = 'htmlbody' )
	{
		echo $this->get_content( $format );
	}


	/**
	 * Template function: display date (datetime) of comment
	 *
	 * @param string date/time format: leave empty to use locale default date format
	 * @param boolean true if you want GMT
	 */
	function date( $format='', $useGM = false )
	{
		if( empty($format) )
			echo mysql2date( locale_datefmt(), $this->date, $useGM);
		else
			echo mysql2date( $format, $this->date, $useGM);
	}


	/**
	 * Template function: display time (datetime) of comment
	 *
	 * @param string date/time format: leave empty to use locale default time format
	 * @param boolean true if you want GMT
	 */
	function time( $format='', $useGM = false )
	{
		if( empty($format) )
			echo mysql2date( locale_timefmt(), $this->date, $useGM );
		else
			echo mysql2date( $format, $this->date, $useGM );
	}


	/**
	 * Template tag:  display rating
	 */
	function rating( $params = array() )
	{
		if( empty( $this->rating ) )
		{
			return false;
		}

		// Make sure we are not missing any param:
		$params = array_merge( array(
				'before'      => '<div class="comment_rating">',
				'after'       => '</div>',
			), $params );

		echo $params['before'];

		for( $i=1; $i<=5; $i++ )
		{
			if( $i <= $this->rating )
			{
				echo get_icon( 'star_on', 'imgtag', array( 'class'=>'middle' ) );
			}
			else
			{
				echo get_icon( 'star_off', 'imgtag', array( 'class'=>'middle' ) );
			}
		}

		echo $params['after'];
	}

  /**
	 * Rating input
	 */
	function rating_input( $params = array() )
	{
		$params = array_merge( array(
									'before'    => '',
									'after'     => '',
									'label_low'  => T_('Poor'),
									'label_high' => T_('Excellent'),
								), $params );

		echo $params['before'];

		echo $params['label_low'];

		for( $i=1; $i<=5; $i++ )
		{
			echo '<input type="radio" class="radio" name="comment_rating" value="'.$i.'"';
			if( $this->rating == $i )
			{
				echo ' checked="checked"';
			}
			echo ' />';
		}

		echo $params['label_high'];

		echo $params['after'];
	}


  /**
	 * Rating reset input
	 */
	function rating_none_input( $params = array() )
	{
		$params = array_merge( array(
									'before'    => '',
									'after'     => '',
									'label'     => T_('No rating'),
								), $params );

		echo $params['before'];

		echo '<label><input type="radio" class="radio" name="comment_rating" value="0"';
		if( empty($this->rating) )
		{
			echo ' checked="checked"';
		}
		echo ' />';

		echo $params['label'].'</label>';

		echo $params['after'];
	}


	/**
	 * Template function: display status of comment
	 *
	 * Statuses:
	 * - published
	 * - deprecated
	 * - protected
	 * - private
	 * - draft
	 *
	 * @param string Output format, see {@link format_to_output()}
	 */
	function status( $format = 'htmlbody' )
	{
		global $post_statuses;

		if( $format == 'raw' )
		{
			$this->disp( 'status', 'raw' );
		}
		else
		{
			echo format_to_output( $this->get('t_status'), $format );
		}
	}


	/**
	 * Send email notifications to subscribed users:
	 *
	 * @todo fp> SEPARATE MODERATION notifications from SUBSCRIPTION notifications
	 * @todo shall we notify suscribers of blog were this is in extra-cat?
	 * @todo cache message by locale like {@link Item::send_email_notifications()}
	 * @todo dh> Indicator in url to see where the user came from (&from=subnote ["subscription notification"]) - Problem: too long urls.
	 * @todo dh> "Beautify" like {@link Item::send_email_notifications()} ? fp > sure
	 * @todo Should include "visibility status" in the mail to the Item's Author
	 */
	function send_email_notifications()
	{
		global $DB, $admin_url, $debug, $Debuglog;

		$edited_Item = & $this->get_Item();
		$edited_Blog = & $edited_Item->get_Blog();

		$notify_array = array();

		if( $edited_Blog->get_setting( 'allow_subscriptions' ) )
		{	// Get list of users who want to be notfied:
			// TODO: also use extra cats/blogs??
			// So far you get notifications for everything. We'll need a setting to decide if you want to received unmoderated (aka unpublished) comments or not.
			// Note: users receive comments on their own posts. This is done on purpose. Otherwise they think it's broken when they test the app.
			$sql = 'SELECT DISTINCT user_email, user_locale
								FROM T_subscriptions INNER JOIN T_users ON sub_user_ID = user_ID
							 WHERE sub_coll_ID = '.$this->Item->blog_ID.'
							   AND sub_comments <> 0
							   AND LENGTH(TRIM(user_email)) > 0';
			$notify_list = $DB->get_results( $sql );

			// Preprocess list:
			foreach( $notify_list as $notification )
			{
				$notify_array[$notification->user_email] = $notification->user_locale;
			}
		}

		// Check if we need to include the author:
		$item_author_User = & $edited_Item->get_creator_User();
		if( $item_author_User->notify
				&& ( ! empty( $item_author_User->email ) ) )
		{ // Author wants to be notified...
			if( ! ($this->get_author_User() // comment is from registered user
							&& $item_author_User->login == $this->author_User->login) ) // comment is from same user as post
				{	// Author is not commenting on his own post...
					$notify_array[$item_author_User->email] = $item_author_User->locale;
				}
		}

		if( ! count($notify_array) )
		{ // No-one to notify:
			return false;
		}


		/*
		 * We have a list of email addresses to notify:
		 */
		// TODO: dh> this reveals the comments author's email address to all subscribers!!
		//           $notify_from should get used by default, unless the user has opted in to be the sender!
		// fp>If the subscriber has permission to moderate the comments, he SHOULD receive the email address.
		if( $this->get_author_User() )
		{ // Comment from a registered user:
			$mail_from = '"'.$this->author_User->get('preferredname').'" <'.$this->author_User->get('email').'>';
		}
		elseif( ! empty( $this->author_email ) )
		{ // non-member, but with email address:
			$mail_from = "\"$this->author\" <$this->author_email>";
		}
		else
		{ // Fallback (we have no email address):  fp>TODO: or the subscriber is not allowed to view it.
			global $notify_from;
			$mail_from = $notify_from;
		}

		// Send emails:
		foreach( $notify_array as $notify_email => $notify_locale )
		{
			locale_temp_switch($notify_locale);

			switch( $this->type )
			{
				case 'trackback':
					/* TRANS: Subject of the mail to send on new trackbacks. First %s is the blog's shortname, the second %s is the item's title. */
					$subject = T_('[%s] New trackback on "%s"');
					break;

				default:
					/* TRANS: Subject of the mail to send on new comments. First %s is the blog's shortname, the second %s is the item's title. */
					$subject = T_('[%s] New comment on "%s"');
			}

			$subject = sprintf( $subject, $edited_Blog->get('shortname'), $edited_Item->get('title') );

			$notify_message = T_('Blog').': '.$edited_Blog->get('shortname')."\n"
				// Mail bloat: .' ( '.str_replace('&amp;', '&', $edited_Blog->gen_blogurl())." )\n"
				.T_('Post').': '.$edited_Item->get('title')."\n";
				// Mail bloat: .' ( '.str_replace('&amp;', '&', $edited_Item->get_permanent_url())." )\n";
				// TODO: fp> We MAY want to force short URL and avoid it to wrap on a new line in the mail which may prevent people from clicking

			switch( $this->type )
			{
				case 'trackback':
					$user_domain = gethostbyaddr($this->author_IP);
					$notify_message .= T_('Website').": $this->author (IP: $this->author_IP, $user_domain)\n";
					$notify_message .= T_('Url').": $this->author_url\n";
					break;

				default:
					if( $this->get_author_User() )
					{ // Comment from a registered user:
						$notify_message .= T_('Author').': '.$this->author_User->get('preferredname').' ('.$this->author_User->get('login').")\n";
					}
					else
					{ // Comment from visitor:
						$user_domain = gethostbyaddr($this->author_IP);
						$notify_message .= T_('Author').": $this->author (IP: $this->author_IP, $user_domain)\n";
						$notify_message .= T_('Email').": $this->author_email\n";
						$notify_message .= T_('Url').": $this->author_url\n";
					}
			}

			$notify_message .=
				T_('Comment').': '.str_replace('&amp;', '&', $this->get_permanent_url())."\n"
				// TODO: fp> We MAY want to force a short URL and avoid it to wrap on a new line in the mail which may prevent people from clicking
				.$this->get('content')."\n\n"
				.T_('Edit/Delete').': '.$admin_url.'?ctrl=items&blog='.$edited_Blog->ID.'&p='.$edited_Item->ID.'&c=1#c'.$this->ID."\n\n"
				.T_('Edit your subscriptions/notifications').': '.str_replace('&amp;', '&', url_add_param( $edited_Blog->gen_blogurl(), 'disp=subs' ) )."\n";

			if( $debug )
			{
				$mail_dump = "Sending notification to $notify_email:<pre>Subject: $subject\n$notify_message</pre>";

				if( $debug >= 2 )
				{ // output mail content - NOTE: this will kill sending of headers.
					echo "<p>$mail_dump</p>";
				}

				$Debuglog->add( $mail_dump, 'notification' );
			}

			send_mail( $notify_email, $subject, $notify_message, $mail_from );

			locale_restore_previous();
		}
	}


	/**
	 * Trigger event AfterCommentUpdate after calling parent method.
	 *
	 * @return boolean true on success
	 */
	function dbupdate()
	{
		global $Plugins;

		$dbchanges = $this->dbchanges;

		if( $r = parent::dbupdate() )
		{
			$Plugins->trigger_event( 'AfterCommentUpdate', $params = array( 'Comment' => & $this, 'dbchanges' => $dbchanges ) );
		}

		return $r;
	}


	/**
	 * Get karma and set it before adding the Comment to DB.
	 *
	 * @return boolean true on success, false if it did not get inserted
	 */
	function dbinsert()
	{
		/**
		 * @var Plugins
		 */
		global $Plugins;
		global $Settings;

		// Get karma percentage (interval -100 - 100)
		$spam_karma = $Plugins->trigger_karma_collect( 'GetSpamKarmaForComment', array( 'Comment' => & $this ) );

		$this->set_spam_karma( $spam_karma );

		// Change status accordingly:
		if( ! is_null($spam_karma) )
		{
			if( $spam_karma < $Settings->get('antispam_threshold_publish') )
			{ // Publish:
				$this->set( 'status', 'published' );
			}
			elseif( $spam_karma > $Settings->get('antispam_threshold_delete') )
			{ // Delete/No insert:
				return false;
			}
		}

		$dbchanges = $this->dbchanges;

		if( $r = parent::dbinsert() )
		{
			$Plugins->trigger_event( 'AfterCommentInsert', $params = array( 'Comment' => & $this, 'dbchanges' => $dbchanges ) );
		}

		return $r;
	}


	/**
	 * Trigger event AfterCommentDelete after calling parent method.
	 *
	 * @return boolean true on success
	 */
	function dbdelete()
	{
		global $Plugins;

		// remember ID, because parent method resets it to 0
		$old_ID = $this->ID;

		if( $r = parent::dbdelete() )
		{
			// re-set the ID for the Plugin event
			$this->ID = $old_ID;

			$Plugins->trigger_event( 'AfterCommentDelete', $params = array( 'Comment' => & $this ) );

			$this->ID = 0;
		}

		return $r;
	}

}



?>