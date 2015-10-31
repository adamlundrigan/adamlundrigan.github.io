---
title: Using OAuth2 JWT with Apigility
date: 2014-11-06T20:00:27.733Z
tags:
    - php
    - zend framework 2
    - apigility
    - oauth2
    - jwt
disqus:
    identifier: 14
---
<p>I'm currently working on a web application which exposes REST and RPC API using <a href="http://apigility.org">Apigility</a>.  The web frontend for this project is built using AngularJS and uses <a href="https://github.com/sahat/satellizer">Satellizer</a> to handle authentication.</p>

<p>Unfortunately Satellizer uses JWT cryptotokens, and Apigility doesn't ship with an easy way to configure the OAuth2 server to use these.  The fix for this?  Quite simple, really.  Apigility defines service factories for all it's internal services, so we can simply define a <a href="http://framework.zend.com/manual/2.3/en/modules/zend.service-manager.delegator-factories.html">service manager delegator factory</a> which injects the <a href="http://bshaffer.github.io/oauth2-server-php-docs/overview/crypto-tokens">necessary configuration</a>.  </p>

<pre><code class="php">&lt;?php
namespace LdcOAuth2CryptoToken\Factory;

use Zend\ServiceManager\DelegatorFactoryInterface;
use Zend\ServiceManager\ServiceLocatorInterface;

class CryptoTokenServerFactory implements DelegatorFactoryInterface
{
    public function createDelegatorWithName(ServiceLocatorInterface $serviceLocator, $name, $requestedName, $callback)
    {
        $server = call_user_func($callback);

        // do dirty, dirty things to $server here

        return $server;
    }
}
</code></pre>

<p>ZF2 rulez!</p>

<p>I've rolled up a <a href="https://github.com/adamlundrigan/LdcOAuth2CryptoToken/blob/master/src/Factory/CryptoTokenServerFactory.php">completed version this factory</a> (+ <a href="https://github.com/zfcampus/zf-mvc-auth/issues/45">a hack for this bug in zf-mvc-auth</a>) into a ZF2 module for your consuming pleasure: </p>

<ul>
<li>GitHub: <a href="https://github.com/adamlundrigan/LdcOAuth2CryptoToken">adamlundrigan/LdcOAuth2CryptoToken</a></li>
<li>Packagist: <a href="https://packagist.org/packages/adamlundrigan/ldc-oauth2-crypto-token">adamlundrigan/ldc-oauth2-crypto-token</a></li>
</ul>