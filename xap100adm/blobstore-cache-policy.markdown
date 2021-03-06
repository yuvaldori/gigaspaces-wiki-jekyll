---
layout: post100adm
title:  Flash drive IMDG Storage - MemoryXtend for SSD
categories: XAP100ADM
parent: memory-management-overview.html
weight: 400
---

{% summary %}  {% endsummary %}


{% section %}
{% column  width=10% %}

![flash-imdg.png](/attachment_files/subject/flash-imdg.png)
{% endcolumn %}
XAP 10 introduces a new Storage interface that allows an external storage mechanism (one that does not reside on the JVM heap) to act as storage medium for the data in the IMDG. This storage model allows the IMDG to interact with the storage medium for storing IMDG data.

{% column width=90% %}

{% endcolumn %}
{% endsection %}


This storage model allows you to leverage high capacity storage mediums such as enterprise flash drives (SSD) or the RAM capacity external to heap of the JVM process that contains the IMDG. This storage model leverages the JVM heap to store indexes and the external storage medium to store the raw data in a serialized form. This page referes to the SSD based implementation, future implementations such as RAM based off-heap storage will be added in one the next XAP releases. 

![blobstore1.jpg](/attachment_files/blobstore1.jpg)

The JVM heap is used also as a first level cache for frequently used data. Repetitive read operations (by Id, by template or using a SQL query) for the same data will be loaded from the external storage medium upon the first reqeust and later be served from the JVM heap based cache.

## How Is This Storage Model Different from the Traditional XAP Persistence Model?
Unlike the traditional XAP persistence model, where the IMDG backing store is usually a database with relatively slow response time, located in a central location, the storage interface assumes very fast access for write and read operations, and a local, dedicated data store that supports a key/value interface. Each IMDG primary and backup instance across the grid is interacting with its dedicated storage medium (in our case SSD drive) independently in an atomic manner. 

When running a traditional persistence configuration, the IMDG serves as a front-end to the database, and is acting as a transactional cache storing a subset of the data. In this configuration data is loaded in a lazy manner to the IMDG with the assumption that the heap capacity is smaller than the entire data set.


In the enternal storage medium mode, the entire data data set is kept on the external SSD drive. The assumption is the SSD capacity across the grid is large enough to accommodate for the entire data set of the application.

## Reduced Garbage Collection Activity

Since the IMDG raw data is stored outside of the JVM heap (the default implementation is using an SSD device) the garbage collector does not need to manage this memory. This reduces the garbage collection pauses. This in turn allows the IMDG to manage significantly larger data sets using the SSD drive's capacity (typically several TBs of data) and not be constrained by the size of the JVM heap. When using multiple IMSG nodes, a single data grid cluster can easily manage a few tens of TBs.

## Supported SSD Devices

All Enterprise flash drives are supported. SanDisk, Fusion-IO, Intel® SSD , etc are supported with the IMDG storage technology. Central SSD (RAID) devices such as Tegile, Cisco Whiptail, DSSD, and Violin Memory are also supported.

## Supported XAP APIs

All XAP APIs are supported with the BlobStore configuration. This includes the Space API (POJO and Document), JDBC API, JPA API, JMS API, and Map API. 

## How It Works

