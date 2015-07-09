---
layout: post102
title:  Configuration & Deployment
categories: XAP102
parent: global-http-session-sharing-overview.html
weight: 200
---

{%summary%}{%endsummary%}



# The Web Application Configuration

The web application requires a couple of configuration changes to the `web.xml` file in order to enabled XAP Session sharing:

{% highlight xml %}
<web-app>
		....
	<listener>
      		<listener-class>org.apache.shiro.web.env.EnvironmentLoaderListener</listener-class>
    	</listener>
    	<listener>
      		<listener-class>com.gigaspaces.httpsession.sessions.GigaSpacesCacheManager</listener-class>
    	</listener>
        <filter>
        	<filter-name>GigaSpacesHttpSessionFilter</filter-name>
        	<filter-class>com.gigaspaces.httpsession.web.GigaSpacesHttpSessionFilter</filter-class>
        	<web:init-param> 
        		<web:param-name>rewriteUrl</web:param-name> 
            		<web:param-value>false</web:param-value> <!-- default true -->
        	</web:init-param>
        </filter>
        <filter-mapping>
            <filter-name>GigaSpacesHttpSessionFilter</filter-name>
            <url-pattern>/*</url-pattern>
        </filter-mapping>
</web-app>
{% endhighlight %}

{% note %}The **GigaSpacesHttpSessionFilter** must be the first filter defined.{% endnote %}

# Shiro configuration

In order to enable the **GigaSpacesHttpSession** you need to set shiro.ini configuration file first.
The following should be located under **main** section.

###Space Connector - Manages connections with the space


{: .table   .table-condensed   .table-bordered}
|Property|Description|Required|Optional Values|
|:-------|:----------|:-------|:--------------|
|connector| wrap SpaceProxy and perform operation against space|Yes|`com.gigaspaces.httpsession.SpaceConnector`|
|connector.url| Space url including groups and locators |Yes|`jini://*/*/<space_name>?groups=myGroup`|
|connector.username| Space username|No|`<space username>`|
|connector.password| Space password|No|`<space password>`|
|connector.sessionLease|Lease timeout in milliseconds {%wbr%}Default to Lease.FOREVER so that the session won't be removed from the space |No|Any positive integer. Millisecond time unit|
|connector.readTimeout|Read timeout in milliseconds {%wbr%}Default to 300000|No|Any positive interger. Millisecond time unit|
|connector.sessionBaseName| Fully qualified type name that holds the session attributes in space.{%wbr%}Default is `com.gigaspaces.httpsession.models.DefaultSpaceSessionStore`|Yes|

###Store Mode - Configure how changes are saved to the space

{: .table   .table-condensed   .table-bordered}
|Property|Description|Required|Optional Values|
|:-------|:----------|:-------|:--------------|
|listener|Fully qualified class name implementing `com.gigaspaces.httpsession.policies.GigaspacesNotifyListener`|No|`com.gigaspaces.httpsession.policies.TraceListener`|
|:-------|:----------|:-------|:--------------|
|storeMode|Provide functionality of how to save changes to the space. there is tow sessions store mode full and delta.|Yes| use on of two options:<br> 1.`com.gigaspaces.httpsession.sessions.FullStoreMode` 2.`com.gigaspaces.httpsession.sessions.DeltaStoreMode`|
|storeMode.connector| Space connector to be used{%wbr%}See [Space Connector Section](#connector---manages-connections-with-the-space)|Yes|$connector|
|storeMode.listener|Provides changes notification functionality. it must extends `com.gigaspaces.httpsession.policies.GigaspacesNotifyListener`|No| $listener |

###Session Manager - XAP Session Manager Implementation

{: .table   .table-condensed   .table-bordered}
|Property|Description|Required|Optional Values|
|:-------|:----------|:-------|:--------------|
|sessionDAO|Provides a transparent caching layer between the components that use it and the underlying EIS (Enterprise Information System) session backing store |Yes|org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO|
|sessionManager|XAP Session Manager Implementation|Yes|com.gigaspaces.httpsession.GigaSpacesWebSessionManager|
|sessionManager.sessionDAO||Yes|$sessionDAO|
|sessionManager.storeMode|Configure how changes are saved to the space. See [Store Mode Section](#store-mode---configure-how-changes-are-saved-to-the-space)|Yes|$storeMode|
|securityManager.sessionManager|Ensure the securityManager uses our native SessionManager|Yes|$sessionManager|

###Session Policy - Authentication settings

{: .table   .table-condensed   .table-bordered}
|Property|Description|Required|Optional Values|
|:-------|:----------|:-------|:--------------|
|policy|Provides functionality of session policy to apply e.g. with and without authentication. |Yes| Options:<br>1.`com.gigaspaces.httpsession.policies.SessionPolicyWithLogin` <br>2.`com.gigaspaces.httpsession.policies.SessionPolicyWithoutLogin` |
|policy.connector|Instance of space connector implementation{%wbr%}See [Space Connector Section](#connector---manages-connections-with-the-space)|Yes|$connector|
|policy.storeMode|Instance of space storeMode implementation{%wbr%}See [Store Mode Section](#store-mode---configure-how-changes-are-saved-to-the-space)|Yes|$storeMode|

###Serializer

{: .table   .table-condensed   .table-bordered}
|Property|Description|Required|Optional Values|
|:-------|:----------|:-------|:--------------|
|serializer|Provides serialization functionality|Yes| use one of the following options: 	1.`com.gigaspaces.httpsession.serialize.KryoSerializerImpl` (recomended)	2.`com.gigaspaces.httpsession.serialize.XStreamSerializerImpl` <br> 3. Custom - an implementation of the `com.gigaspaces.httpsession.serialize.Serializer` interface
|serializer.logLevel|internal kryo logging level {%wbr%}Default to `LEVEL_INFO = 3`|No| 1. `NONE = 6` disables all logging.<br> 2. `ERROR = 5` is for critical errors. The application may no longer work correctly.<br> 3. `WARN = 4` is for important warnings. The application will continue to work correctly.<br> 4.`INFO = 3` is for informative messages. Typically used for deployment.<br> 5. `DEBUG = 2` is for debug messages. This level is useful during development.<br> 6. `TRACE = 1` is for trace messages. A lot of information is logged, so this level is usually only needed when debugging a problem. |
|serializer.classes|comma separate list full qualified class names to be loaded at the initialization of the Kryo Serializer|No||

###Cache Manager - XAP Cache Manager Implementation

{: .table   .table-condensed   .table-bordered}
|Property|Description|Required|Optional Values|
|:-------|:----------|:-------|:--------------|
|compressor|Provides compress functionality|No| Provides your own `com.gigaspaces.httpsession.serialize.Compressor` implementation or use one of the out of the box option:<br> 1.`com.gigaspaces.httpsession.serialize.CompressorImpl`<br>2.`com.gigaspaces.httpsession.serialize.NonCompressCompressor`|
|:-------|:----------|:-------|:--------------|
|cacheManager|XAP extension of org.apache.shiro.cache.CacheManager Provides and maintains the lifecycles of `com.gigaspaces.httpsession.sessions.GigaSpacesCache` instances|Yes|com.gigaspaces.httpsession.sessions.GigaSpacesCacheManager|
|cacheManager.initialCapacity|Specifies the initial capacity of the LRU used for caching session in memory.|No|1000|
|cacheManager.maximumCapacity|Maximum capacity of the LRU used for caching session in memory.|No|10000|
|cacheManager.concurrencyLevel|Specifies the estimated number of concurrently updating threads|No|16|
|cacheManager.compressor|Set the compressor instance to be used. {%wbr%}Default to `com.gigaspaces.httpsession.serialize.NonCompressCompressor`|No|$compressor|
|cacheManager.serializer|Instance of the serializer implementation{%wbr%}See [Serializer Section](#serializer)|Yes|$serializer|
|cacheManager.policy|Instance of session policy implementation{%wbr%}See [Session Policy Section](#session-policy---authentication-settings)|Yes|$policy|
|cacheManager.connector|Instance of space connector implementation{%wbr%}See [Space Connector Section](#connector---manages-connections-with-the-space)|Yes|$connector|
|:-------|:----------|:-------|:--------------|

The `shiro.ini` file should to be placed within the `WEB-INF` folder. See below examples for the `shiro.ini` file:

{%accordion id=acc0%}


{%accord title=Session Sharing Configuration For Non-Secured Application ... | parent=acc0%}

{% highlight ini %}

[main]
# space proxy wraper
connector=com.gigaspaces.httpsession.SpaceConnector
connector.url=jini://*/*/sessionSpace
# When using secured GigaSpace cluster, pass the credentials here
# connector.username = <username>
# connector.password = <password>
# Default lease is Lease.FOREVER so that the session won’t be removed from the space
# connector.sessionLease = 9223372036854775807
# Default read timeout is 5 minutes = 5 * 60 * 1000 = 300000
connector.readTimeout = 300000

# The SpaceDocument class name that holds the session attributes in space
connector.sessionBaseName=com.gigaspaces.httpsession.models.DefaultSpaceSessionStore

# Model Manager service
storeMode=com.gigaspaces.httpsession.sessions.DeltaStoreMode
storeMode.connector=$connector
listener1 = com.gigaspaces.httpsession.policies.TraceListener
storeMode.listener=$listener1

# Set the sessionManager to use an enterprise cache for backing storage:
sessionDAO=org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO
sessionManager=com.gigaspaces.httpsession.GigaSpacesWebSessionManager
sessionManager.sessionDAO=$sessionDAO
sessionManager.storeMode=$storeMode

# ensure the securityManager uses our native SessionManager:
securityManager.sessionManager=$sessionManager

# Session Policy Service
policy=com.gigaspaces.httpsession.policies.SessionPolicyWithoutLogin
policy.connector=$connector
policy.storeMode=$storeMode

# Serialization Service
serializer=com.gigaspaces.httpsession.serialize.KryoSerializerImpl
# serializer.logLevel = 1
javaSerialization=com.esotericsoftware.kryo.serializers.JavaSerializer
## classes registation: class1, class2, ...,classN
serializer.classSerializers=javax.security.auth.Subject:$javaSerialization,org.springframework.security.core.userdetails.User:$javaSerialization,org.springframework.security.core.context.SecurityContextImpl:$javaSerialization

compressor=com.gigaspaces.httpsession.serialize.CompressorImpl

# Set the cacheManager to use the GigaSpaceCacheManager
cacheManager=com.gigaspaces.httpsession.sessions.GigaSpacesCacheManager
cacheManager.initialCapacity=1000
cacheManager.maximumCapacity=10000
cacheManager.concurrencyLevel=32
cacheManager.storeMode=$storeMode
cacheManager.serializer=$serializer
cacheManager.policy=$policy
# space proxy setter
cacheManager.connector=$connector
cacheManager.compressor=$compressor

# This will use GigaSpaces for _all_ of Shiro's caching needs (realms, etc), not just for Session storage.
securityManager.cacheManager=$cacheManager

{% endhighlight %}
{%endaccord%}

{%accord title=Session Sharing Configuration Example For Secured Application Using Shiro Security...  | parent=acc0%}
{% note %}Note that this example uses the basic authentication configuration but, Shiro has various authenticator types see [realm modules](http://shiro.apache.org/static/1.2.1/apidocs/org/apache/shiro/authc/class-use/AuthenticationException.html) {% endnote %}
{% highlight ini %}

[main]
# space proxy wraper
connector=com.gigaspaces.httpsession.SpaceConnector
connector.url=jini://*/*/sessionSpace
# When using secured GigaSpace cluster, pass the credentials here
# connector.username = <username>
# connector.password = <password>
# Default lease is Lease.FOREVER so that the session won’t be removed from the space
# connector.sessionLease = 9223372036854775807
# Default read timeout is 5 minutes = 5 * 60 * 1000 = 300000
connector.readTimeout = 300000

# The SpaceDocument class name that holds the session attributes in space
connector.sessionBaseName=com.gigaspaces.httpsession.models.DefaultSpaceSessionStore

# Model Manager service
storeMode=com.gigaspaces.httpsession.sessions.DeltaStoreMode
storeMode.connector=$connector
listener1 = com.gigaspaces.httpsession.policies.TraceListener
storeMode.listener=$listener1

# Set the sessionManager to use an enterprise cache for backing storage:
sessionDAO=org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO
sessionManager=com.gigaspaces.httpsession.GigaSpacesWebSessionManager
sessionManager.sessionDAO=$sessionDAO
sessionManager.storeMode=$storeMode

# ensure the securityManager uses our native SessionManager:
securityManager.sessionManager=$sessionManager

# Session Policy Service
policy=com.gigaspaces.httpsession.policies.SessionPolicyWithLogin
policy.connector=$connector
policy.storeMode=$storeMode

# Serialization Service
serializer=com.gigaspaces.httpsession.serialize.KryoSerializerImpl
# serializer.logLevel = 1
javaSerialization=com.esotericsoftware.kryo.serializers.JavaSerializer
## classes registation: class1, class2, ...,classN
serializer.classSerializers=javax.security.auth.Subject:$javaSerialization,org.springframework.security.core.userdetails.User:$javaSerialization,org.springframework.security.core.context.SecurityContextImpl:$javaSerialization

compressor=com.gigaspaces.httpsession.serialize.CompressorImpl

# Set the cacheManager to use the GigaSpaceCacheManager
cacheManager=com.gigaspaces.httpsession.sessions.GigaSpacesCacheManager
cacheManager.initialCapacity=1000
cacheManager.maximumCapacity=10000
cacheManager.concurrencyLevel=32
cacheManager.storeMode=$storeMode
cacheManager.serializer=$serializer
cacheManager.policy=$policy
# space proxy setter
cacheManager.connector=$connector
cacheManager.compressor=$compressor

# This will use GigaSpaces for _all_ of Shiro's caching needs (realms, etc), not just for Session storage.
securityManager.cacheManager=$cacheManager

[users]
## format: username = password, role1, role2, ..., roleN
root = secret,admin
guest = guest,guest
presidentskroob = 12345,president
darkhelmet = ludicrousspeed,darklord,schwartz
lonestarr = vespa,goodguy,schwartz
	
[roles]
## format: roleName = permission1, permission2, ..., permissionN
admin = *
schwartz = lightsaber:*
goodguy = winnebago:drive:eagle5

[urls]
## The /login.jsp is not restricted to authenticated users (otherwise no one could log in!), but
## the 'authc' filter must still be specified for it so it can process that url's
## login submissions. It is 'smart' enough to allow those requests through as specified by the
## shiro.loginUrl above.
/login.jsp = authc
/** = authc
##/logout = logout
##/account/** = authc
/remoting/** = authc, roles[b2bClient], perms["remote:invoke:lan,wan"]
{% endhighlight %}
{%endaccord%}

{%accord title=Session Sharing Configuration Example For Secured Application Using Spring Security...  | parent=acc0%}
{% note %}Note that in order to use Spring Security you still have to provide `shiro.ini` configuration file.
{%wbr%}The configuration should be similar to the one in the **Non-Secured Application** example above. {% endnote %}

Below is an example for the spring-security.xml that should be located under `WEB-INF` folder.
{% highlight xml %}
<beans:beans xmlns="http://www.springframework.org/schema/security"
			 xmlns:beans="http://www.springframework.org/schema/beans"
			 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			 xsi:schemaLocation="http://www.springframework.org/schema/beans
	http://www.springframework.org/schema/beans/spring-beans-4.1.xsd
	http://www.springframework.org/schema/security
	http://www.springframework.org/schema/security/spring-security-3.2.xsd">

	<http auto-config="true" create-session="never">
		<intercept-url pattern="/**" access="ROLE_USER"/>
		<intercept-url pattern="/UpdateSessionServlet**" access="ROLE_USER" />
		<logout logout-success-url="/" />
		<session-management session-fixation-protection="none">
			<concurrency-control/>
		</session-management>
	</http>

	<authentication-manager>
		<authentication-provider>
			<user-service>
				<user name="user1" password="user1" authorities="ROLE_USER" />
				<user name="user2" password="user2" authorities="ROLE_USER" />
			</user-service>
		</authentication-provider>
	</authentication-manager>

</beans:beans>
{% endhighlight %}

In addition, you need to add the following in your web.xml file:

{% highlight xml %}

<!-- Spring MVC -->
<listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>

<context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>/WEB-INF/spring-security.xml</param-value>
</context-param>

<!-- Spring Security -->
<filter>
    <filter-name>springSecurityFilterChain</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>

<filter-mapping>
    <filter-name>springSecurityFilterChain</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
  
{% endhighlight %}

{%endaccord%}


{%endaccordion%}

<br>

# Web Application Libraries

The web application should include the following libraries within its `\WEB-INF\lib` folder:
 
* gs-session-manager-xxx.jar - located within the `XAP ROOT\lib\optional\httpsession` folder.
* gs-runtime.jar  - located within the `XAP ROOT\lib\required` folder.

{% note %}
The `gs-runtime.jar` should be replaced with the relevant XAP `gs-runtime.jar` matching your XAP data grid release.
{% endnote %}

Another option is to use Maven:

{% highlight xml %}
<repositories>
	<repository>
		<id>org.openspaces</id>
		<name>OpenSpaces</name>
		<url>http://maven-repository.openspaces.org</url>
		<releases>
			<enabled>true</enabled>
			<updatePolicy>daily</updatePolicy>
			<checksumPolicy>warn</checksumPolicy>
		</releases>
		<snapshots>
			<enabled>true</enabled>
			<updatePolicy>always</updatePolicy>
			<checksumPolicy>warn</checksumPolicy>
		</snapshots>
	</repository>
</repositories>
<dependencies>
	<dependency>
		<groupId>com.gigaspaces.httpsession</groupId>
		<artifactId>gs-runtime</artifactId>
		<version>{%version maven-version %}</version>
	</dependency>

	<dependency>
		<groupId>com.gigaspaces.httpsession</groupId>
		<artifactId>gs-session-manager</artifactId>
		<version>{%version maven-version %}</version>
	</dependency>
</dependencies>
{% endhighlight %}


# Deployment

The XAP IMDG should be deployed using one of the [topologies](/product_overview/space-topologies.html).

{% highlight bash %}
# To deploy the IMDG called `sessionSpace` start the XAP agent using:
<XAP-HOME>/bin/gs-agent

# and run the following command to deploy the session Space:
<XAP-HOME>/bin/gs deploy-space sessionSpace

{% endhighlight %}


{% refer %}See the [deploy-space]({%currentadmurl%}/deploy-command-line-interface.html) command for details.
{% endrefer %}

### Classpath
The `gs-session-manager-xxx.jar` located within the `\gigaspaces-xap-root\lib\optional\httpsession` folder should be copied into the `\gigaspaces-xap-root\lib\platform\ext` folder. 

### Securing the XAP IMDG

When using a [Secure XAP cluster]({%currentsecurl%}/securing-your-data.html) you can pass security credentials using following parameters in the `shiro.ini` file:

{%highlight ini%}
connector.username = user
connector.password = pass
{%endhighlight%}


# Example

{%refer %}
Examples of using the XAP HTTP Session can be found [here]({%currentjavatuturl%}/http-session-sharing.html) 
{%endrefer%}

{% comment %}

The example can be deployed into any web server (Tomcat, JBoss, Websphere, Weblogic, Jetty, GlassFish). It demostrates Single Application Session Sharing configuration.

1. Download the demo web application {%download /download_files/demo-app.war%}.
2. Deploy a space named **sessionSpace**. You may have a single instance Space or deploy a clustered Space using the command line , GS-UI or the Web-UI.
3. Deploy the `demo-app.war` into Tomcat (or any other app server).
4. Start your browser and access the web application via the following URL: http://localhost:8080/demo-app

{% note %}
The URL above assumes the Web Server is configured to use port 8080.
{% endnote %}


{%panel title=Set some attributes with their name and value and click the **Update Session** button.%}
![httpSessionSharing4.jpg](/attachment_files/http-session-sharing-single-1.png)
{%endpanel%}


{%panel title=View the session updated within the space via the GS-UI or Web-UI.%}
![httpSessionSharing4.jpg](/attachment_files/http-session-sharing-single-2.png)
{%endpanel%}

{%panel title=Identify the Session ID%}
![httpSessionSharing4.jpg](/attachment_files/http-session-sharing-single-3.png)
{%endpanel%}

{%tip%}
Restart your web application and refresh the page. The session will be reloaded from the data grid.
{%endtip%}

{%endcomment%}
{%comment%}
### Multi-Web Servers Deployment

You may share the HTTP session between different web servers. To test this on your local environment you can install multiple web servers, deploy the web application and have your browser access the same application via the same browser. See the below example:

{%panel%}
{%section%}
{%column width=50% %}
![httpSessionSharing8.jpg](/attachment_files/httpSessionSharing8.jpg)
{%endcolumn%}
{%column width=50% %}
![httpSessionSharing9.jpg](/attachment_files/httpSessionSharing9.jpg)
{%endcolumn%}
{%endsection%}


{%tip%}
Hit the Refresh button when switching between the tabs. The session data will be refreshed with the relevant app server reading it from the Space.
{%endtip%}

{%endpanel%}

{% note %}
When deploying the web application WAR file please make sure the web app context will be identical.
{% endnote %}


{%endcomment%}

# Considerations

## Web Application Context

Global HTTP session sharing works only when your application is deployed as a non-root context. It is relying on browser cookies for identifying user session, specifically `JSESSIONID` cookie. Cookies are generated at a context name per host level. This way all the links on the page are referring to the same cookie/user session.

## WebSphere Application Server HttpSessionIdReuse Custom Property

When using XAP Global HTTP session sharing with applications deployed into WebSphere Application Server, please enable the [HttpSessionIdReuse](http://pic.dhe.ibm.com/infocenter/wasinfo/v7r0/index.jsp?topic=%2Fcom.ibm.websphere.express.doc%2Finfo%2Fexp%2Fae%2Frprs_custom_properties.html) custom property. In a multi-JVM environment that is not configured for session persistence setting this property to true enables the session manager to use the same session information for all of a user's requests even if the Web applications that are handling these requests are governed by different JVMs.

## Transient Attribute

An attribute specified as *transient* would not be shared and its content will not be stored within the IMDG. Your code should be modified to have this as a regular attribute that can be serialized.

## Webserver's Java version

Please note that:

- Jetty 9 does not support JDK6.
- JBoss 7 does not support JDK8.



## Modifying Session Attributes

We assume that no attributes are changed in the login phase: Changing a regular attribute in the login request will store the change in-memory but won't save it in the space.
