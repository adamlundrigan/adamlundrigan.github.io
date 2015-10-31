---
title: Using Zend_Captcha_ReCaptcha
date: 2010-11-29T19:05:00.000Z
tags:
    - php
    - zend framework 1
disqus:
    identifier: 7
---
<p>Short introduction to using <code>Zend_Captcha_ReCaptcha</code> as a standalone entity.  The Zend Framework manual does not cover the use of this component well; I am working on writing a more detailed manual entry for it, of which this is the first step. </p>

<p>This tutorial is aimed at developers who are introducing <a href="http://framework.zend.com/" target="_blank">Zend Framework (ZF)</a> components into existing non-ZF web sites (like me!), however it can easily be adapted for those who are creating new web sites based on ZF (ie: using Zend_Application). </p>

<h3 id="step1createserviceobject">Step 1: Create Service Object</h3>

<p>Zend_Captcha_ReCaptcha communicates with Google's reCAPTCHA service via the <code>Zend_Service_ReCaptcha</code> class:</p>

<pre><code>$recaptcha_service = new Zend_Service_ReCaptcha(
    $rcPublicKey,
    $rcPrivateKey
);
</code></pre>

<p>Where <code>$rcPublicKey</code> and <code>$rcPrivateKey</code> are your public and private keys, respectively.</p>

<p>Short introduction to using <code>Zend_Captcha_ReCaptcha</code>.</p>

<h3 id="step2createinstanceofcaptcha">Step 2: Create instance of CAPTCHA</h3>

<pre><code>$adapter = new Zend_Captcha_ReCaptcha();
$adapter-&gt;setService( $recaptcha_service );
</code></pre>

<p>There are additional options you can provide to <code>$adapter</code>, <a target="_blank" href="http://framework.zend.com/apidoc/core/Zend_Captcha/Adapter/Zend_Captcha_ReCaptcha.html">all of which are documented in the API guide</a>.  If you are using <code>Zend_Controller</code> and <code>Zend_View</code>, this is the object you would assign to your view.  </p>

<h3 id="step3displayingthecaptcha">Step 3: Displaying the CAPTCHA</h3>

<p>In the HTML page for your form, call the render function of $adapter to display the CAPTCHA:</p>

<pre><code>echo $adapter-&gt;render();
</code></pre>

<h3 id="step4captchavalidation">Step 4: CAPTCHA Validation</h3>

<p>In the PHP code which validates the form to which you added the CAPTCHA in Step 3, add the following to your validation routine:</p>

<pre><code>$reUserData = array(
    'recaptcha_challenge_field' =&gt; $_POST['recaptcha_challenge_field'],
    'recaptcha_response_field' =&gt; $_POST['recaptcha_response_field']
);
if ( $adapter-&gt;isValid($reUserData) !== true )
{
    // Handle validation error
}
</code></pre>

<p>The important part to note here is that <code>isValid()</code> requires an associative array of the two reCAPTCHA form inputs, which neither the Zend Framework manual nor API guide stipulate.  </p>