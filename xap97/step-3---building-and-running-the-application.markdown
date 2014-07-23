---
layout: post97
title:  Step 3 - Building and Running the Application
categories: XAP97
weight: 300
parent: your-first-jpa-application.html
---

{% summary %}This step shows how to build, package and deploy the application while taking advantage of XAP's dynamic load balancing capabilities and the Space as a highly HttpSession store{% endsummary %}

# Before You Begin

We recommend that you do the following before starting this step of the Tutorial:

- Follow [Step 1](./step-1---adjusting-your-jpa-domain-model-to-the-xap-jpa-implementation.html) of this tutorial
- Follow [Step 2](./step-2---using-the-power-of-the-space-to-scale-your-data-access-layer.html) of this tutorial

# Building the Example Application

The application sources and build scripts can be downloaded [here](https://github.com/Gigaspaces/petclinic-jpa). This application uses a Maven build script, so you need to make sure you're connected to the internet when you first run it to allow Maven to download all the dependencies.

To build the example you should follow the following steps:

- Download and unzip the [application sources](https://github.com/gigaspaces/petclinic-jpa)
- Download and install [GigaSpaces XAP Premium Edition](http://www.gigaspaces.com/xap-download).
- Install the Gigaspaces Maven Plugin as described [here]({%currentjavaurl%}/maven-plugin.html). Please take note of the GigaSpaces build number in the console output, e.g.:

{% highlight java %}
~/gs/xap/{{ site.latest_gshome_dirname }}/tools/maven>installmavenrep.sh
""
""
"Installing XAP {% latestxaprelease %}.0-RELEASE jars"
""
""
{% endhighlight %}

- cd to the root directory of the application
- Edit the value of the `gsVersion` property in the `pom.xml` file at the root directory to reflect the GigaSpaces build you're using (this is the build number that the Maven plugin installation script outputs to the console when invoked).
For example, if you are using GigaSpaces XAP {{site.latest_xap_version}} you should modify the `pom.xml` to have:

{% highlight java %}
<gsVersion>{{site.latest_maven_version}}</gsVersion>
{% endhighlight %}

- And for versions less than 10, you should also modify the 'pom.xml' to have:

{% highlight java %}
<dependency>
	<groupId>com.gigaspaces</groupId>
	<artifactId>gs-openspaces</artifactId>
	<version>${gsVersion}</version>
	<exclusions>
		<exclusion>
			<groupId>org.eclipse.jetty.aggregate</groupId>
			<artifactId>jetty-all</artifactId>
		</exclusion>
	</exclusions>
</dependency>
{% endhighlight %}

- Run the following Maven command:

{% highlight java %}
mvn package
{% endhighlight %}

This will download the application's decencies, compile the sources and package the processor processing unit and the web application.

# Deploying the Example Application

To deploy the application, you should do the following:

- Start a [GigaSpaces Agent](/product_overview/service-grid.html#gsa)
- Run the following Maven command from the application's root directory:

{% highlight java %}
mvn os:deploy
{% endhighlight %}

# Creating Sample Data

To have an initial sample data set to work with, simply click the "Create Dummy Data" link in the welcome page of the application. This will create a number of `Owner` s, `Pet` s and `Vet` s that you can work with to experience the application's functionality.

![dummy-data.png](/attachment_files/dummy-data.png)

# Monitoring the Deployed Application

To monitor  the application, start the GigaSpaces UI using the `<GigaSpaces root>/bin/gs-ui.sh(bat)` or the GigaSpaces [Web UI]({%currentadmurl%}/web-management-console.html).

![web-ui-pc.png](/attachment_files/web-ui-pc.png)

# Backing the `HttpSession` with the Space for High Availability

Please refer to [this page](./step-2---enabling-http-session-failover-and-fault-tolerance.html) for directions on how to enable `HttpSession` high availability for the web application.

# Configuring Dynamic Load Balancing

Please refer to [this page](./step-3---scaling-the-data-access-layer.html) for directions on how to enable `HttpSession` high availability for the web application.

