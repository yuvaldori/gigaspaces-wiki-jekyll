---
layout: post101
title:  Configuration
categories: XAP101ADM
parent: metrics-overview.html
weight: 100
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
