---
layout: post100
title:  The Processing Unit
categories: XAP100NET
parent: none
weight: 400
---

{%wbr%}

{%section%}
{%column width=10% %}
![cassandra.png](/attachment_files/subject/pu.png)
{%endcolumn%}
{%column width=90% %}
The Processing Unit is the unit of packaging and deployment in the GigaSpaces XAP platform. This section describes its directory structure, deployment descriptor and SLA definition and configuration.
{%endcolumn%}
{%endsection%}

Creating a processing unit is simple:

1. In Visual Studio, Create a new `Class Library` project.
2. Add an empty text file called `pu.config` to the project.
3. Right-click `pu.config`, select **Properties**, and modify the **Copy to Output Directory** to **Copy Always**.
4. [Configure](./pu-config.html) your processing unit.

<hr/>

- [Processing Unit Configuration](./pu-config.html){%wbr%}
Configuring processing units to create embedded spaces, connect to remote spaces, and more.

- [Processing Unit Components](./pu-components.html){%wbr%}
Creating processing unit components to execute user-defined code at the server side.

- [Cluster Information](./obtaining-cluster-information.html){%wbr%}
Obtaining information about the clustering topology, member id and other cluster related information can be useful in many cases. Cluster information can be provided to the processing unit instances at deployment time.

<hr/>
