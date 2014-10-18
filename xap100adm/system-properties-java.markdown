---
layout: post100
title:  Java System Properties
categories: XAP100ADM
parent: runtime-configuration.html
weight: 400
---

{%summary%}{%endsummary%}

# Administration

{% include /COM/xap100/config-admin.markdown %}


# Deployment

{% include /COM/xap100/config-deploy.markdown %}


# Security

{% include /COM/xap100/config-security.markdown %}


# LRMI

#### Transport

{% include /COM/xap100/config-lrmi-transport.markdown %}

{%refer%}
Refer to [Tuning the communication protocol](./tuning-communication-protocol.html)
{%endrefer%}


#### Filter

{% include /COM/xap100/config-lrmi-filter.markdown %}



#JMS

{% include /COM/xap100/config-jms.markdown %}

{%refer%}
Refer to [Messaging support]({%currentjavaurl%}/messaging-support.html)
{%endrefer%}



# JMX

{% include /COM/xap100/config-jmx.markdown %}

{%refer%}
Refer to [JMX Management](./space-jmx-management.html)
{%endrefer%}

# Multicast

{% include /COM/xap100/config-multicast.markdown %}

{%refer%}
Refer to [Multicast Settings](./network-lookup-service-configuration.html#multicast-settings)
{%endrefer%}

# Web

{% include /COM/xap100/config-web.markdown %}




# Space Filter

{% include /COM/xap100/config-space-filter.markdown %}

{%refer%}
Refer to [Space Filters]({%currentjavaurl%}/the-space-filters.html)
{%endrefer%}




# Logging

{% include /COM/xap100/config-logging.markdown %}

{%refer%}
Refer to [Logging](./logging-overview.html)
{%endrefer%}

# Debug

{% include /COM/xap100/config-debug.markdown %}



# Fault Detection

{% include /COM/xap100/config-fault-detection.markdown %}


# Space Proxy Router

{% include /COM/xap100/config-space-proxy-router.markdown %}


# Slow Consumer

### Server side

{% include /COM/xap100/config-slow-consumer-server.markdown %}

### Client side

{% include /COM/xap100/config-slow-consumer-client.markdown %}

{%refer%}
Refer to [Slow consumer](./slow-consumer.html)
{%endrefer%}


# Cluster

{% include /COM/xap100/config-cluster.markdown %}

{%refer%}
Refer to [Data Grid Clustering](./data-grid-clustering.html)
{%endrefer%}


# Replication

{% include /COM/xap100/config-replication.markdown %}

{%refer%}
Refer to [Replication](./replication.html)
{%endrefer%}


# Space Browser

{% include /COM/xap100/config-space-browser.markdown %}


# JDBC

{% include /COM/xap100/config-jdbc.markdown %}

{%refer%}
Refer to [JDBC Driver]({%currentjavaurl%}/jdbc-driver.html)
{%endrefer%}



# XML

{% include /COM/xap100/config-xml.markdown %}


# Misc

{: .table .table-bordered .table-condensed}
| Property name | Description | Default value |
|---|--|--|
|  com.gs.jndi.url  | Used by the container schema. | **localhost:10098** |
|  com.gs.protocol  | Used by the space schema. | **NIO** |
|  com.gs.engine.cache_policy  | Used by the space schema. | **1 - ALL IN CACHE** |
|  com.gs.memory_usage_enabled  | Used by the space schema. | **false** |
|  com.gs.callGC  | Boolean value.{% wbr %}Call garbage collection when performing eviction. This used when running in LRU cache policy and also at client side when using local cache. | **false** |
|  com.gs.xa.failOnInvalidRollback  | Boolean value.{% wbr %}When set to **false**, the **XAResource** does not throw an error when attempting to roll back a non-existing transaction or a transaction the has already been rolled back. For more details, see [Javadoc](http://docs.oracle.com/javase/1.5.0/docs/api/javax/transaction/xa/XAResource.html) | **true** {% anchor maxbuffer %} |
|  com.gs.active_election.timeout  | Defines the sleep timeout between iterations in the Active election algorithm | 1000 msec |
|  com.gs.env.report  | Allows you to view all the runtime configuration settings. | |
|  com.gs.licensekey  | License key string. | |
|  com.gs.localhost.name  | | |
|  com.gs.onewaynotify | Boolean value. If **false**, performs notify operations in two way mode (ack on notify).| **true** |
|  com.gs.resourcepool.timeout  | Sets the resource release timeout in ms. | **5000** |
|  com.gs.url  | Cache factory. | |




{% refer %}Refer to the [SystemProperties](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/j_spaces/kernel/SystemProperties.html) class for more details.{% endrefer %}

