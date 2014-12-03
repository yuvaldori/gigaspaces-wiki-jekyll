---
layout: post101
title:  Metrics
categories: XAP101ADM
parent: monitoring.html
weight: 400
---

{% summary %}{% endsummary %}

{%note title=Technology Preview%}This feature is still under development and is subject to breaking changes until 10.1 is released {%endnote%}

# Overview

GigaSpaces XAP provides a framework for collecting and reporting metrics from the distributed runtime environment into a metric repository of your choice, which can then be analysed and used to identity trends in the system behaviour.

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

The following metrics are bundled with the product

### Process Metrics

{: .table .table-bordered}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.process.cpu.total` | TODO: Document |
| `xap.*.*.*.process.cpu.percent` | TODO: Document |
| `xap.*.*.*.process.memory.total` | TODO: Document |
| `xap.*.*.*.process.memory.used` | TODO: Document |
| `xap.*.*.*.process.memory.free` | TODO: Document |
| `xap.*.*.*.process.swap.total` | TODO: Document |
| `xap.*.*.*.process.swap.used` | TODO: Document |
| `xap.*.*.*.process.swap.free` | TODO: Document |


### JVM Metrics

{: .table .table-bordered}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.jvm.runtime.uptime` | Uptime of the Java virtual machine (in milliseconds) |
| `xap.*.*.*.jvm.threads.count` | Current number of live threads including both daemon and non-daemon threads |
| `xap.*.*.*.jvm.threads.daemon` | Current number of live daemon threads |
| `xap.*.*.*.jvm.threads.peak` | Peak live thread count since the Java virtual machine started or peak was reset |
| `xap.*.*.*.jvm.threads.total-started` | Total number of threads created and also started since the Java virtual machine started |
| `xap.*.*.*.jvm.memory.heap.used` | Amount of used memory in bytes |
| `xap.*.*.*.jvm.memory.heap.committed` | Amount of memory in bytes that is committed for the Java virtual machine to use |
| `xap.*.*.*.jvm.memory.non-heap.used` | Amount of used memory in bytes |
| `xap.*.*.*.jvm.memory.non-heap.committed` | Amount of memory in bytes that is committed for the Java virtual machine to use |
| `xap.*.*.*.jvm.memory.gc.count` | Total number of garbage collections that have occurred |
| `xap.*.*.*.jvm.memory.gc.time` | Approximate accumulated collection elapsed time in milliseconds |

### LRMI Metrics

{: .table .table-bordered}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.lrmi.connections` | Number of LRMI Connections |
| `xap.*.*.*.lrmi.active-connections` | Number of active LRMI Connections |
| `xap.*.*.*.lrmi.generated-traffic` | Total generated traffic (in bytes) |
| `xap.*.*.*.lrmi.received-traffic` | Total received traffic (in bytes) |
| `xap.*.*.*.lrmi.threads` | Number of active LRMI threads |

### Lookup Service Metrics

{: .table .table-bordered}
| Metric | Description |
|:-------|:------------|
| `xap.*.*.*.lus.items` | Number of registered services |
| `xap.*.*.*.lus.listeners` | Number of event notification listeners |
| `xap.*.*.*.lus.pending-events` | Size of the pending event notification queue |
