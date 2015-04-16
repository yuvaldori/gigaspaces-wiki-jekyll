---
layout: post101
title:  Hosts View
categories: XAP101ADM
parent: web-management-console.html
weight: 500
---

{%summary%}{%endsummary%}


By clicking the `Hosts` tab at the top left, you will enter the hosts screen. This screen enables you to monitor the physical resources of your cluster. The physical resources include the hosts and virtual machines. Please refer to the image below and the call-outs in it for more details.

<br>

![hosts1.jpg](/attachment_files/web-console/host-view.jpg)

<br>

# Settings

{%section%}
{%column width=5% %}
![segment.png](/attachment_files/web-console/icons/setting.png)
{%endcolumn%}
{%column width=90% %}
You will find the  icons on the right side of the window, which allow you to perform
maintenance operations and specific settings on individual components.
{%endcolumn%}
{%endsection%}


<br>

![hosts1.jpg](/attachment_files/web-console/host-setting.jpg)


# Display control

- You can filter which components you want to display<br>
- You can also control the ordering of each column in the display.

![hosts1.jpg](/attachment_files/web-console/host-display.jpg)


# Display logs

For each component you can view the log information. It is possible to filter the logs and search them.

<br>

![hosts1.jpg](/attachment_files/web-console/host-view-logging.jpg)


{%comment%}
<br>

# Alerts

In this panel you will see alerts and notifications about your infrastructure. It will display for example information about `Garbage Collection`, `Heap Utilization` and others.


![hosts1.jpg](/attachment_files/web-console/alerts.png)

<br>

# Events

In the events panel you can see events for the selected component. It lets you filter the events and you can also choose the narrow down the
events by date and time.

![hosts1.jpg](/attachment_files/web-console/events.png)

<br>


# Icons

The icons in the table below are used to indicate the following peaces of the infrastructure:

{: .table .table-bordered .table-condensed}
|![segment.png](/attachment_files/web-console/icons/host.png)|Host|
|![segment.png](/attachment_files/web-console/icons/agent.png)|Agent|
|![segment.png](/attachment_files/web-console/icons/manager_gsm.png)|GSM|
|![segment.png](/attachment_files/web-console/icons/search_lus.png)|LUS|
|![segment.png](/attachment_files/web-console/icons/container.png)|GSC|
|![segment.png](/attachment_files/web-console/icons/processor.png)|Processing Unit|
|![segment.png](/attachment_files/web-console/icons/space.png)|Space|
|![segment.png](/attachment_files/web-console/icons/stateful.png)|Stateful PU|
|![segment.png](/attachment_files/web-console/icons/stateless.png)|Stateless PU|
|![segment.png](/attachment_files/web-console/icons/monitor_esm.png)|ESM|
|![segment.png](/attachment_files/web-console/icons/mirror.png)|Mirror Service|
|![segment.png](/attachment_files/web-console/icons/web_app.png)|Web application|
|![segment.png](/attachment_files/web-console/icons/gateway.png)|Gateway|
|![segment.png](/attachment_files/web-console/icons/wan.png)|WAN|







By clicking the services tab at the top left, you will enter the hosts screen. This screen enables you to monitor the physical resources of your cluster. The physical resources include the hosts and virtual machines. Please refer the image below and the call-outs in it for more details.

![hosts1.jpg](/attachment_files/hosts1.jpg)

### Operating on hosts, JVMs and processing unit

The image below shows the possible options of operating on each of the components displayed by the web UI.
![hosts_actions.jpg](/attachment_files/hosts_actions.jpg)

### Deploying with the Web UI

The Web UI supports the deployment of processing units, as depicted below.

- Processing Unit

- EDG

- Memcached

![deployment_options.jpg](/attachment_files/deployment_options.jpg)

#### Deployment options:
![processing_unit_deployment_1.jpg](/attachment_files/processing_unit_deployment_1.jpg)

![processing_unit_deployment_2.jpg](/attachment_files/processing_unit_deployment_2.jpg)

{%endcomment%}