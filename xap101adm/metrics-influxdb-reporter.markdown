---
layout: post101
title:  InfluxDB Reporter
categories: XAP101ADM
parent: metrics-overview.html
weight: 200
---



{%note title=Technology Preview%}This feature is still under development and is subject to breaking changes until 10.1 is released {%endnote%}

GigaSpaces XAP is shipped with built-in support for [InfluxDB](http://influxdb.com/). This page explains how to configure XAP to report metrics to InfluxDB. For the purpose of this page we'll assume you've installed InfluxDB on a host called `foo`, and that it contains a database called `bar` which is intended to store xap's metrics.

Configuration takes place in `metrics.xml`, which resides in `XAP_HOME/config/metrics`.

# HTTP Reporter

InfluxDB provides a REST API for [reading and writing data](http://influxdb.com/docs/v0.8/api/reading_and_writing_data.html). The following snippet shows how to configure xap to use it:

{% highlight xml %}
<metrics-configuration>
    <reporters>
        <reporter name="influxdb-http">
            <property name="host" value="foo"/>
            <property name="port" value="8086"/>
            <property name="database" value="bar"/>
            <property name="username" value="root"/>
            <property name="password" value="root"/>
            <property name="logOnError" value="yes"/>
        </reporter>
    </reporters>
</metrics-configuration>
{% endhighlight %}

Note we're setting the `host` and `database` properties to the location of the InfluxDB installation and the name of the database, respectively. The default port is `8086`, and the default username and password are `root` - if any of those settings are changed in Influx they should be changed in this configuration as well. `logOnError` prints the JSON to the log when there's an error, which can be useful for troubleshooting problems.

{% comment %}
// UDP reporter docs is commented pending verification this is still supported in InfluxDB 0.9
# UDP Reporter

InfluxDB allows you to [write data through UDP](http://influxdb.com/docs/v0.8/api/reading_and_writing_data.html#writing-data-through-json-+-udp), assuming you will be writing data to a single database which is configured in InfluxDB's configuration file. The following snippet shows how to configure xap to use it:

{% highlight xml %}
<metrics-configuration>
    <reporters>
        <reporter name="influxdb-udp">
            <property name="host" value="foo"/>
            <property name="port" value="4444"/>
            <property name="logOnError" value="yes"/>
        </reporter>
    </reporters>
</metrics-configuration>
{% endhighlight %}

Note we're setting the `host` to the location of the InfluxDB installation, and the database is not configured here at all. The default port is `4444`. `logOnError` prints the JSON to the log when there's an error, which can be useful for troubleshooting problems.
{% endcomment %}

# Overriding metrics names

A user may wish to use a different naming scheme for the metrics. This can be accomplished by extending the relevant InfluxDB reporter and overriding the `getMetricNameForReport(String metricName)` method. 

For example, Processing unit metrics are prefixed by `pu_`. The following implementation replaces that prefix with `foo_`:

{% highlight java %}
public class MyInfluxDBHttpReporter extends InfluxDBHttpReporter {
    public MyInfluxDBHttpReporter(InfluxDBHttpReporterFactory factory) {
        super(factory);
    }

    @Override
    protected String getMetricNameForReport(String metricName) {
        return metricName.startsWith(prefix) ? "foo_" + metricName.substring(prefix.length()) : metricName;
    }
}
{% endhighlight %}

To learn how to configure and install this custom reporter, refer to [Custom Reporter](./metrics-custom-reporter.html).