---
layout: post101
title:  Custom Reporter
categories: XAP101ADM
parent: metrics-overview.html
weight: 300
---

{% summary %}{% endsummary %}

{%note title=Technology Preview%}This feature is still under development and is subject to breaking changes until 10.1 is released {%endnote%}

This page demonstrates how to implement and use a custom metric reporter. For demonstration purposes we'll show a reporter which prints metrics to the console.

# Implementation

A custom metric reporter implementation requires overriding two classes: `MetricReporter` and `MetricReporterFactory`. The custom `MetricReporter` accepts metric snapshots and reports them as it wishes. The `MetricReporterFactory` is used to encapsulate configuration and instantiate the `MetricReporter`.

First, let's implement a `ConsoleReporter` which extends `MetricReporter`:

{% highlight java %}
public class ConsoleReporter extends MetricReporter {

    private String title;

    protected ConsoleReporter(ConsoleReporterFactory factory) {
        super(factory);
        this.title = factory.getTitle();
    }

    @Override
    public void report(List<MetricRegistrySnapshot> snapshots) {
        for (MetricRegistrySnapshot snapshot : snapshots) {
            System.out.println(title + " [taken at " + snapshot.getTimestamp() + "]");

            System.out.println("-- Gauges ---");
            Map<String, Object> gauges = snapshot.getGauges();
            for (Map.Entry<String, Object> entry : gauges.entrySet())
                System.out.println(entry.getKey() + " => " + entry.getValue());

            Map<String, Long> counters = snapshot.getCounters();
            System.out.println("-- Counters ---");
            for (Map.Entry<String, Long> entry : counters.entrySet())
                System.out.println(entry.getKey() + " => " + entry.getValue());
        }
    }
}
{% endhighlight %}

Most of the work is done at the `report(List<MetricRegistrySnapshot> snapshots)` method: For each metric snapshot we simply iterate all the gauges and counters, and print the names and respective values.

In addition, note the constructor which receives the factory which can be used to configure the reporter (in this case, the report title).

Next, let's implement a `ConsoleReporterFactory` which extends `MetricReporterFactory`:

{% highlight java %}
public class ConsoleReporterFactory extends MetricReporterFactory<ConsoleReporter> {

    private String title;

    @Override
    public ConsoleReporter create() {
        return new ConsoleReporter(this);
    }

    @Override
    public void load(Properties properties) {
        super.load(properties);
        title = properties.getProperty("title", "*** Report for metric snapshot");
    }

    public String getTitle() {
        return title;
    }
}
{% endhighlight %}

The `load(Properties properties)` method is overridden to load the title from the configuration, and the `create()` method is implemented to instantiate a `ConsoleReporter` using this factory to delegate the loaded configuration.

# Usage

Now that we have a custom reporter implementation we need to configure the system to use it. This is done via the `metrics.xml` configuration file (located under `XAP_HOME/config/metrics` by default), at the `reporters` element:

{% highlight xml %}
<metrics-configuration>
    <reporters>
        <reporter name="console" factory-class="com.gigaspaces.demo.ConsoleReporterFactory">
            <property name="title" value="Some Custom Title"/>
        </reporter>
    </reporters>
</metrics-configuration>
{% endhighlight %}

Basically we're telling the metrics manager which class should be used to instantiate the reporter and which parameters to provide along.

Finally, we'll need to put the compiled `ConsoleReporter` and `ConsoleReporterFactory` classes in the product's class path. The easiest way to accomplish this is under `XAP_HOME/lib/platform/ext`, which is automatically included in the class path.
