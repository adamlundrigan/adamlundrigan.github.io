---
title: Zend\Form, Nonuniform Collections and You
date: 2014-06-24T02:15:19.837Z
tags:
    - php
    - zend framework 2
    - doctrine orm
disqus:
    identifier: 12
---
<p>I'm a fan of, in no particular order, <a href="https://github.com/zendframework/zf2">ZF2</a>'s <a href="http://framework.zend.com/manual/2.3/en/modules/zend.form.quick-start.html">Form</a> component, <a href="http://github.com/doctrine/doctrine2">Doctrine ORM</a> and <a href="https://github.com/adamlundrigan/LdcServiceBuilder">classy service layers</a>.  What can I say?  My brain runs on PHP, but my heart belongs with Java 😛.  </p>

<p>One of the things I like most about Doctrine ORM is <a href="http://docs.doctrine-project.org/en/2.0.x/reference/inheritance-mapping.html">Inheritance Mapping</a> &mdash; more specifically, <a href="http://docs.doctrine-project.org/en/2.0.x/reference/inheritance-mapping.html#class-table-inheritance">Class Table Inheritance</a>.  Since you've made it this far I won't bore you with the details, except to say it allows you to build a ToMany association to a group of related entity classes and treat instances as a single collection.  I think that's awesome...unfortunately Zend\Form does not: it's Collection class will only accept a single Fieldset prototype. </p>

<p>So, what did I do?  I hacked it, and the result is <a href="https://packagist.org/packages/adamlundrigan/ldc-zend-form-cti"><code>LdcZendFormCTI</code></a> (rolls right off the tongue, it does).  Install it via Composer:</p>

<pre><code>composer require adamlundrigan/ldc-zend-form-cti:@stable
</code></pre>

<p>And now your form collection elements can have super more-than-just-one-fieldset-prototype powers too!  Just add an instanceof <a href="https://github.com/adamlundrigan/LdcZendFormCTI/blob/master/src/Form/Element/NonuniformCollection.php"><code>NonuniformCollection</code></a> to a fieldset, populate it with a prototype <a href="https://github.com/adamlundrigan/LdcZendFormCTI/blob/master/tests/LdcZendFormCTITest/TestCase.php#L141">fieldset+hydrator+object</a> matching each child entity in the inheritance scheme, and Bob's your uncle!  There's also a <a href="https://github.com/adamlundrigan/LdcZendFormCTI/blob/master/src/InputFilter/NonuniformCollectionInputFilter.php"><code>NonuniformCollectionInputFilter</code></a> for configuring filtering and validation, if you're into that sort of thing. </p>

<p>It's a little light on documentation at present, but you can get the gist of how to use it from <a href="https://github.com/adamlundrigan/LdcZendFormCTI/blob/master/tests/LdcZendFormCTITest/TestCase.php#L145">the bundled tests</a>.  I'm working on a README and a simple demo application to show how it all fits together, both of which should be ready soonish. </p>