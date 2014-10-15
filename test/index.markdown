---
layout: post
title:  Test Page
categories: HOWTO
---


{% summary page %}This article shows how to  use the Spring Cache Abstraction Provider with  XAP{% endsummary %}

{% tip %}
 **Author**:  Ali Hodroj, Director of Solution Architecture, GigaSpaces<br/>
 **Recently tested with XAP version**: XAP 9.7<br/>
 **Last Update:** Feb 2014<br/>
{% endtip %}


# Properties with accordion

{% accordion id=acc0 %}
{%accord parent=acc0 | title=com.gs.transport_protocol.lrmi.max-conn-pool %}
The maximum amount of connections to the space server remote services that can work simultaneously in a client connection pool.
Starts with 1 connection. Defined per each remote service (by default, each remote service has **1024** maximum connections).

{: .table  .table-condensed}
|  Unit     | Default | Server / Client | Can be overridden by client|
|Connection| 1024    | Server          |  No |
{% endaccord %}

{%accord parent=acc0 | title=com.gs.transport_protocol.lrmi.min-threads %}
XAP maintains a thread pool in the client and server side, that manages incoming remote requests.
The thread pool size is increased each time with one additional thread and shrinks when existing threads are not used for 5 minutes.
This parameter specifies the minimum size of this thread pool.

{: .table   .table-condensed}
| Unit     | Default | Server / Client | Can be overridden by client|
|Threads| 1    | Server          |  No |
{% endaccord %}

{%accord parent=acc0 | title=com.gs.transport_protocol.lrmi.max-threads %}
This parameter specifies the maximum size of a thread pool used to serve remote write , writeMultiple, read , readMultiple , take , takeMultiple , clear , min, max , sum , average,  aggregate , custom aggregators , custom change, count and change operations.{% wbr %}Make sure the maximum size of the thread pool accommodates the maximum number of concurrent requests to the space.
The client uses this pool for server requests into the client side - i.e. notify callbacks. When the pool is exhausted and all threads are consumed to process incoming requests, additional requests are blocked until existing requested processing are complete. Using a value as **1024** for the LRMI Connection Thread Pool should be sufficient for most large scale systems.

{: .table   .table-condensed}
| Unit     | Default | Server / Client | Can be overridden by client|
|Threads| 128   | Server          |  No |
{% endaccord %}
{%endaccordion%}


# Table format

{: .table  .table-bordered  .table-condensed}
|Property name| com.gs.transport_protocol.lrmi.max-threads|
|Description |This parameter specifies the maximum size of a thread pool used to serve remote write , writeMultiple, read , readMultiple , take , takeMultiple , clear , min, max , sum , average,  aggregate , custom aggregators , custom change, count and change operations.{% wbr %}Make sure the maximum size of the thread pool accommodates the maximum number of concurrent requests to the space. The client uses this pool for server requests into the client side - i.e. notify callbacks. When the pool is exhausted and all threads are consumed to process incoming requests, additional requests are blocked until existing requested processing are complete. Using a value as **1024** for the LRMI Connection Thread Pool should be sufficient for most large scale systems.|
| Unit     |  Threads|
|Default |    128 |
|Server / Client | Server|
|<nobr>Client override</nobr>| No |



# LRMI

{%panel bgColor=white | title=com.gs.transport_protocol.lrmi.min-threads%}

{%inittab%}
{%tabcontent  Description%}
XAP maintains a thread pool in the client and server side, that manages incoming remote requests.
The thread pool size is increased each time with one additional thread and shrinks when existing threads are not used for 5 minutes.
This parameter specifies the minimum size of this thread pool.
{%endtabcontent%}

{%tabcontent  Values%}
{: .table   .table-condensed}
| Unit     | Default | Server / Client | Can be overridden by client|
|Threads| 1    | Server          |  No |
{%endtabcontent%}
{%endinittab%}
{%endpanel%}

{%panel bgColor=white | title=com.gs.transport_protocol.lrmi.max-threads%}

{%inittab%}
{%tabcontent  Description%}
This parameter specifies the maximum size of a thread pool used to serve remote write , writeMultiple, read , readMultiple , take , takeMultiple , clear , min, max , sum , average,  aggregate , custom aggregators , custom change, count and change operations.{% wbr %}Make sure the maximum size of the thread pool accommodates the maximum number of concurrent requests to the space. The client uses this pool for server requests into the client side - i.e. notify callbacks. When the pool is exhausted and all threads are consumed to process incoming requests, additional requests are blocked until existing requested processing are complete. Using a value as **1024** for the LRMI Connection Thread Pool should be sufficient for most large scale systems.
{%endtabcontent%}

{%tabcontent  Values%}
{: .table   .table-condensed}
| Unit     | Default | Server / Client | Can be overridden by client|
|Threads| 128   | Server          |  No |
{%endtabcontent%}
{%endinittab%}

