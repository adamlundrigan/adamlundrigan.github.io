---
title: Load testing by replaying Apache HTTPD access logs
date: 2012-02-13T03:30:00.000Z
tags:
    - apache2
    - devops
disqus:
    identifier: 5
---
<p>Two weeks ago I oversaw the launch of our new public web site. The whole exercise was an unparalleled failure; as soon as the first peak load hit the server took a prolonged lie-down, and so the site was generally unreachable for end users. What went wrong? I didn’t adequately load test the application to ensure our production environment could cope before rolling it out.</p>

<p>I’ve learned much from that mistake, and regular load testing will now be part of our regular release process. On top of using ab and siege to pummel our staging environment before the code is promoted to production status, I wanted to add an extra comfort layer: replaying a sample of traffic to our production environment against staging. After much searching, I didn’t find anything that really fit the bill perfectly. So, I hacked together a simple Node.js-based application to do it: <a href="https://github.com/adamlundrigan/nodejs-logreplay">nodejs-logreplay</a></p>

<blockquote>
  <p><a href="https://github.com/adamlundrigan/nodejs-logreplay">Get the source code from GitHub</a></p>
</blockquote>