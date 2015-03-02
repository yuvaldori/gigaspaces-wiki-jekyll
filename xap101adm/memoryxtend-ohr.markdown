---
layout: post101
title:  Off Heap RAM
categories: XAP101ADM
parent: memoryxtend.html
weight: 300
---

<br>

{%note%}
This section is under construction !
{%endnote%}

{%comment%}

{% section %}
{% column  width=10% %}
![flash-imdg.png](/attachment_files/subject/flash-imdg.png)
{% endcolumn %}
{%column width=90% %}
XAP 10 introduces a new storage model called BlobStore Storage Model, which allows an external storage medium (one that does not reside on the JVM heap) to store the IMDG data. This guide describes the general architecture and functionality of this storage model that is leveraging both on-heap, off-heap and SSD implementation, called `MemoryXtend`.
{% endcolumn %}
{% endsection %}

{%endcomment%}

<br>

{%fpanel%}

{%comment%}
[BlobStore Storage Model Overview](./blobstore-cache-policy.html)<br>
Overview and introduction to MemoryXtend.

[Advanced Tuning Guide](./blobstore-tuning-guide.html)<br>
Tuning options for MemoryXtend.

[Troubleshooting](./blobstore-trouble-shooting.html)<br>
How to troubleshoot common problems.

{%endcomment%}

{%endfpanel%}

<br>


