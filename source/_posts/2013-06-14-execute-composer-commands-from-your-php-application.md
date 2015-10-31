---
title: Execute Composer commands from your PHP application
date: 2013-06-14T00:22:00.000Z
tags:
    - php
    - zend framework 2
disqus:
    identifier: 8
---

<p>I'll just leave this here...</p>

<h3 id="exampleclonezf2szendskeletonapplication">Example: Clone ZF2's ZendSkeletonApplication</h3>

<p>ZendSkeletonApplication is installed using this composer command line:</p>

<pre><code>php composer.phar create-project -sdev --repository-url="http://packages.zendframework.com" zendframework/skeleton-application /path/to/skeleton-application
</code></pre>

<p>The equivalent using Composer source is:</p>

<pre><code>$obj = new \Composer\Command\CreateProjectCommand();
$input = new \Symfony\Component\Console\Input\ArrayInput(array(
    'package'          =&gt; 'zendframework/skeleton-application',
    'directory'        =&gt; '/path/to/skeleton-application',
    '--stability'      =&gt; 'dev',
    '--repository-url' =&gt; 'http://packages.zendframework.com',
), $obj-&gt;getDefinition());
$output = new \Symfony\Component\Console\Output\ConsoleOutput();
$obj-&gt;run($input,$output);
</code></pre>