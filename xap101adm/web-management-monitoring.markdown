---
layout: post101
title:  Monitoring
categories: XAP101ADM
parent: web-management-console.html
weight: 540
---

{%comment%}
{% summary %}{% endsummary %}


The `Monitoring` view lets you view `Processing Unit Infrastructure` and  `Processing Unit properties` statistics. XAP provides
default templates for this. All default dashboard templates can be changed. They are located under `[XAP_HOME]/config/webui/dashboards`.

The monitoring view relies on two products, [InfluxDB](http://influxdb.com/) and [Grafana](http://grafana.org). These tools need to be installed and connected before the `Monitoring` view is operational.
The InfluxDB is used to store the time series values that are generated from the XAP infrastructure. Grafana is ued to visualize the time series values.

# InfluxDB

XAP uses `InfluxDB` to store the time series values. Please refer to the InfluxDB website for [installation](http://influxdb.com/docs/v0.8/introduction/installation.html) instructions.
Once the InfluxDB is installed you need to connect XAP to the repository.  Follow the steps below to configure the InfluxDB and connect your XAP environment to it.


### Create a data base

After you installed the InfluxDB, login into the web console and create a data base that will be used by XAP to store the time series values.

![hosts1.jpg](/attachment_files/web-console/influxdb-create-db.jpg)

<br>

### Create a user

The user name should match a defined user in XAP.

{%refer%}
Configure an XAP user that has Monitor JVM and Monitor PU permissions. Refer to [Managing Users and Roles]({%currentsecurl%}/gigaspaces-management-center-(ui)-security.html)
{%endrefer%}

Create a user for the data base:


![hosts1.jpg](/attachment_files/web-console/influxdb-create-user.jpg)

<br>

### Configure XAP

We need to configure the connection between XAP and InfluxDB. This is done by modifying the `metrics.xml` file which you can find in the XAP distributation
folder `[XAP_HOME]/config/metrics`.

{%highlight xml%}
<metrics-configuration>
    <reporters>
        <reporter name="influxdb-http">
            <property name="host" value="InfluxDbHost"/>
            <property name="database" value="InfluxDB-name"/>
            <property name="username" value="xap-username"/>
            <property name="password" value="password"/>
        </reporter>
    </reporters>
</metrics-configuration>
{%endhighlight%}

{%refer%}
Please refer to the [InfluxDB Reporter](./metrics-influxdb-reporter.html) section for detailed configuration instructions.
{%endrefer%}


After you configured the InfluxDB Reporter, restart XAP. Your XAP infrastructure should now be connected and generate data in InfluxDB with the default configuration.


### Query the data base

You can now query the InfluxDB. Here is a query that will display all time series in the data base.

{%highlight console%}
list series
{%endhighlight%}

This query will display all time series names available in the data base.

![hosts1.jpg](/attachment_files/web-console/influxdb-query-series.jpg)

<br>

### Data Series display

You can choose one time series and display its data.

{%highlight console%}
select * from "xap.hostname.10200.gsa.jvm.threads.deamon"
{%endhighlight%}

![hosts1.jpg](/attachment_files/web-console/influxdb-data-series.jpg)

{%endcomment%}

{%comment%}

### Grafana

[Graphana](http://grafana.org/)





This view will be only available if:
1.       Either no secured login performed or in the case of secured login logged in user has both Monitor JVM and Monitor PU permissions.
2.       grafana section in monitoring.xml must be configured to existing running InfluxDb.

Two following dashboards are created for each processing unit:
1.       Processing Unit Infrastructure – exposes VM and LRMI information about vm used by deployed processing unit instances
2.       Processing Unit properties – processing unit information: events information
For each stateful processing unit additional space dashboard created, it exposes space related information: space operations, transactions, connections, replications etc.

All default dashboard templates can be changed and they are located under [XAP_HOME]/config/webui/dashboards, but please note that all changes will be affected only on new deployed processing units, existing and already stored in “grafana” db dashboards will not be changed.






# XAP Monitor

![hosts1.jpg](/attachment_files/web-console/monitor1.jpg)

![hosts1.jpg](/attachment_files/web-console/monitor2.jpg)

![hosts1.jpg](/attachment_files/web-console/monitor3.jpg)


 {%endcomment%}