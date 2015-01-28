---
layout: post101
title:  Metrics
categories: XAP101ADM
parent: monitoring.html
weight: 400
---

{% summary %}{% endsummary %}

{%note title=Technology Preview%}This feature is still under development and is subject to breaking changes until 10.1 is released {%endnote%}



 XAP provides a framework for collecting and reporting metrics from the distributed runtime environment into a metric repository of your choice, which can then be analysed and used to identity trends in the system behaviour.

The Metrics framework is composed of **Metrics**, **Metric Samplers** and **Metric Reporters**.

A **Metric** is a piece of code which provides a value of something at the current time (e.g. CPU percentage, free memory, active LRMI threads, etc.). XAP is bundled with an abundance metrics which can be used to monitor its behaviour, and additional metrics can be defined by the user (TODO: Add link, under construction).

Each metric is registered in a **Metric Sampler**, which periodically samples all its registered metrics and publishes them via one or more **Metric Reporter**. XAP can be configured to modify the sample rate of the default sampler or configure additional samplers to provide different granularity for different metrics groups.

A **Metric Reporter** receives a snapshot of metrics values from the sampler and reports them to wherever it wishes. XAP is bundled with an **InfluxDB** Reporter, and users can implement additional reporters as they wish (TODO: Add link)

# Configuration

Metrics configuration is located in the `metrics.xml` file, which resides in `XAP_HOME/config/metrics`

TODO: Explain how to configure samplers

TODO: Explain how to write rules which assign metrics to samplers

TODO: Explain how to configure reporters

# Bundles Metrics

The following metrics are bundled with the product:

## Operating System metrics

Each `gs-agent` monitors common operating system metrics. Each metric is prefixed with the host name. For example, the %used memory metric on machine `foo` would be `xap.foo.os.memory.used.percent`. This prefix is abbreviated in the following tables to `xap.*.`.

### Memory Metrics

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.os.memory.free.bytes` | Free memory (bytes) |
| `xap.*.os.memory.actual-free.bytes` | Actual free memory (bytes) |
| `xap.*.os.memory.used.bytes` | Used memory (bytes) |
| `xap.*.os.memory.actual-used.bytes` | Actual used memory (bytes) |
| `xap.*.os.memory.used.percent` | Used memory (%) |

### Swap Metrics

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.os.swap.free.bytes` | Free swap (bytes) |
| `xap.*.os.swap.used.bytes` | Used swap (bytes) |
| `xap.*.os.swap.used.percent` | Used swap (%) |

### CPU Metrics

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.os.cpu.used.percent` | CPU Usage (%) |

### Network Metrics

For each network interface card, the following metrics are registered:

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.os.network.*.rx-bytes` | Total bytes received |
| `xap.*.os.network.*.tx-bytes` | Total bytes transmitted |
| `xap.*.os.network.*.rx-packets` | Total packets received |
| `xap.*.os.network.*.tx-packets` | Total packets transmitted |
| `xap.*.os.network.*.rx-errors` | Receive errors |
| `xap.*.os.network.*.tx-errors` | Transmit errors |
| `xap.*.os.network.*.rx-dropped` | Receive dropped |
| `xap.*.os.network.*.tx-dropped` | Transmit dropped |

## Process metrics

Each process in the service grid reports the metrics listed below. Each metric is prefixed with the host name, process id and process role (`gsa` / `lus` / `gsm` / `esm` / `gsc`). For example, the total CPU time metric of a **GSC** hosted on machine `foo` may look like this: `xap.foo.1234.gsc.process.cpu.time.total`. This prefix is abbreviated in the following tables to `xap.*.*.*.`.

### Process CPU Metrics

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.process.cpu.time.total` | Process CPU total time |
| `xap.*.*.*.process.cpu.used.percent` | Process CPU Usage (%) |

### JVM Metrics

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.jvm.runtime.uptime` | Uptime of the Java virtual machine (in milliseconds) |
| `xap.*.*.*.jvm.threads.count` | Current number of live threads including both daemon and non-daemon threads |
| `xap.*.*.*.jvm.threads.daemon` | Current number of live daemon threads |
| `xap.*.*.*.jvm.threads.peak` | Peak live thread count since the Java virtual machine started or peak was reset |
| `xap.*.*.*.jvm.threads.total-started` | Total number of threads created and also started since the Java virtual machine started |
| `xap.*.*.*.jvm.memory.heap.used.bytes` | Amount of used memory in bytes |
| `xap.*.*.*.jvm.memory.heap.committed.bytes` | Amount of memory in bytes that is committed for the Java virtual machine to use |
| `xap.*.*.*.jvm.memory.non-heap.used.bytes` | Amount of used memory in bytes |
| `xap.*.*.*.jvm.memory.non-heap.committed.bytes` | Amount of memory in bytes that is committed for the Java virtual machine to use |
| `xap.*.*.*.jvm.memory.gc.count` | Total number of garbage collections that have occurred |
| `xap.*.*.*.jvm.memory.gc.time` | Approximate accumulated collection elapsed time in milliseconds |

### LRMI Metrics

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.lrmi.connections` | Number of LRMI Connections |
| `xap.*.*.*.lrmi.active-connections` | Number of active LRMI Connections |
| `xap.*.*.*.lrmi.generated-traffic` | Total generated traffic (in bytes) |
| `xap.*.*.*.lrmi.received-traffic` | Total received traffic (in bytes) |
| `xap.*.*.*.lrmi.threads` | Number of active LRMI threads |

## Lookup Service Metrics

The following metrics are registered for each lookup service

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.lus.items` | Number of registered services |
| `xap.*.*.*.lus.listeners` | Number of event notification listeners |
| `xap.*.*.*.lus.pending-events` | Size of the pending event notification queue |

## Space Metrics

Each space instance reports the metrics listed below. Each metric is prefixed with process prefix described above, along with the space name and instance id. For example, the read operations metric of space `bar` instance 2 on machine `foo` may look like this: `xap.foo.1234.gsc.space.bar.2.operations.read`. This prefix is abbreviated in the following tables to `xap.*.*.*.space.*.*`.

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.pu.*.*.space.*.*.connections.incoming.active` | Number of active incoming connections |
| `xap.*.*.*.pu.*.*.space.*.*.transactions.active` | Number of active transactions |

### Space Operations

{: .table .table-bordered .table-condensed}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.pu.*.*.space.*.*.operations.execute` | Number of task execution operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.write` | Number of write operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.update`  | Number of update operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.change` | Number of change operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.read` | Number of read operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.read-multiple` | Number of read multiple operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.take` | Number of take operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.take-multiple` | Number of take multiple operations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.lease-expired` | Number of entry lease expirations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.register-listener` | Number of event listener registrations |
| `xap.*.*.*.pu.*.*.space.*.*.operations.before-listener-trigger` | Number of triggered events (before trigger) |
| `xap.*.*.*.pu.*.*.space.*.*.operations.after-listener-trigger` | Number of triggered events (after trigger) |
