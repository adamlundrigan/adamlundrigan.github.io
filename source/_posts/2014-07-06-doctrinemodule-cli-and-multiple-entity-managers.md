---
title: DoctrineModule CLI and multiple entity managers
date: 2014-07-06T01:32:28.450Z
tags:
    - php
    - zend framework 2
    - doctrine orm
disqus:
    identifier: 13
---
<p>In working on a project I came across <a href="https://github.com/doctrine/DoctrineORMModule/issues/97">this issue with DoctrineModule</a> - it's Doctrine CLI doesn't support multiple entity managers.  In my project each module uses it's own sandboxed Doctrine config, and this works fine when testing or actually using the application.  However, when deploying the application to a staging server <code>bin/doctrine orm:schema-tool:create</code> complained about having no managed entities; it was looking in <code>orm_default</code> and not finding anything.</p>

<p>Long and short of it is if you're also having this issue, here's a quick hack that will allow you to work around it:</p>

<p><a href='https://gist.github.com/adamlundrigan/c0c87fc5657453212cd0'>https://gist.github.com/adamlundrigan/c0c87fc5657453212cd0</a></p>

<p>Essentially, i've just taken the stock <code>doctrine-module.php</code> file from DoctrineModule and added this immediately after the CLI application is initialized:</p>

<pre><code>// If we've overridden the entity manager via env var, inject the new one
$entityManagerName = getenv('EM_ALIAS') ?: 'orm_default';
if ( $application-&gt;getServiceManager()-&gt;has($entityManagerName) ) {
    $emHelper = new EntityManagerHelper($application-&gt;getServiceManager()-&gt;get($entityManagerName));
    $cli-&gt;getHelperSet()-&gt;set($emHelper, 'em');
}
</code></pre>

<p>Which creates a new <a href="https://github.com/doctrine/doctrine2/blob/master/lib/Doctrine/ORM/Tools/Console/Helper/EntityManagerHelper.php"><code>EntityManagerHelper</code></a> and stores it as <code>em</code> in the CLI helper set. </p>