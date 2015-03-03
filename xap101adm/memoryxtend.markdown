---
layout: post101
title:  MemoryXtend
categories: XAP101ADM
parent: none
weight: 430
---

<br>

{% section %}
{% column  width=10% %}
![flash-imdg.png](/attachment_files/subject/flash-imdg.png)
{% endcolumn %}
{%column width=90% %}
XAP 10 introduced a new storage model called BlobStore Storage Model (commonly reffered to as MemoryXtend), which allows an external storage medium (one that does not reside on the JVM heap) to store the IMDG data. This guide describes the general architecture and functionality of this storage model that and its off-heap RAM and SSD implementations.
{% endcolumn %}
{% endsection %}

<br>

{%note%}
This section is under construction !
{%endnote%}

{%fpanel%}

[Overview](./memoryxtend-overview.html)<br>

[Solid State Drive](./memoryxtend-ssd.html)<br>

[Off Heap RAM](./memoryxtend-ohr.html)<br>

{%endfpanel%}

<br>

#### Additional Resources

{%section%}
{%column width=30%  %}
{%youtube kAe-ZxFnIYc | XAP MemoryXtend %}
{%endcolumn%}

{%column width=30%  %}
[{%pdf%}](/download_files/White-Paper-ssd-V2.pdf)
This MemoryXtend white paper provides a high level overview of the technology and motivation behind MemoryXtend.
{%endcolumn%}

{%endsection%}

