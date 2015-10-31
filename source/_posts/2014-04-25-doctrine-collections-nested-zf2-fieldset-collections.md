---
title: Doctrine collections and nested ZF2 fieldset collections
date: 2014-04-25T21:54:14.784Z
tags:
    - php
    - zend framework 2
    - doctrine orm
disqus:
    identifier: 2
---
<p>On a recent project, which uses a ZF2 Form+Fieldset+InputFilter confab to hydrate a matching Doctrine ORM object model, I encountered something new: collection instances get shared between collections when using collections inside of collections (Yes, you read that right :P)</p>

<p>The Situation:</p>

<p>In our domain model, Competitions contain one or more Divisions, which themselves contain one or more Teams:</p>

<pre><code>Competition &lt;-- Division &lt;-- Team
</code></pre>

<p>As implemented with ZF2 forms, the <code>CompetitionFieldset</code> contains a <code>Zend\Form\Element\Collection</code> element, which holds all the divisions of the competition as <code>DivisionFieldset</code> instances:</p>

<pre><code>// Competition Fieldset
class CompetitionFieldset extends Fieldset
{
    public function init()
    {
        // snipped for brevity
        // $fsDivision instanceof DivisionFieldset

        $this-&gt;add(array(
            'type'    =&gt; 'Zend\Form\Element\Collection',
            'name'    =&gt; 'divisions',
            'options' =&gt; array(
                'target_element' =&gt; $fsDivision,
            )
        ));
    }
}

// Competition Entity
class CompetitionEntity
{
    protected $divisions;

    public function __construct()
    {
        $this-&gt;divisions = new ArrayCollection();
    }
}
</code></pre>

<p>The Division fieldset itself contains a Collection element holding all of the teams assigned to the division, as instances of <code>TeamFieldset</code></p>

<pre><code>// Division fieldset
class DivisionFieldset extends Fieldset
{
    public function init()
    {
        // snipped for brevity
        // $fsTeam instanceof TeamFieldset

        $this-&gt;add(array(
            'type'    =&gt; 'Zend\Form\Element\Collection',
            'name'    =&gt; 'teams',
            'options' =&gt; array(
                'target_element' =&gt; $fsTeam,
            )
        ));
    }
}

// Division entity
class DivisionEntity
{
    protected $teams;

    public function __construct()
    {
        $this-&gt;teams = new ArrayCollection();
    }
}
</code></pre>

<p>Once everything is collected together into a form and the <code>DoctrineObject</code> hydrators and prototype entity instances are all assigned to the form and it's respective fieldsets, an issue popped up:</p>

<p>When I add multiple divisions to the competition, assign some teams to each one, submit the form and wait for <code>Zend\Form</code> and Doctrine to do their turn-that-POST-nonsense-into-a-PHP-object thing, it goes sideways.  All the divisions I added are properly represented in the <code>CompetitionEntity::divisions</code> collection as distinct <code>DivisionEntity</code> instances, but they all have the same set of <code>TeamEntity</code> objects in their <code>teams</code> collection.  Indeed, all the <code>DivisionEntity</code> objects have the <em>same</em> <code>ArrayCollection</code>.  Why?</p>

<p>The answer is, in hindsight, simple:  <code>Zend\Form\Element\Collection</code> takes the prototype object we gave it's fieldset and <code>clone</code>s it for each element of the <code>divisions</code> array in the POST data.  However, PHP doesn't deep-clone, and so all those clones of <code>DivisionEntity</code> share the same internal instance of <code>ArrayCollection</code> that was assigned to <code>teams</code> in the prototype object.  To prevent this we have to give each clone it's own <code>ArrayCollection</code> instance by adding a <code>__clone</code> method to the class:</p>

<pre><code>class DivisionEntity
{
    protected $teams;

    public function __construct()
    {
        $this-&gt;teams = new ArrayCollection();
    }

    public function __clone()
    {
        $this-&gt;teams = new ArrayCollection();
    }
}
</code></pre>

<p>And Bob's your uncle, all is well once again in ZF2+Doctrine land :)</p>

<p><strong>Summary &amp; TL;DR</strong>: if the object you bind to a fieldset placed in an <code>Zend\Form\Element\Collection</code> element composes other objects, you need to add an <code>__clone</code> method to give each clone their own instance of each associated object, as in the <code>DivisionEntity</code> example above.  </p>