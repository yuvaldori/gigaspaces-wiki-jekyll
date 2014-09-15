---
layout: post100
title:  Processing Unit
categories: XAP100NET
parent: processing-units.html
weight: 100
---

{% summary %}  {% endsummary %}

#Overview

A Processing Unit is essentially a package containing code which is intended to run at the server side. This package can be deployed using the *Service Grid Processing Unit Container*, which provides SLA management and enforcement, or using a standalone container for debugging purposes.

# Creating a Processing Unit

Creating a processing unit is simple:

1. In Visual Studio, Create a new `Class Library` project.
2. Add an empty text file called `pu.config` to the project.
3. Right-click `pu.config`, select **Properties**, and modify the **Copy to Output Directory** to **Copy Always**.
4. Copy the following configuration into `pu.config`:

{% highlight xml %}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="ProcessingUnit" type="GigaSpaces.XAP.Configuration.ProcessingUnitConfigurationSection, GigaSpaces.Core"/>
  </configSections>
  <ProcessingUnit>
    <!-- Processing unit configuration goes here -->
  </ProcessingUnit>
</configuration>
{% endhighlight %}

{%info title=Configuration Snippets%}Throughout the rest of this page and guide, processing unit configuration snippets will be trimmed for brevity and focus on the `<ProcessingUnit>` tag. {%endinfo%}

{% anchor basiccomponents %}

# Processing Unit Components

Packaging user-defined code in a processing unit is done using components. A **Component** is essentially a class decorated with a `BasicProcessingUnitComponent` attribute:

{% highlight java %}
[BasicProcessingUnitComponent(Name="MyComponent")]
public class MyComponent
{
    public MyComponent()
    {
        Console.WriteLine("Hello World");
    }
}
{% endhighlight %}

When a processing unit is deployed, it scans all the assemblies in its working directory for classes decorated with `BasicProcessingUnitComponent` and instantiates them. In addition, the component instance is managed and tracked 
by the processing unit. The supported life cycle events are:

* *Initializing* - called during the container initialization process. To intercept this event, create a method decorated with `ContainerInitializing`. 
  * Optional: The method can include an argument of type `BasicProcessingUnitContainer` to intercept the container, which provides additional services.
* *Initialized* - called after the container initialization process completed. To intercept this event, create a method decorated with `ContainerInitialized`.
  * Optional: The method can include an argument of type `BasicProcessingUnitContainer` to intercept the container, which provides additional services.
* *Undeploy* - Called when the processing unit instance is undeployed. To intercept this event, implement the standard `IDisposable` interface, and the `Dispose()` method will be called upon undeployment.

The component name can be used by other components to obtain a reference to it. For example, an additional component `Foo` uses the `ContainerInitialized` method to obtain a reference to `MyComponent`:

{% highlight java %}
[BasicProcessingUnitComponent(Name="Foo")]
public class Foo
{
    private MyComponent _myComponent;
	
    [ContainerInitialized]
    public void Initialize(BasicProcessingUnitContainer container)
    {
        _myComponent = (MyComponent)container.GetProcessingUnitComponent("MyComponent");
    }
}
{% endhighlight %}


# Spaces

The processing unit can be configured to create an embedded space or connect to a remote space. For example, the following processing unit creates an embedded space called `MySpace` and connects to a remote space called `SomeOtherSpace`:

{% highlight xml %}
<ProcessingUnit>
  <EmbeddedSpaces>
    <add Name="MySpace"/>
  </EmbeddedSpaces>
  <SpaceProxies>
    <add Name="SomeOtherSpace"/>
  </SpaceProxies>
</ProcessingUnit>
{% endhighlight %}

Since this space is configured within a processing unit, it will automatically shut down when the processing unit is undeployed.

A processing unit component can obtain a reference to the configured spaces using the container. For example:

{% highlight java %}
[BasicProcessingUnitComponent(Name="MyComponent")]
public class MyComponent
{
    private ISpaceProxy _mySpace;
    private ISpaceProxy _someOtherSpace;

    [ContainerInitialized]
    public void Initialize(BasicProcessingUnitContainer container)
    {
        _mySpace = container.GetSpaceProxy("MySpace");
        _someOtherSpace = container.GetSpaceProxy("SomeOtherSpace");
    }
}
{% endhighlight %}

{% anchor eventcontainers %}

# Event Listeners

An [event listener container](./event-processing.html) is one of the most commonly used GigaSpaces components as part of a processing unit. Similarly to the other components, such event containers can be automatically detected, created and managed by the container - 
it will automatically detect classes decorated with `EventDriven` attributes (`PollingEventDriven` or `NotifyEventDriven`) and create corresponding event containers for them.

{% refer %}
See [Polling Container Component](./polling-container.html) and [Notify Container Component](./notify-container.html) for more info regarding event listener containers.
{% endrefer %}

{% highlight java %}
[PollingEventDriven(Name="MyEventListener")]
public class MyEventListener
{
    [..]
}
{% endhighlight %}

An event listener container needs a space proxy that will listen for events. If there's a single space proxy configured it will be selected automatically, otherwise event container should be configured with the relevant space name:

{% highlight xml %}
<ProcessingUnit>
  <EmbeddedSpaces>
    <add Name="MySpace"/>
  /EmbeddedSpaces>
  <SpaceProxies>
    <add Name="MyRemoteSpace"/>
  </SpaceProxies>
  <EventContainers>
    <add Name="MyEventListener" SpaceProxyName="MySpace"/>
  </EventContainers>
</ProcessingUnit>
{% endhighlight %}

{% anchor services %}

# Remote Services

One of GigaSpaces grid component capabilities is [remote services](./space-based-remoting.html), which can be hosted in the grid. The container automatically detects, creates, hosts and manages such services' life cycle. This is done by marking the remote service with the \[SpaceRemotingService\] attribute.

{% highlight java %}
[SpaceRemotingService]
public class MyService : IService
{
  [..]
}
{% endhighlight %}

# Assembly Scanning

By default, all the assemblies packaged with the processing unit will be scanned to automatically create processing unit components, event listener containers and remoting services. In some scenarios you may want to change this. For example:

* The application uses many 3rd party assemblies, and scanning all of them slows down the deployment.
* One of the assemblies contains troublesome code and you want to exclude it.
* You're sharing code between multiple processing units and want to control which component is loaded in which processing unit.

You can use the `ScanAssemblies` tag to specify a list of assemblies to be scanned (wildcards may be used). In addition, you may specify a namespace prefix to which indicates only classes with that prefix will be scanned. For example:

{% highlight xml %}
<ProcessingUnit>
  <ScanAssemblies>
    <!-- Scan all assemblies starting with 'Foo.Bar.' -->
    <add AssemblyName="Foo.Bar.*.dll" />
    <!-- Scan all assemblies starting with 'MyCompany.' for classes starting with 'MyCompany.MyProject.'  -->
    <add AssemblyName="MyCompany.*.dll", NameSpace="MyCompany.MyProject."/>
  </ScanAssemblies>
</ProcessingUnit>
{% endhighlight %}

It is also possible to completely disable assembly scanning:

{% highlight xml %}
<ProcessingUnit>
  <ScanAssemblies Disabled="true"/>
</ProcessingUnit>
{% endhighlight %}


Finally, it is possible to configure the processing unit to scan for certain type of classes (components, event listeners and remoting). For example, to scan for event containers only:

{% highlight xml %}
<ProcessingUnit ScanRemotingServices="false" ScanBasicComponents="false" ScanEventContainers="true">
    <!-- Can be used in combination with ScanAssemblies -->
</ProcessingUnit>
{% endhighlight %}