XAP is using [SanDisk Flash Data Fabric (FDF)](http://www.sandisk.com/) library, which uses direct flash access. It circumvents OS level storage interfaces when writing an object to the space, its indexed data maintained on Heap where the Storage interface implementing using the FDF libraries to interact with the underlying flash drive. 

![blobstore2.jpg](/attachment_files/blobstore2.jpg)

The indexes maintain in RAM allowing the XAP query engine to evaluate the query without accessing the raw data stored on the flash device. This allows XAP to execute SQL based queries extremely efficiently even across large number of nodes. All XAP Data Grid APIs are supported including distributed transactions, leasing (Time To live) , FIFO , batch operations ,etc. All clustering topologies supported. All client side cache options are supported.

# The BlobStore Configuration

The BlobStore settings includes the following options:

{: .table .table-bordered}
| Property               | Description                                               | Default | Use |
|:-----------------------|:----------------------------------------------------------|:--------|:--------|
| devices | Flash devices. Comma separated available devices. The list used as a search path from left to right. The first one exists will be used. |  | required |
| volume-dir | Directory path contains a symbolic link to the the SSD device. | | required |
| blob-store-capacity-GB | Flash device allocation size in Gigabytes. | 200 | optional |
| blob-store-capacity-MB | Flash device allocation size in Megabytes. | 204800 | optional |
| blob-store-cache-size-MB | FDF internal cache size in Megabytes. | 100 | optional |
| blob-store-reformat | Whether to clear all SSD data on space initialization phase or not. | false | optional |
| enable-admin | Whether to start an FDF admin agent or not. FDF admin provides a simple command line interface (CLI) through a TCP port. The FDF CLI uses port 51350 by default. This port can be changed through the configuration parameter FDF_ADMIN_PORT. | true |
| statistics-interval | Applications can optionally enable periodic dumping of statistics to a specified file (XAP_HOME/logs). This is disabled by default. | | optional |
| durability-level | PERIODIC: sync storage every 1024	writes. Up to 1024 objects can be lost in the event of application crash.{%wbr%}SW_CRASH_SAFE: This policy guarantees no data loss in the event of software crashes. But some data might be lost in the event of hardware failure.{%wbr%}HW_CRASH_SAFE: This policy guarantees no data loss if the hardware crashes.Since there are performance implication it is recommended to work with NVRAM device and configure log-flash-dir to a folder on this device. | PERIODIC | optional |
| log-flush-dir | In case of HW_CRASH_SAFE, directory in a file system on top of NVRAM backed disk. This directory must be unique per space, you can add ${clusterInfo.runningNumber} as suffix | /tmp | optional |

The IMDG BlobStore settings includes the following options:{%wbr%}

{: .table .table-bordered}
| Property | Description | Default | Use |
|:---------|:------------|:--------|:--------|
| blob-store-handler | BlobStore implementation |  | required |
| cache-entries-percentage | Cache percentage of the JVM max memory(-Xmx). In case of missing `-Xmx` configuration the cache size will `10000` objects. This is an LRU based data cache which store the entire IMDG object.| 20% | optional |
| avg-object-size-KB |  Average object size. | 5KB | optional |

# Installation

Step 1. 
Install XAP as usual.

Step 2. 
Install FDF libraries:

{% highlight xml %}
sudo XAP_HOME=<XAP HOME> sh -c "rpm -ivh /blobstore-1.0-SNAPSHOT20140XXXXXXXXX.noarch.rpm"
{% endhighlight %}

Step 3. 
Use the `XAP HOME\bin\gs-agent-blobstore.sh` to start GigaSpaces Grid Agent that configured to load the FDF libraries.

{%note title=Supported OS%}XAP Flash Storage library is supported only CentOS 5.8-5.10{%endnote%}

# Configuration
Configuring an IMDG (Space) with BlobStore should be done via the `SanDiskBlobStoreDataPolicyFactoryBean`, or the `SanDiskBlobStoreConfigurer`. For example:

## PU XML Configuration
{% inittab os_simple_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xmlns:blob-store="http://www.openspaces.org/schema/blob-store"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
       http://www.openspaces.org/schema/core http://www.openspaces.org/schema/10.0/core/openspaces-core.xsd
       http://www.openspaces.org/schema/blob-store http://www.openspaces.org/schema/10.0/blob-store/openspaces-blobstore.xsd">

    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"/>

    <blob-store:sandisk-blob-store id="blobstoreid" volume-dir="/tmp" devices="/dev/xvdb,/dev/xvdc"
            blob-store-capacity-GB="200" blob-store-cache-size-MB="50" blob-store-reformat="true" durability-level="SW_CRASH_SAFE">
    </blob-store:sandisk-blob-store>

    <os-core:space id="space" url="/./mySpace" >
        <os-core:blob-store-data-policy blob-store-handler="blobstoreid" cache-entries-percentage="10" avg-object-size-KB="5"/>
    </os-core:space>

    <os-core:giga-space id="gigaSpace" space="space"/>
</beans>
{% endhighlight %}
{% endtabcontent %}

{% tabcontent Plain XML %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
       http://www.openspaces.org/schema/core http://www.openspaces.org/schema/10.0/core/openspaces-core.xsd">

    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"/>

    <bean id="blobstoreid" class="com.gigaspaces.blobstore.storagehandler.SanDiskBlobStoreHandler">
        <property name="blobStoreCapacityGB" value="200"/>
        <property name="blobStoreCacheSizeMB" value="50"/>
        <property name="blobStoreDevices" value="/dev/xvdb,/dev/xvdc"/>
        <property name="blobStoreVolumeDir" value="/tmp"/>
        <property name="blobStoreDurabilityLevel" value="SW_CRASH_SAFE"/>
    </bean>

    <os-core:space id="space" url="/./mySpace" >
        <os-core:blob-store-data-policy blob-store-handler="blobstoreid" cache-entries-percentage="10"
            avg-object-size-KB="5"/>
    </os-core:space>

    <os-core:giga-space id="gigaSpace" space="space"/>
</beans>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}


## Programmatic API
Programmatic approach to start a BlobStore space:
{% highlight java %}
SanDiskBlobStoreConfigurer configurer = new SanDiskBlobStoreConfigurer();
configurer.addDevices("/dev/xvdb,/dev/xvdc");
configurer.addVolumeDir("/tmp");
configurer.setBlobStoreCapacityGB(200);
configurer.setBlobStoreCacheSizeMB(50);
configurer.setDurabilityLevel(DurabilityLevel.SW_CRASH_SAFE);

SanDiskBlobStoreHandler blobStoreHandler = configurer.create();
BlobStoreDataCachePolicy cachePolicy = new BlobStoreDataCachePolicy();
cachePolicy.setAvgObjectSizeKB(5l);
cachePolicy.setCacheEntriesPercentage(10);
cachePolicy.setBlobStoreHandler(blobStoreHandler);

UrlSpaceConfigurer urlConfig = new UrlSpaceConfigurer(spaceURL);
urlConfig.cachePolicy(cachePolicy);

gigaSpace = new GigaSpaceConfigurer(urlConfig).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

The above example:
- Configures the SanDisk BlobStore bean.{%wbr%}
- Configures the Space to use the above blobStore implementation also configure the cache size, in this LRU cache the space store also the data objects and not just the object indexes in RAM.

# Controlling blobStore mode at the Space Class Level
By default any Space Data Type is `blobStore` enabled. When decorating the space class with its meta data you may turn off the `blobStore` behavior using the `@SpaceClass blobStore` annotation or gs.xml `blobStore` tag.

Here is a sample annotation disabling `blobStore` mode:

{% highlight java %}
@SpaceClass(blobStore = false)
public class Person {
    .......
}
{% endhighlight %}

Here is a sample xml decoration for POJO class disabling `blobStore` mode:
{% highlight java %}
<gigaspaces-mapping>
    <class name="com.test.Person" "blobstore"="false" >
     .....
     </class>
</gigaspaces-mapping>
{% endhighlight %}


# BlobStore Management

You may use the FDF Management command line to access underlaying SSD storage runtime. This allows you to access statistics that can be used to tune performance and analyze performance problems. These statistics counters used to monitor events within the FDF subsystem. Most events are counted on a per FDF container basis as well as for all containers within the FDF instance. 


## Statistics

FDF available Statistics:

- Counts of FDF access types
- Counts of various flash activities
- Histogram of key sizes
- Histogram of data sizes in bytes
- Histogram of access latencies in microseconds
- Number of events , Minimum , Maximum , Average , Geometric mean , Standard deviation
- Overwrite/Write-­‐Through Statistics
- Total number of created objects
- Number of get/put/delete operations
- Number of hash/flash/invalid evictions
- Number of objects in flash
- Number of soft/hard overflows in hast table
- Number of pending IO’s
- Flash space allocated/consumed in bytes
- Number of overwrites
- Number of hash collisions for get/set operations

Applications can optionally enable periodic dumping of statistics to a specified file. This is disabled by default. It can be enabled using the configuration parameter `FDF_STATS_FILE=<filepath>`. The dump interval can be configured using `FDF_STATS_DUMP_INTERVAL=<interval in secs>`. The dump interval can also be dynamically changed through the CLI.

{%accordion id=acc0%}
{%accord title=Typical statistics output | parent=acc0%}
{% highlight console %}
Per Container Statistics
Container Properties:
	name = e12e3940
	cguid = 419
	Size = 0 kbytes
	persistence = enabled
	eviction = disabled
	writethrough = enabled
	fifo = disabled
	async_writes = disabled
	durability = Periodic sync
	num_objs = 7645
	used_space = 3914240
	Application requests:
	num_set_objs_with_expiry = 7645
	completed_enumerations = 1
	active_enumerations = 1
	objects_enumerated = 402
	cached_objects_enumerated = 402
	Overwrite and write-through statistics:
	num_new_entries = 7645
	num_writethrus_to_flash = 7645
	Cache to Flash Manager requests:
	cache_misses = 0
	cache_hits = 0
	num_set_objs_and_put = 7645
Flash Manager responses to cache:
	num_set_objs_completed = 7645
Flash Manager requests/responses:
	num_set_objs = 7645
Flash layer return codes:
	num_success = 7645
Overall FDF Statistics
Flash statistics:
	num_items_flash = 2167157
	num_items_created = 2188567
	num_overwrites = 21410
	num_put_ops = 2188567
	flash_space_allocated = 1409286144
	flash_space_consumed = 36186112
Flash layout:
	flash_class_map 27 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	flash_slab_map 1705845 461327 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Application requests:
	num_put_objs = 1233
	num_set_objs_with_expiry = 72018
	num_get_objs = 419
	num_del_objs = 1221
	num_flush_objs = 2479
	num_sync_to_flash = 2479
	num_flush_container = 408
Overwrite and write-through statistics:
Cache to Flash Manager requests:
	cache_misses = 0
	cache_hits = 0
	num_delete_objs = 1221
	num_get_objs_to_read = 419
	num_put_objs = 1233
	num_set_objs_and_put = 72018
Flash Manager responses to cache:
	FDF Programming Guide – 1.2 Sandisk Confidential 35
	num_delete_objs_completed = 1221
	num_get_objs_to_read_failed = 419
	num_put_objs_completed = 1233
	num_set_objs_completed = 72018
Flash Manager requests/responses:
	num_get_objs = 419
	num_get_objs_failed = 419
	num_delete_objs = 1221
	num_delete_completed = 1221
	num_set_objs = 73251
Flash layer return codes:
	num_success = 74472
	num_errors_objects_not_found = 419
Cache statistics:
	num_hash_buckets_in_cache = 100000
	num_cache_partitions = 10000
	num_objects_in_cache = 66252
	max_cache_capacity = 100000000
	current_data_size_in_cache = 14434903
	current_key_and_data_size_in_cache = 19129759
	num_modified_objs_in_cache = 4601
	num_bytes_of_modified_objs_in_cache = 889931
	num_mod_objs_flushed = 245891
	num_mod_objs_flushed_by_bgflush = 838438
	background_flush_progress = 93
	num_background_flushes = 363
	max_parallel_flushes = 8
	max_parallel_bg_flushes = 8
	time_to_wait_after_bgflush_for_nodirty_data = 1000
	max_percent_limit_on_modifiable_cache = 100
	num_cache_ops_in_progress = 18
{% endhighlight %}
{%endaccord%}
{%endaccordion%}

## Command Line Interface

FDF provides a simple command line interface (CLI) through a TCP port. The FDF CLI uses port `51350` by default. This port can be changed through the configuration parameter `FDF_ADMIN_PORT=<port number>`. The CLI functionality can be disabled by setting configuration property `FDF_ADMIN_ENABLED=0`. The CLI supports the following commands.

{: .table .table-bordered}
| Command | Description | 
|:--------|:------------|
|container list|Lists all of the container names|
|container stats `<container name>[v]` | Prints stats of the given container. The option v (verbose) prints extended stats.|
|container `stats_dump <container name|all> [v]` | Prints stats of a given container or all containers to the stats file configured through `FDF_STATS_FILE`. The option v(verbose) prints extended stats.
|container autodump `<enable/disable/interval/printcfg> [interval in secs]`  | This command enables or disables periodic stats dump, and configures the dump interval.|
|log_level `<set/get> [fatal/error/warning/info/diagnostic/ debug/trace/trace_low/devel]`| Sets the log level| 
|help | Prints help for all supported commands|
|quit |Quits the telnet session|

{%accordion id=acc1%}
{%accord title=Sample FDF CLI usage | parent=acc1%}

{% highlight console %}
[root@xen200v03]~# telnet localhost 51350
Trying 127.0.0.1...
Connected to localhost.localdomain (127.0.0.1).
Escape character is '^]'.
help
Supported commands:
container stats <container name> [v]
container stats_dump <container name|all> [v]
container autodump <enable/disable/interval/printcfg> [interval in secs]
container list
log_level <set/get> [fatal/error/warning/info/diagnostic/debug/trace/trace_low/devel]
help
quit
container list
container-4819c940
container stats container-4819c940
Timestamp:Tue May 7 12:06:45 2013
Per Container Statistics
	Container Properties:
		name = container-4819c940
		cguid = 4
		Size = 1048576 kbytes
		persistence = enabled
		eviction = disabled
		writethrough = enabled
		fifo = disabled
		async_writes = disabled
		durability = Periodic sync
		num_objs = 1
		used_space = 512
	Application requests:
		num_set_objs_with_expiry = 1
		num_get_objs_and_check_expiry = 1
		completed_enumerations = 1
		objects_enumerated = 1
		cached_objects_enumerated = 1
	Overwrite and write-through statistics:
		num_new_entries = 1
		num_writethrus_to_flash = 1
	Cache to Flash Manager requests:
		cache_misses = 0
		cache_hits = 1
	num_set_objs_and_put = 1
	Flash Manager responses to cache:
		num_set_objs_completed = 1
	Flash Manager requests/responses:
		num_set_objs = 1
	Flash layer return codes:
		num_success = 1
{% endhighlight %}
{%endaccord%}
{%endaccordion%}
		
		
		
# The BlobStoreStorageHandler Interface

The `BlobStoreStorageHandler` Interface provides the following methods. You may customize it to have your specific functionality:  
{% highlight java %}
abstract class BlobStoreStorageHandler 
{
  public void initialize(String spaceName, Properties properties, boolean warmStart){};
  public abstract Object add(java.io.Serializable id,java.io.Serializable data, BlobStoreObjectType objectType);
  public abstract  java.io.Serializable get(java.io.Serializable id, Object position,  BlobStoreObjectType objectType);
  public abstract  Object replace(java.io.Serializable id,java.io.Serializable data,  Object position,  BlobStoreObjectType objectType);
  public abstract void  remove(java.io.Serializable id, Object position, BlobStoreObjectType objectType);
  public List<BlobStoreBulkOperationResult> executeBulk(List<BlobStoreBulkOperationRequest> operations, BlobStoreObjectType objectType, boolean transactional)
  public  DataIterator<BlobStoreGetBulkOperationResult> iterator(BlobStoreObjectType objectType)
  public Properties getProperties(){};
  public void close(){};
}
{% endhighlight %}


{%info%}
Answers to frequently asked questions about MemoryXtend for SSD can be found [here](/faq/blobstore-cache-policy-faq.html)
{%endinfo%}
