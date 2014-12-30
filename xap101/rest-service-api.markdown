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



# Write


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




# Write Multiple

{: .table .table-bordered .table-condensed}
|Description| Write multiple entries to the space. |
|Request URL|POST http://localhost:8080/{Type}/ |
|Request Headers|Content-Type: application/json |
|Request Body|JSON array representation of a SpaceDocument objects.|

Response Schema:
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}


Examples:
{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '[{"id":"1", "data":"testdata", "data2":"common", "nestedData" : {"nestedKey1":"nestedValue1"}},
{"id":"2", "data":"testdata2", "data2":"common", "nestedData" : {"nestedKey2":"nestedValue2"}},
{"id":"3", "data":"testdata3", "data2":"common", "nestedData" : {"nestedKey3":"nestedValue3"}}]' http://localhost:8080/MyObject
{% endhighlight %}




# Count

{: .table .table-bordered .table-condensed}
|Description| Returns the number of entries in space of the specified type|
|Request URL|GET http://localhost:8080/{Type}/count  |

Response Schema:
{% highlight json %}
{
   "status":"success",
   "data":0
}
{% endhighlight %}


Examples:
{% highlight bash %}
http://localhost:8080/{Type}/count
{% endhighlight %}


# Read Multiple

{: .table .table-bordered .table-condensed}
|Description| Read multiple entries from space that matches the query. |
|Request URL|GET http://localhost:8080/{Type}/ |
|Request Query Parameters|query - a [SQLQuery](./query-sql.html) that is a SQL-like syntax |

Response Schema:
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


Examples:
{% highlight bash %}
http://localhost:8080/MyObject/?query=data2='common'
http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27%20or%20id=%273%27
{% endhighlight %}
*The url is encoded, the query is: id='1' or id='2' or id='3'




# Read By Id

{: .table .table-bordered .table-condensed}
|Description|  Read entry from space with the provided id  |
|Request URL|GET http://localhost:8080/{Type}/{id}  |

Response Schema:
{% highlight json %}
{
   "status":"success",
   "data":{
      "id":1,
      "name":"First"
   }
}
{% endhighlight %}

Examples:
{% highlight bash %}
http://localhost:8080/MyObject/1
http://localhost:8080/MyObject/2
http://localhost:8080/MyObject/3
{% endhighlight %}


# Update Multiple

{: .table .table-bordered .table-condensed}
|Description|  Update entries in space  |
|Request URL|POST http://localhost:8080/{Type}  |

Response Schema:
{% highlight json %}
{
   "status":"success"
}
{% endhighlight %}


 Examples:
{% highlight bash %}
curl -XPOST -H "Content-Type: application/json" -d '[{"id":"1", "data":"testdata", "data2":"commonUpdated", "nestedData" : {"nestedKey1":"nestedValue1"}},
{"id":"2", "data":"testdata2", "data2":"commonUpdated", "nestedData" : {"nestedKey2":"nestedValue2"}},
{"id":"3", "data":"testdata3", "data2":"commonUpdated", "nestedData" : {"nestedKey3":"nestedValue3"}}]'
http://localhost:8080/MyObject

See that data2 field is updated:

http://localhost:8080/MyObject/?query=data2='commonUpdated'

Single nested update:

curl -XPOST -H "Content-Type: application/json" -d '{"id":"1", "data":"testdata", "data2":"commonUpdated", "nestedData" : {"nestedKey1":"nestedValue1Updated"}}' http://localhost:8080/MyObject

See that Item1 nested field is updated:

http://localhost:8080/MyObject/1
{% endhighlight %}



# Take Multiple

{: .table .table-bordered .table-condensed}
|Description| Gets and deletes entries from space that matches the query. |
|Request URL|DELETE http://localhost:8080/{Type}/  |
|Request Query Parameters|query - a [SQLQuery](./query-sql.html) that is a SQL-like syntax  |


Response Schema:
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


Examples:
{% highlight bash %}
curl -XDELETE http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27

*The url is encoded, the query is: id=1 or id=2

See that only Item3 remains:

http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27%20or%20id=%273%27
{% endhighlight %}


# Take By Id

{: .table .table-bordered .table-condensed}
|Description|  Gets and deletes the entry from space with the provided id |
|Request URL|DELETE http://localhost:8080/{Type}/{id}   |

Response Schema:
{% highlight json %}
{
   "status":"success",
   "data":{
         "id":1,
         "name":"First"
      }
}
{% endhighlight %}


Examples:
{% highlight bash %}
curl -XDELETE http://localhost:8080/MyObject/3

See that Item3 does not exists:

http://localhost:8080/MyObject/?query=id=%271%27%20or%20id=%272%27%20or%20id=%273%27
{% endhighlight %}
