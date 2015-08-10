---
layout: post102
title:  Paging Support
categories:
parent:
weight: 100
---

{% summary %}{% endsummary %}



In some scenarios there's a need to return a collection of entries from the space. This is usually carried out using one of the [readMultiple](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html#readMultiple-T-) overloads in `GigaSpace`. However, if there are lots of matching entries, you may encounter several problems:

* Memory usage - Both the server and client need to allocate enough memory for the entire result set.
* Latency - Since all the results are returned in one bulk, the client must wait until the final result arrives before it can process the first one.

A better approach is to create an iterator that iterates over the matching entries one at a time. Under the hood, the server returns results in batches, and when the client's buffer is exhausted the next batch is implicitly returned from the server.

{%info title=ISpaceIterator%}This page describes the new space iterator which is intended to replace the old `GSIterator` starting 10.2. Information about the old GSIterator is available [here](./query-paging-support-old.html).{%endinfo%}

# Usage

{%comment%}
Use the [GigaSpace](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html) `iterator(template)` method to create an iterator of all the objects in the space which match the template (either [SQLQuery](./query-sql.html) or [template](./query-template-matching.html)). This results in a `SpaceIterator<T>` which implements both `Iterator<T>` and `Iterable<T>`, so a simple [for-each loop](https://docs.oracle.com/javase/1.5.0/docs/guide/language/foreach.html) can be used to iterate the results. For example:
{%endcomment%}

Use the `GetSpaceIterator(template)` to create the iterator. Example:

{% highlight java %}
    // Find and print all persons who are older than 21:
    foreach (var person in spaceProxy.GetSpaceIterator<Person>(new SqlQuery<Person>("Age > 21")))
    {
      Console.WriteLine("Id: " + person.Id + ", Age: " + person.Age);
    }
{% endhighlight %}


{%comment%}
## Batch size

Under the hood the iterator uses batching to fetch entries from the server, then serve the entries from the batch to the client whenever it asks for the next entry. The default batch size is `100`. You can use a different batch size by calling the `gigaSpace.iterator(template, batchSize)` overload.
{%endcomment%}

## Transactions

Iterating through the matched set does not lock the object. Objects that are under transaction and match the specified template will not be included as part of the matched set.

# Limitations

### Complex queries

The space iterator only supports simple SQL queries. For more information about the differences between simple and complex queries see [simple SQL queries](./query-sql.html#SimpleQueries).

