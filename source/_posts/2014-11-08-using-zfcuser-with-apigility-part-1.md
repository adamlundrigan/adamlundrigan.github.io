---
title: Using ZfcUser with Apigility, Part 1
date: 2014-11-08T16:17:50.678Z
tags:
    - php
    - zend framework 2
    - apigility
    - oauth2
    - zfcuser
disqus:
    identifier: 15
---
<p>As part of my ongoing quest to build out a REST and RPC API using <a href="http://apigility.org">Apigility</a>, I've been working on integrating <a href="https://github.com/zf-commons/ZfcUser">ZfcUser</a> into an Apigility application.  The first fruit of this labour &mdash; <a href="https://github.com/adamlundrigan/LdcZfcUserOAuth2">LdcZfcUserOAuth2</a> &mdash; is now available on my GitHub.</p>

<h2 id="whatisit">What is it?</h2>

<p><a href="https://github.com/adamlundrigan/LdcZfcUserOAuth2">LdcZfcUserOAuth2</a> is a module which integrates ZfcUser into the OAuth2 authentication process (<code>zf-oauth2</code> module).  This is accomplished by creating a <a href="https://github.com/adamlundrigan/LdcZfcUserOAuth2/blob/master/src/Storage/ZfcUserPdo.php">custom storage adapter</a> for <a href="https://github.com/bshaffer/oauth2-server-php"><code>oauth2-server-php</code></a> which delegates the account lookup and authentication to ZfcUser.  A <a href="https://github.com/adamlundrigan/LdcZfcUserOAuth2/blob/master/src/Authentication/Adapter/Db.php">custom authentication adapter</a> is also injected into ZfcUser's authentication chain to override the hard-coded references to <code>Zend\Session</code>.</p>

<p>This module should also work with <code>ZfcUserDoctrineORM</code> and <code>ZfcUserDoctrineMongoODM</code> I, though haven't yet tested that myself. </p>

<h2 id="howdoigetit">How do I get it?</h2>

<p>GitHub: <a href="https://github.com/adamlundrigan/LdcZfcUserOAuth2">LdcZfcUserOAuth2</a> <br />
Packagist: <a href="https://packagist.org/packages/adamlundrigan/ldc-zfc-user-oauth2">adamlundrigan/ldc-zfc-user-oauth2</a></p>