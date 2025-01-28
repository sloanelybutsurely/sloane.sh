---
layout: default
title: posts
permalink: /posts/
---

<ul class="h-feed">
  {% for post in site.posts %}
    <li class="h-entry">
      <a class="u-url p-name" href="{{ post.url }}">{{ post.title | smartify }}</a>
    </li>
  {% endfor %}
</ul>
