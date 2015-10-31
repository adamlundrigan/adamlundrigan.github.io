---
title: Nested controllers in Zend Framework!
date: 2011-05-27T14:18:00.000Z
tags:
    - php
    - zend framework 1
disqus:
    identifier: 7
---
<p>Did you know that action controllers in Zend Framework can be nested (ie: placed in sub-directories within the controllers directory)?  Neither did I!  This undocumented feature was pointed out to me during a recent conversation with Ryan Mauger (bittarman) and Matthew Weier O'Phinney (weierophinney) on the <code>#zftalk.dev</code> IRC channel.  Needless to say, this made my day!</p>

<p>However, they also pointed out that the default router does not handle routing to these nested controllers in a "pretty" fashion.  For example, a nested controller <code>Admin_Page_SubPageController</code> (<code>modules/admin/controllers/Page/SubPageController.php</code>) would be accessed via the URI <code>admin/page_sub-page/:action</code>.  This could be avoided by creating a custom route for each nested controller, and Ryan kindly provided an example in which he hand-coded a route for each nested controller in a bootstrap method.  This approach, however, will add a lot of bulk to the bootstrap if you have many nested controllers.  The solution: automate it!</p>

<p>I took Ryan's example, mixed in Matthew's <a href="http://weierophinney.net/matthew/archives/262-Backported-ZF2-Autoloaders.html" target="_blank">backported ZF2 classmap-based autoloader</a>, and created a bootstrap resource plugin which uses classmaps to automatically generate the necessary routes for you.  I've posted the result, along with a sample application showing how to use it, on github: </p>

<p><a href="https://github.com/adamlundrigan/zf1-nestedcontrollers">https://github.com/adamlundrigan/zf1-nestedcontrollers</a></p>