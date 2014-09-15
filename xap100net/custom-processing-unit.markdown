---
layout: post100
title:  Custom Processing Unit
categories: XAP100NET
parent: processing-units.html
weight: 500
---

{% summary %}{% endsummary %}

The .NET Processing Unit Container is based on the [OpenSpaces Processing Unit](./processing-units.html), and allows you to write a .NET component that can be managed by the service grid.

The Processing Unit Container is aware of the [cluster info](#ClusterInfo). This allows you to write your code decoupled from cluster topologies considerations.

{%comment%}
{% refer %}Learn how to use the .NET Processing Unit Container in the [SBA Example] section.{% endrefer %}
{%endcomment%}

# AbstractProcessingUnitContainer class

The `AbstractProcessingUnitContainer` class implements `IDisposable`, and consists of one additional method and two properties:

{% highlight java %}
public abstract class AbstractProcessingUnitContainer
{
    // Cluster information is set into this property at deploy-time.
    ClusterInfo ClusterInfo { get; set; }

    // Properties are set into this properties at deploy-time.
    IDictionary<String, String> Properties { get; set; }

    // Invoked by the Service Grid to initialize the processing unit container.
    virtual void Initialize();

    // Invoked by the Service Grid to terminate the processing unit container.
    virtual void Dispose();
}
{% endhighlight %}

The Processing Unit Container lifecycle consists only of these two methods: `Initialize` is called when the Processing Unit Container is constructed, and `Dispose` is called when it is removed. Before the initialization, the ClusterInfo and Properties are set with the deploy-time data.

# Creating Your Own Processing Unit Container

{% toczone minLevel=2|maxLevel=2|type=flat|separator=pipe|location=top %}

## Step 1 -- Create the Processing Unit Container

A processing unit container is an extension of the `GigaSpaces.XAP.ProcessingUnit.Containers.AbstractProcesingUnitContainer` class, which is deployed and executed inside the Service Grid. You need to create your own library with your own extension of the `GigaSpaces.XAP.ProcessingUnit.Containers.AbstractProcesingUnitContainer` class.

## Step 2 -- Create a Deployment pu.config File

You need a config file, which is used to deploy the Processing Unit Container. This config file must be named `pu.config` and needs to be placed together with your processing unit container implementation assemblies.

{% anchor pu.config %}

## Step 3 -- Configure the Deployment pu.config File

The `pu.config` you've created needs to be edited to point to your Processing Unit Container implementation. The file should contain the following data:

{% note %}
It is recommended to use the `pu.config` file located in `<GigaSpaces Root>\Examples\ProcessingUnit\Feeder\Deployment` as a template.
{%endnote%}

{% highlight xml %}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces.XAP" type="GigaSpaces.XAP.Configuration.GigaSpacesXAPConfiguration, GigaSpaces.Core"/>
  </configSections>
  <appSettings>
    <add key="[customkey1]" value="[customvalue1]"/>
  </appSettings>
  <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="[Assembly Qualified Name]"/>
  </GigaSpaces.XAP>
</configuration>
{% endhighlight %}

{% endtoczone %}

{% refer %}It is possible to create a processing unit of mixed languages, for instance part Java, part .NET. This topic is covered in [Interop Processing Unit](./interop-processing-unit.html) page.{% endrefer %}

# SLA Definition

In order to define the service layer agreement of your processing unit, an SLA file needs to be created.
That file should be named `sla.xml`, and should be placed in the root directory of the processing unit.

{% refer %}Read about SLA in [Service Grid Processing Unit Container](./dotnet-processing-unit.html).{% endrefer %}

{%comment%}
# Deployment

There are several ways to deploy the Processing Unit Container into the Service Grid. Are all detailed extensively in the [.NET Processing Unit Data Example](./dotnet-your-first-xtp-application.html#Deployment) section.

The most straightforward way is to use the GigaSpaces Management Center for deployment.
{%endcomment%}
