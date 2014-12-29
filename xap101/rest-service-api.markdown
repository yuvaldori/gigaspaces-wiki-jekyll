---
layout: post101
title:  REST API
categories: XAP101
parent: rest-service-overview.html
weight: 400
---




{%section%}
{%column width=10% %}
![data-access.jpg](/attachment_files/web-services.jpg)
{%endcolumn%}
{%column width=90% %}
{% summary  %}{% endsummary %}
{%endcolumn%}
{%endsection%}


The REST API exposing HTTP based interface Space. It is leveraging the [XAP API](./the-gigaspace-interface.html). It support the following methods:

1. GET - can be used to perform an introduceType, readByID or a readMultiple action by a space query.
1. POST - can be used to perform a write / writeMultiple or update / updateMultiple actions.
1. DELETE - can be used to perform take / takeMultiple actions either by ID or by a space query.

<br/>


# Introduce Type

{: .table .table-bordered .table-condensed}
|Description |Introduce the specific type to space by registering it and setting the SpaceId and RoutingId to `id` unless a query parameter "id" is provided.|
|Request URL| GET http://localhost:8080/{Type}/_introduce_type  |
|<nobr>Request Query Parameters</nobr>|spaceid - The [SpaceId](./space-object-id-operations.html) attribute of the type |

Response Schema:
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}

Examples:
{% highlight bash %}
http://localhost:8080/MyObject/_introduce_type
http://localhost:8080/MyObject/_introduce_type?spaceid=id
{% endhighlight %}


