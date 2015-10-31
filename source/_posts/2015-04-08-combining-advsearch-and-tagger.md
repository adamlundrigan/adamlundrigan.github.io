---
title: MODX: Combining AdvSearch and Tagger
date: 2015-04-08T19:16:18.310Z
tags:
    - php
    - modx
disqus:
    identifier: 19
---
<p>A recent client project took me down the path of integrating <a href="http://modx.com/extras/package/advsearch">AdvSearch</a> and <a href="http://modx.com/extras/package/tagger">Tagger</a> with the goal of allowing users to search for a page by tag.  It took much digging (including <a href="https://web.archive.org/web/20130301192620/http://www.revo.wangba.fr/assets/files/advsearch/advsearchHook120_v1.0.pdf">a trip to the Wayback Machine for some lost AdvSearch documentation</a>) but this is the solution I came up with:</p>

<p>Once you have both AdvSearch and Tagger installed and working, all you need to do is create this MODX snippet:</p>

<pre><code class="php">&lt;?php

$modxTablePrefix = 'modx_';
$taggerModelPath = '{core_path}components/tagger/model/';

$hook-&gt;setQueryHook(array(
    'qhVersion' =&gt; '1.2',
    'joined' =&gt; array(
        array(
            'package' =&gt; 'tagger',
            'class' =&gt; 'TaggerTagResource',
            'packagePath' =&gt; $taggerModelPath,
            'withFields' =&gt; 'resource',
            'tablePrefix' =&gt; $modxTablePrefix,
            'joinCriteria' =&gt; 'TaggerTagResource.resource = modResource.id'
        ),
        array(
            'package' =&gt; 'tagger',
            'class' =&gt; 'TaggerTag',
            'packagePath' =&gt; $taggerModelPath,
            'withFields' =&gt; 'tag',
            'tablePrefix' =&gt; $modxTablePrefix,
            'joinCriteria' =&gt; 'TaggerTag.id = TaggerTagResource.tag'
        ),
    )
));

return true;
</code></pre>

<p>Then add it to your AdvSearch call as a <code>queryHook</code>:</p>

<pre><code>[[!AdvSearch? &amp;queryHook=`your_snippet_name_here`]]
</code></pre>

<p>...and, voila, any pages which have tags matching a search term will now show up in the AdvSearch search results!</p>