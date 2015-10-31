---
title: Sharing context between separate EventManager triggers
date: 2014-05-30T12:23:39.927Z
tags:
    - php
    - zend framework 2
disqus:
    identifier: 11
---
<p>When building out the service layer I like to wrap each action in event manager triggers so I can extend it's behavior later from other modules without introducing a direct dependency.  One tidbit that the <code>Zend\EventManager</code> docs only mention in passing is that the <code>argv</code> parameter of <code>EventManagerInterface::trigger</code> isn't restricted to array - it can be an object as well.  With one simple deviation from the documented example we can share state between our service class and all event listeners: pass an <code>ArrayObject</code>:</p>

<pre><code class="php">$argv = new \ArrayObjecct();
$argv-&gt;arg1 = '...';
$argv-&gt;arg2 = '...';

$em-&gt;trigger("my.event", $this, $argv);
</code></pre>

<p>Now, when an event listener makes a change to one of the arguments passed into <code>argv</code> of the trigger call the service class will retain those changes so you can use them later. </p>

<p>Here's a generic example of what the <code>update</code> method of a service class generally look like:</p>

<pre><code class="php">&lt;?php
class MyService
{
    public function update($entity, $data)
    {
        $em = $this-&gt;getEventManager();
        $form = $this-&gt;getUpdateForm();
        $mapper = $this-&gt;getRepository();

        $argv = new \ArrayObject();
        $argv-&gt;form = $form;
        $argv-&gt;entity = $entity;
        $argv-&gt;data = $data;

        // Use a Zend\Form to hydrate the entity
        $em-&gt;trigger("update.form.pre", $this, $argv);
        $form-&gt;bind($entity);
        $form-&gt;setData($data);
        $isValid = $argv['formIsValid'] = $form-&gt;isValid();
        $em-&gt;trigger("update.form.post", $this, $argv);

        // Short circuit if validation failed
        if ( ! $isValid ) {
            return false;
        }

        // Extract the hydrated entity and save it
        $entity = $form-&gt;getData();
        $em-&gt;trigger("update.save.pre", $this, $argv);
        $mapper-&gt;save($entity);
        $em-&gt;trigger("update.save.post", $this, $argv);

        return $entity;
    }
}
</code></pre>