{%comment%}
{% togglecloak id=1 %}- Introduce Type{% endtogglecloak %}
{% gcloak 1 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Introduce the specific type to space by registering it and setting the SpaceId and RoutingId to `id` unless a query parameter "id" is provided.
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
GET http://localhost:8080/{Type}/_introduce_type
{% endhighlight %}

####Request Query Parameters
spaceid - The [SpaceId](./space-object-id-operations.html) attribute of the type
{%endpanel%}

{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
http://localhost:8080/MyObject/_introduce_type
http://localhost:8080/MyObject/_introduce_type?spaceid=id
{% endhighlight %}
{%endpanel%}
{% endgcloak %}

{%endcomment%}

# Single Write

{: .table .table-bordered .table-condensed}
|Description | Write single entry to the space.|
|Request URL | POST http://localhost:8080/{Type}/ |
|Request Headers|Content-Type: application/json   |
|Request Body | JSON object representation of a SpaceDocument object.|

Response Schema:
{% highlight json %}
{
   "status":"success"
}
{%endhighlight%}

Examples:
{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '{"id":"1", "data":"testdata", "data2":"common", "nestedData" : {"nestedKey1":"nestedValue1"}}' http://localhost:8080/MyObject
{% endhighlight %}


{%comment%}
{% togglecloak id=21 %}- Single Write{% endtogglecloak %}
{% gcloak 21 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Write single entry to the space.
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
POST http://localhost:8080/{Type}/
{% endhighlight %}

####Request Headers
Content-Type: application/json

####Request Body
JSON object representation of a SpaceDocument object.
{%endpanel%}

{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '{"id":"1", "data":"testdata", "data2":"common", "nestedData" : {"nestedKey1":"nestedValue1"}}' http://localhost:8080/MyObject
{% endhighlight %}
{%endpanel%}
{% endgcloak %}

{%endcomment%}

{% togglecloak id=2 %}- Write Multiple{% endtogglecloak %}
{% gcloak 2 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Write multiple entries to the space.
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
POST http://localhost:8080/{Type}/
{% endhighlight %}

####Request Headers
Content-Type: application/json

####Request Body
JSON array representation of a SpaceDocument objects.
{%endpanel%}


{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '[{"id":"1", "data":"testdata", "data2":"common", "nestedData" : {"nestedKey1":"nestedValue1"}},
{"id":"2", "data":"testdata2", "data2":"common", "nestedData" : {"nestedKey2":"nestedValue2"}},
{"id":"3", "data":"testdata3", "data2":"common", "nestedData" : {"nestedKey3":"nestedValue3"}}]' http://localhost:8080/MyObject
{% endhighlight %}
{%endpanel%}
{% endgcloak %}



{% togglecloak id=3 %}- Count{% endtogglecloak %}
{% gcloak 3 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Returns the number of entries in space of the specified type
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
GET http://localhost:8080/{Type}/count
{% endhighlight %}
{%endpanel%}


{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success",
   "data":0
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
http://localhost:8080/{Type}/count
{% endhighlight %}
{%endpanel%}
{% endgcloak %}

{% togglecloak id=4 %}- Read Multiple{% endtogglecloak %}
{% gcloak 4 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Read multiple entries from space that matches the query.
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
GET http://localhost:8080/{Type}/
{% endhighlight %}

####Request Query Parameters
query - a [SQLQuery](./query-sql.html) that is a SQL-like syntax
{%endpanel%}


{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success",
   "data":[
      {
         "id":1,
         "name":"First"
      },
      {
         "id":2,
         "name":"Second"
      }
   ]
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
http://localhost:8080/MyObject/?query=data2='common'
http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27%20or%20id=%273%27
{% endhighlight %}
*The url is encoded, the query is: id='1' or id='2' or id='3'

{%endpanel%}
{% endgcloak %}


{% togglecloak id=5 %}- Read By Id{% endtogglecloak %}
{% gcloak 5 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Read entry from space with the provided id
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
GET http://localhost:8080/{Type}/{id}
{% endhighlight %}
{%endpanel%}


{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success",
   "data":{
      "id":1,
      "name":"First"
   }
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
http://localhost:8080/MyObject/1
http://localhost:8080/MyObject/2
http://localhost:8080/MyObject/3
{% endhighlight %}

{%endpanel%}
{% endgcloak %}

{% togglecloak id=6 %}- Update Multiple{% endtogglecloak %}
{% gcloak 6 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Update entries in space
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
POST http://localhost:8080/{Type}
{% endhighlight %}
{%endpanel%}


{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '[{"id":"1", "data":"testdata", "data2":"commonUpdated", "nestedData" : {"nestedKey1":"nestedValue1"}},
{"id":"2", "data":"testdata2", "data2":"commonUpdated", "nestedData" : {"nestedKey2":"nestedValue2"}},
{"id":"3", "data":"testdata3", "data2":"commonUpdated", "nestedData" : {"nestedKey3":"nestedValue3"}}]'
http://localhost:8080/MyObject
{% endhighlight %}

See that data2 field is updated:

{% highlight bash %}
http://localhost:8080/MyObject/?query=data2='commonUpdated'
{% endhighlight %}

Single nested update:

{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '{"id":"1", "data":"testdata", "data2":"commonUpdated", "nestedData" : {"nestedKey1":"nestedValue1Updated"}}' http://localhost:8080/MyObject
{% endhighlight %}

See that Item1 nested field is updated:

{% highlight bash %}
http://localhost:8080/MyObject/1
{% endhighlight %}
{%endpanel%}

{% endgcloak %}

{% togglecloak id=7 %}- Take Multiple{% endtogglecloak %}
{% gcloak 7 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Gets and deletes entries from space that matches the query.
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
DELETE http://localhost:8080/{Type}/
{% endhighlight %}

####Request Query Parameters
query - a [SQLQuery](./query-sql.html) that is a SQL-like syntax
{%endpanel%}

{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success",
   "data":[
        {
           "id":1,
           "name":"First"
        },
        {
           "id":2,
           "name":"Second"
        }
     ]
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
curl -XDELETE http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27
{% endhighlight %}
*The url is encoded, the query is: id=1 or id=2

See that only Item3 remains:

{% highlight bash %}
http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27%20or%20id=%273%27
{% endhighlight %}
{%endpanel%}
{% endgcloak %}

{% togglecloak id=8 %}- Take By Id{% endtogglecloak %}
{% gcloak 8 %}
{% panel title=Description| borderStyle=solid|borderColor=#3c78b5 %}
Gets and deletes the entry from space with the provided id
{%endpanel%}

{% panel title=Request Schema| borderStyle=solid|borderColor=#3c78b5 %}
####Request URL
{% highlight bash %}
DELETE http://localhost:8080/{Type}/{id}
{% endhighlight %}
{%endpanel%}

{% panel title=Response Schema| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight json %}
{
   "status":"success",
   "data":{
         "id":1,
         "name":"First"
      }
}
{% endhighlight %}
{%endpanel%}

{% panel title=Examples| borderStyle=solid|borderColor=#3c78b5 %}
{% highlight bash %}
curl -XDELETE http://localhost:8080/MyObject/3
{% endhighlight %}

See that Item3 does not exists:

{% highlight bash %}
http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27%20or%20id=%273%27
{% endhighlight %}
{%endpanel%}
{% endgcloak %}