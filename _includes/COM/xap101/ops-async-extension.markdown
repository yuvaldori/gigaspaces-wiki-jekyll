

# Async Extension 


{%section%}
When running on Java8 it is possible to have even simpler space API with the AsyncExtension.
AsyncExtension subsitute the space AsyncFuture with Java8 CompletableFuture and thus can make the code more fuluent.

There is no need to retrieve the entire data set from the space to the client side , iterate the result set and perform the aggregation. This would be an expensive activity as it might return large amount of data into the client application. The Aggregators allow you to perform the entire aggregation activity at the space side avoiding any data retrieval back to the client side.
{%endsection%}


Example:

{% highlight java %}
import static org.openspaces.extensions.AsyncExtension.asyncRead;

asyncRead(gigaSpace, template).thenAccept(value -> {
    System.out.println("got " + value);
})

{% endhighlight %}



