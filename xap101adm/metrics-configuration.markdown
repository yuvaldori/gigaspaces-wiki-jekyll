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

# Overview

The Metrics framework is composed of **Metrics**, **Metric Samplers** and **Metric Reporters**.

A **Metric** is a piece of code which provides a value of something at the current time (e.g. CPU percentage, free memory, active LRMI threads, etc.). XAP is bundled with an abundance metrics which can be used to monitor its behaviour, and additional metrics can be defined by the user (TODO: Add link).

Each metric is registered in a **Metric Sampler**, which periodically samples all its registered metrics and publishes them via one or more **Metric Reporter**. XAP can be configured to modify the sample rate of the default sampler or configure additional samplers to provide different granularity for different metrics groups.

A **Metric Reporter** receives a snapshot of metrics values from the sampler and reports them to wherever it wishes. XAP is bundled with an [InfluxDB Reporter](./metrics-influxdb-reporter.html), and users can implement additional [custom reporters](./metrics-custom-reporter.html) as they wish.

# Configuration

Metrics configuration is located in the `metrics.xml` file, which resides in `XAP_HOME/config/metrics`.

## Samplers

A **Metric Sampler** is denoted by a name, and has two properties which determine its behaviour:

* `sample-rate` - Determines the rate at which the sampler samples its metrics. can be specified in minutes (`m`), seconds (`s`) or even milliseconds (`ms`).
* `report-rate` - Determines the rate at which the sampler reports the samples via the reporters. If not configured, same as sample rate (i.e. each sample is reported immediately). Useful for reducing network burden when sample-rate is small (e.g. sample each second but report the last 10 samples every 10 seconds). Must be greater than sample-rate, and must be a multiple of sample-rate.

The default configuration contains the following samplers. Users may modify their settings, or add/remove additional samplers as they please.

{% highlight xml %}
<metrics-configuration>
    <!-- define which sampling rates can be assigned to a metric -->
    <samplers>
        <!-- 'default' is configured to sample (and report) its metrics every 5 seconds -->
        <sampler name="default" sample-rate="5s" />
        <!-- 'high' is configured to sample its metrics every second, and report in batch every 5 seconds -->
        <sampler name="high" sample-rate="1s" report-rate="5s" />
        <!-- 'low' is configured to sample (and report) its metrics every minute -->
        <sampler name="low" sample-rate="1m" />
        <!-- 'off' is configured to never sample (and report) its metrics -->
        <sampler name="off" sample-rate="0" />
    </samplers>
</metrics-configuration>
{% endhighlight %}

## Rules

TODO: Explain how to write rules which assign metrics to samplers
