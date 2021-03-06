<?php
/**
 * Experimental Sitemap Stub for a SINGLE BLOG
 *
 * It seems that Google won't index a sitemap with a ? in it. So you need a stub.
 */
require_once dirname(__FILE__).'/conf/_config.php';

# First, select which blog you want to map
# You can find these numbers in the back-office under the Blogs section.
# You can also create new blogs over there. If you do, you may duplicate this file for the new blog.
$blog = 1;

# Let's force the use of the sitemap skin:
$tempskin = '_sitemap';

# Here you can set a limit before which posts will be ignored
# You can use a unix timestamp value or 'now' which will hide all posts in the past
$timestamp_min = '';

# Here you can set a limit after which posts will be ignored
# You can use a unix timestamp value or 'now' which will hide all posts in the future
$timestamp_max = 'now';

# Sitemap spec requires UTF-8, so let's force all outputs to UTF-8:
$force_io_charset_if_accepted = 'utf-8';

// We don't want _blog_main to try any extra path resolution
$resolve_extra_path = false;

require $inc_path.'_blog_main.inc.php';
?>