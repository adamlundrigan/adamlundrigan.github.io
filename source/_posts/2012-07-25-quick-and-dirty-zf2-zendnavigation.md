---
title: Quick-and-dirty ZF2: Zend\Navigation
date: 2012-07-25T19:37:00.000Z
tags:
    - php
    - zend framework 2
disqus:
    identifier: 4
---

<p>Quick-and-dirty introduction to using Zend\Navigation in Zend Framework 2.</p>

<h2 id="1addservicemanagerfactory">(1) Add Service Manager Factory</h2>

<p>Add the following to your module configuration file (<code>config/module.config.php</code>) or place it in an autoloadable file in your application's <code>config/autoload</code> folder:</p>

<pre><code>'service_manager' =&gt; array(
    'factories' =&gt; array(
        'Navigation' =&gt; 'Zend\Navigation\Service\DefaultNavigationFactory',
    ),
);
</code></pre>

<p>This tells ZF2′s Serivce Manager to load the default Zend\Navigation instance factory. This factory will read a page tree from the application configuration and register a new instance of the navigation data container (<code>Zend\Navigation\Navigation</code>) with the service manager under the name <code>Navigation</code>.</p>

<h2 id="2configuresitemap">(2) Configure Sitemap</h2>

<p>For each module in your application you will need to construct a sitemap for the routes exposed by that module. As an example, here is one that I use with <a href="https://github.com/ZF-Commons/ZfcUser">ZfcUser</a> in my own application:</p>

<pre><code>&lt;?php
// config/autoload/nav_zfcuser.global.php
return array(
    // All navigation-related configuration is collected in the 'navigation' key
    'navigation' =&gt; array(
        // The DefaultNavigationFactory we configured in (1) uses 'default' as the sitemap key
        'default' =&gt; array(
            // And finally, here is where we define our page hierarchy
            'account' =&gt; array(
                'label' =&gt; 'Account',
                'route' =&gt; 'zfcuser',
                'pages' =&gt; array(
                    'home' =&gt; array(
                        'label' =&gt; 'Dashboard',
                        'route' =&gt; 'zfcuser',
                    ),
                    'login' =&gt; array(
                        'label' =&gt; 'Sign In',
                        'route' =&gt; 'zfcuser/login',
                    ),
                    'logout' =&gt; array(
                        'label' =&gt; 'Sign Out',
                        'route' =&gt; 'zfcuser/logout',
                    ),
                    'register' =&gt; array(
                        'label' =&gt; 'Register',
                        'route' =&gt; 'zfcuser/register',
                    ),
                ),
            ),
        ),
    ),
);
</code></pre>

<h2 id="3usingtheviewhelpers">(3) Using the View Helpers</h2>

<p>Now that you’ve set up the necessary configuration, all that’s left to do is use it! There are a <a href="https://github.com/zendframework/zf2/tree/master/library/Zend/View/Helper/Navigation">number of bundled view helpers</a> which you can use to inject navigation components into your views.</p>

<h3 id="examplebreadcrumbs">Example: Breadcrumbs</h3>

<p>To render breadcrumbs add the following line to one of your views (I put it in my application’s layout view):</p>

<pre><code>&lt;?php echo $this-&gt;navigation('Navigation')-&gt;breadcrumbs(); ?&gt;
</code></pre>

<h3 id="examplemenu">Example: Menu</h3>

<p>To render a sidebar navigation menu, add the following line to the location in your view script where you want the menu rendered:</p>

<pre><code>&lt;?php echo $this-&gt;navigation('Navigation')-&gt;menu(); ?&gt;
</code></pre>

<p>This view helper also provides additional methods for altering the output. For example, to display only the active branch of the menu, append the call setOnlyActiveBranch(true) like so:</p>

<pre><code>&lt;?php echo $this-&gt;navigation('Navigation')-&gt;menu()-&gt;setOnlyActiveBranch(true); ?&gt;
</code></pre>