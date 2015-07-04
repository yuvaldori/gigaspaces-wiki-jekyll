

# Notify verses Polling Container

The `Polling container` behavior is different than the `Notify Container`. Comparing the matching phase (that is somehow similar) that both conduct, is not enough.

### Notify Container

The Notify Container is triggered without any feedback loop control - it may be called concurrently without any control by many threads.
This may reduce the latency but generate scenarios where you overload the Space and client without any ability to throttle the activity that will increase the latency.
It may also cause locking issues in case the Notify Container logic need to update the same data that will increase the latency.
It also has issues with durability (may loose events on failure) - that can be handled with guaranteed notifications that impose some overhead and additional latency.
It does support remote Spaces without major issues.


### Polling Container

The Polling Container acts like a queue. If you have one concurrent consumer thread this may impact the overall latency.
Still , you may control the concurrency , its always guaranteed and won't generate locking when updating objects.
It won't support remote Spaces as you can't perform blocking take with a null routing value against a remote partitioned Space .
This means you should run in non-blocking mode. This may introduce additional latency. Reducing it (high frequency sampling rate) will impact CPU utilization and overall system overhead as the client will perform a non-blocking take operation in a round robin fashion against the different partitions.
The more partitions you have and non-even distribution split of the data will result latency with the Polling Container invocation.

You may construct an array of Polling Containers - each with a specific routing that will allow you to use blocking take that will reduce the latency.

{%refer%}
You can find an example [here](/sbp/master-worker-pattern.html#example-2---designated-workers)
{%endrefer%}

