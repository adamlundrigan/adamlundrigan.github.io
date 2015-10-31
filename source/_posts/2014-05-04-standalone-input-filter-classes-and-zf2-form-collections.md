---
title: Standalone Input Filter classes and ZF2 Form Collections
date: 2014-05-04T00:02:03.278Z
tags:
    - php
    - zend framework 2
disqus:
    identifier: 10
---
<p>While building some Zend\Form monstrosity with infinite* nested fieldsets and collections every which way I, the form (which uses externally-constructed InputFilters) would fail validation with no visible error messages.  The problem?  I was doing this:</p>

<pre><code class="php">$mainInputFilter = new InputFilter();
// Add the fields of my main-fieldset

$collectionInputFilter = new InputFilter();
// Add the fields of my sub-fieldset

$mainInputFilter-&gt;add($collectionInputFilter, 'collection-name');
</code></pre>

<p>When I should have been doing this:</p>

<pre><code class="php">$mainInputFilter = new InputFilter();
// Add the fields of my main-fieldset

$collectionInputFilter = new InputFilter();
// Add the fields of my sub-fieldset

$collectionContainerFilter = new CollectionInputFilter();
$collectionContainerFilter-&gt;setInputFilter($collectionInputFilter);

$mainInputFilter-&gt;add($collectionContainerFilter, 'collection-name');
</code></pre>

<p>Subtle difference makes all the difference.  The InputFilter for the fieldset representing the elements of your Collection has to be added to a <code>CollectionInputFilter</code>, which then gets added to the InputFilter for the fieldset containing the Collection.  Otherwise the validation will fail, but no errors are passed back to the form from the InputFilter (since no form elements match your mis-configured InputFilter), so you won't see the failed validation messages unless you var_dump a call to <code>$form-&gt;getInputFilter()-&gt;getMessages()</code></p>

<p><em>Reminder to myself: Add this to the ZF2 docs when you get a chance</em></p>

<p>* = Tiny amount of hyperbole</p>