{%endpanel%}


# Tab in Tab

{% accordion id=chris%}
{% accord title=Java | parent=chris %}
dfdsfdnfndfnnd,sf
 dsfdfdkfkldkfkd;lf
 fkdskfldkflkdlf
{% endaccord%}
{% accord title=C#  | parent=chris%}
hggjgjgjgjgj
{% endaccord%}
{% accord title=c++ | parent=chris%}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% accord title=Scala | parent=chris%}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% endaccordion %}



# Tab in Tab  2

{% accordion id=chrisroffler%}
{% accord title=Java1 | parent=chrisroffler %}
dfdsfdnfndfnnd,sf
 dsfdfdkfkldkfkd;lf
 fkdskfldkflkdlf
{% endaccord%}
{% accord title=C#1  | parent=chrisroffler%}
hggjgjgjgjgj
{% endaccord%}
{% accord title=c++1 | parent=chrisroffler%}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
sadsad
dsad
sad
sa
dsa
d
sad
sa
d
sad
sad
sa

{% endaccord%}
{% accord title=Scala1 | parent=chrisroffler%}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% endaccordion %}





{%try%}http://www.google.com{%endtry%}

{%learn%}/xap97/qsg-part-9.html{%endlearn%}


# Indent


{%indent 30 %}I ma indented {%endindent%}

{%summary%}This is a test page {%endsummary%}

# Notes and tips

{%exclamation%} This is an exclamation mark !

{%info%}this is an information {%endinfo%}

{%note%}this is an note {%endnote%}

{%tip%}This is a tip {%endtip%}

{%quote%}This is a quote{%endquote%}

{%warning%}This is a warning{%endwarning%}

{%remove%} This is a remove

{%plus%}This is a plus sign

{%question%}This is a question

{%lampon%}Lamp on

{%lampoff%}Lamp off

{%infosign%} This is an info sign

{%star%} This is a star

{%oksign%} This is an OK sign

{%sub%} This is a sub  {%endsub%}

{%refer%} This is refer   {%endrefer%}


# Anchor

[Layouts](#layout)

{%comment%} Make sure that there is an empty line below the anchor tag !!!!!!{%endcomment%}

# Layouts

{%anchor layout%}

## Section

{%section%}
{%column width=20% %}
Hello there this is a column 1
{%endcolumn%}
{%column width=70% %}
Hello there this is another column  2
{%endcolumn%}
{%endsection%}


## Panel
{% panel title=This is a panel title| borderStyle=solid|borderColor=#3c78b5|bgColor=#FFFFCE %}
Panel content
{%endpanel%}


## Table

{: .table .table-bordered .table-responsive .table-striped}
| Hello | Title |   Column
|:-----|:-------|:-----------|
| testfsdfdfdsfdsf | tessdsdsadsadsadsadsasat 1 | tesdsfdsfdsfdfdfdfdfdhfhdfhdhfhdjhfjdhjfhdkhfkdhfkjdhjfhdjhfdhfjhdjfhdshfdjhfhdkjfjdhsjfhdksft2|
| testfdsfdsfdsfdsfds | tessdsdsadsadsadsadsasat 1 | tesdsfdsfdsfdfdfdfdfdhfhdfhdhfhdjhfjdhjfhdkhfkdhfkjdhjfhdjhfdhfjhdjfhdshfdjhfhdkjfjdhsjfhdksft2|


## Tabbed pane

{% inittab Java |top %}
{% tabcontent Java %}
Some code
{% endtabcontent %}
{% tabcontent XML %}
Some code
{% endtabcontent %}
{% endinittab %}

# Bookmarks

{%bookmarks%}


# Code

{%highlight java%}
public void getIt()
{
    System.out.println();
}
{%endhighlight%}


# Link

[SpaceDocument](./about-jini.html)

# Image

![archi_overview.jpg](/attachment_files/archi_overview.jpg)

# Image Gallery

{% gallery %}

[![ide-0.jpg](/attachment_files/ide-0.jpg)](/attachment_files/ide-0.jpg)
IMG101.jpg

[![ide-1.jpg](/attachment_files/ide-1.jpg)](/attachment_files/ide-1.jpg)
IMG103.jpg

[![ide-2.jpg](/attachment_files/ide-2.jpg)](/attachment_files/ide-2.jpg)
IMG200.png


{% endgallery %}


# Gist
{% gist 1027674 %}


{% inittab %}
{% tabcontent Java %}
 This is tab Foo {% endtabcontent %}
{% tabcontent C# %}
This is tab C# {% endtabcontent %}
{% endinittab %}


{%comment%}
### Platform Configuration

You will find the platform specific configuration under GS_HOME\NET v....\Config\Settings.xml.


{%include /COM/xap97source/dotnet/Settings-xml.markdown %}

{%endcomment%}




