---
layout: post101
title:  Monitoring
categories: XAP101ADM
parent: web-management-console.html
weight: 540
---

{% summary %}{% endsummary %}


{%comment%}
The Data Grid view provides Space and Space instance navigation, for querying data and viewing class metadata.
Select a "Space" or press the arrow to drill down into the Space instances of each Space (cluster).




This view will be only available if:
1.       Either no secured login performed or in the case of secured login logged in user has both Monitor JVM and Monitor PU permissions.
2.       grafana section in monitoring.xml must be configured to existing running InfluxDb.

Two following dashboards are created for each processing unit:
1.       Processing Unit Infrastructure – exposes VM and LRMI information about vm used by deployed processing unit instances
2.       Processing Unit properties – processing unit information: events information
For each stateful processing unit additional space dashboard created, it exposes space related information: space operations, transactions, connections, replications etc.

All default dashboard templates can be changed and they are located under [XAP_HOME]/config/webui/dashboards, but please note that all changes will be affected only on new deployed processing units, existing and already stored in “grafana” db dashboards will not be changed.





# Overview

![hosts1.jpg](/attachment_files/web-console/monitor1.jpg)

![hosts1.jpg](/attachment_files/web-console/monitor2.jpg)

![hosts1.jpg](/attachment_files/web-console/monitor3.jpg)

{%endcomment%}
