---
layout: page
title: Home
id: home
permalink: /
---


# Welcome! 🌱

<header class="site-category">  
    {% assign categories = "" %} 
    {% for note in site.notes %} 
        {% assign categories = categories | concat: note.categories %} 
    {% endfor %}
    
    {% assign categories = categories | uniq %}
        
    {% for each in categories %}
        <h3>{{ each }} </h3>
        <ul>
        {% for note in site.notes %}
            {% if note.categories contains each %}
                <li><a href="{{ note.url }}">{{ note.title }}</a></li>
            {% endif %}
        {% endfor %}
    </ul>
    {% endfor %}
</header>

<style>
  .wrapper {
    max-width: 46em;
  }
</style>
