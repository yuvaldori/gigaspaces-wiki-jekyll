---
layout: post101
title:  InfluxDB Reporter
categories: XAP101ADM
parent: metrics-overview.html
weight: 200
---



{%note title=Technology Preview%}This feature is still under development and is subject to breaking changes until 10.1 is released {%endnote%}

GigaSpaces XAP is shipped with built-in support for [InfluxDB](http://influxdb.com/). This page explains how to configure XAP to report metrics to InfluxDB. 

Configuration takes place in `metrics.xml`, which resides in `XAP_HOME/config/metrics`. For more information see [Configuration](./metrics-configuration.html).

{%note title=InfluxDB Status%}The GigaSpaces InfluxDB reporter implementation is based on [InfluxDB v0.9.0](http://influxdb.com/docs/v0.9/), which is currently in pre-release (RC2) and is expected to be production ready in march 2015. {%endnote%}

{% comment %}
Since there's currently only one reporter this header is redundant.
# HTTP Reporter
{% endcomment %}

InfluxDB provides an [HTTP API](http://influxdb.com/docs/v0.9/concepts/reading_and_writing_data.html#writing-data-using-the-http-api) for writing data, which is implemented by XAP. For example, if InfluxDB is installed on `myhost` and you want to report metrics to the `mydb` database, use the following configuration:

{% highlight xml %}
<metrics-configuration>
    <reporters>
        <reporter name="influxdb-http">
            <property name="host" value="myhost"/>
            <property name="database" value="mydb"/>
        </reporter>
    </reporters>
</metrics-configuration>
{% endhighlight %}

### Port

The InfluxDB HTTP API is bounded to port `8086` by default. If you've configured your InfluxDB instance to use a different port you should modify the reporter configuration accordingly and add a `<property name="port" value="nnnn"/>` with the new port.

### Retention Policy

An InfluxDB database has one or more [Retention Policies](http://influxdb.com/docs/v0.9/query_language/database_administration.html#retention-policy-management), which determine determine the *retention period* (the time after which data is automatically deleted from the InfluxDB system). By default, metrics are reported to the default retention policy of the database. To report to a different retention policy add `<property name="retention-policy" value="mypolicy"/>` to the configuration.

{% comment %}
### Security

Security configuration is broken in 0.9 for some reason... once fixed it should be documented here.
`username`
`password`
{% endcomment %}

### Report Length

The InfluxDB reporter batches multiple metrics within each report to maximize performance, up to a maximum value determined by the `max-report-length` property. The default value is `65507` (based on [UDP max length](http://en.wikipedia.org/wiki/User_Datagram_Protocol)), and usually should not be changed. 

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
        final String prefix = "pu_";
        return metricName.startsWith(prefix) ? "foo_" + metricName.substring(prefix.length()) : metricName;
    }
}
{% endhighlight %}

To learn how to configure and install this custom reporter, refer to [Custom Reporter](./metrics-custom-reporter.html).