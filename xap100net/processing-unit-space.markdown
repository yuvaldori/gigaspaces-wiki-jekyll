---
layout: post100
title:  Spaces
categories: XAP100NET
parent: processing-units.html
weight: 300
---

{% summary %}  {% endsummary %}

# Overview

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

# Space Properties

When creating a space you can override space properties values using the `Properties` tag:

{% highlight xml %}
<ProcessingUnit>
  <EmbeddedSpaces>
    <add Name="MySpace">
      <Properties>
        <add Name="space-config.engine.cache_policy" Value="0"/>
        <add Name="space-config.engine.cache_size" Value="100"/>
      </Properties>
    </add>
  </EmbeddedSpaces>
</ProcessingUnit>
{% endhighlight %}

# Cluster Mode

When creating an embedded space, the default proxy is created in **direct** mode, meaning it targets only the collocated cluster member. To target the entire cluster, set the `Mode` tag to **Clustered**:

{% highlight xml %}
<ProcessingUnit>
  <EmbeddedSpaces>
    <add Name="MySpace" Mode="Clustered"/>
  </EmbeddedSpaces>
</ProcessingUnit>
{% endhighlight %}

# Cluster aware

When a processing unit is deployed, the configured embedded spaces are created using the injected cluster information. To force an embedded space to ignore that cluster info, use the `ClusterInfoAware` tag:

{% highlight xml %}
<ProcessingUnit>
  <EmbeddedSpaces>
    <add Name="MySpace" ClusterInfoAware="false"/>
  </EmbeddedSpaces>
</ProcessingUnit>
{% endhighlight %}

# Life Cycle Events

In a topology with backup spaces, it is quite common to have a business logic co-located with an embedded space instance, that should be activated only when the embedded space instance mode is primary. The built-in event listener container work that way; they only start to operate when the co-located embedded space becomes primary. It is quite common to have different custom logic that should be notified upon space mode change events and act accordingly (for instance, start some monitoring process of the co-located space instance). The container will detect automatically methods marked with a space mode changed attribute (\[PostPrimary\], \[BeforePrimary\], \[PostBackup\] and \[BeforeBackup\]) and it will invoke these methods once the space instance mode is changed.

Here's an example of monitoring logic that will start to monitor the embedded space when it becomes primary:

{% highlight java %}
[BasicProcessingUnitComponent(Name="MyComponent")]
public class MyComponent
{
    [PostPrimary]
    public void StartMonitoring(ISpaceProxy proxy)
    {
        //Start monitoring the proxy state
    }
}
{% endhighlight %}

The event listening method can be one of the following formats:

{% highlight java %}
//No parameters method
[PostPrimary]
public void MyEventListener()

//Single space proxy parameter
[PostPrimary]
public void MyEventListener(ISpaceProxy spaceProxy)

//Two parameter, space proxy and space mode
[PostPrimary]
public void MyEventListener(ISpaceProxy spaceProxy, SpaceMode spaceMode)

//If more than one space is defined, specify the name of the space to avoid ambiguity
[PostPrimary(SpaceProxyName="MySpace")]
public void MyEventListener(ISpaceProxy spaceProxy)
{% endhighlight %}

When registering for the \[BeforePrimary\] or \[BeforeBackup\], special care should be taken. The event handling of these listeners will **delay the space instance life cycle completion** for a co-located space instance - i.e., a primary space instance will be blocked from fully becoming a primary space until it completes all the invocations of the \[BeforePrimary\] subscribers. There is no guarantee for receiving a corresponding Before event always prior to a Post event. When the processing unit starts, the event subscription is asynchronous to the space instance active election; in this case it is quite reasonable not to receive the Before events and only to receive the Post events.
