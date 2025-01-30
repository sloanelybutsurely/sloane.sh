---
layout: default
title: micro
permalink: /micro/
---

<div class="h-feed">
  {% for post in site.categories.micro %}
    <article class="h-entry">
      <p class="e-content">{{ post.content }}</p>
      <a class="u-url" href="{{ post.url }}">{{ post.date | date: "%B %e, %Y %r" }}</a>
    </article>
    <hr />
  {% endfor %}
</div>
