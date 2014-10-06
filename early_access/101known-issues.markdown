---
layout: post
title:  Known Issues and Limitations
categories: EARLY_ACCESS
parent: none
weight: 400
---


Below is a list of known issues in GigaSpaces 10.1.X.


{: .table .table-bordered .table-condensed}
| Key | Summary | SalesForce ID | Since version | Workaround | Platform/s |
|:-------|:--------|:----------------|:---------------|:------------------|:----------|
| <nobr>GS-11855</nobr> | XAP 10 blobstore RPM gs-agent-blobstore.sh GSC_JAVA_OPTIONS | | 10.1.0 | | All |
| GS-11871 | Wrong data after reconnecting via the reconnect button in the webui | | 10.1.0 | | Java |
| GS-11872 | Problem with "Reset layouts" in "Data Grids" tab | | 10.1.0 | | Java |
| GS-11873 | Height of the header row is long | | 10.1.0 | | Java |
| GS-11874 | Text and icon is too close | | 10.1.0 | | Java |
| GS-11875 | Second section is too high/wide | | 10.1.0 | | Java |
| GS-11934 | Web-UI does not respond | | 10.1.0 | | Java |
| GS-11935 | Space deployment with BlobStore policy should fail if the handler can't be found | | 10.1.0 | | Java |
| GS-11937 | GSA start ans stop proccess in a loop reaching 100% cpu | 9158 | 10.1.0 | | All |
| GS-11944 | NPE is thrown in blobstore space and local view topology |  | 10.1.0 | | All |
| GS-11952 | ESM ignores com.gigaspaces.system.registryRetries | 9196 | 10.1.0 | | Java |
| GS-11953 | Attribute 'mirror' is not allowed to appear in element 'os-core:embedded-space' |  | 10.1.0 | | Java |
| GS-11954 | Bottom section in Applications tab opens with minimum height |  | 10.1.0 | | Java |
| GS-11955 | Refreshing the webui might not reload all data |  | 10.1.0 | | Java |
| GS-11960 | NullPointerException is printed in GSA when deploying data example |  | 10.1.0 | | Java |
| GS-11961 | xap-gateway recipe - missing library |  | 10.1.0 | | Java |
| GS-11967 | start_tutorial.sh printed text is not colored in MacOS |  | 10.1.0 | | Java |
| GS-11969 | BlobStoreException is thrown when writing MarshObject |  | 10.1.0 | | All |
| GS-11970 | Double click on a GSC in the Hosts-services tab throws IllegalArgumentException |  | 10.1.0 | | Java |
| GS-11971 | Unnecessary prints in the UI |  | 10.1.0 | | Java |
| GS-11978 | Memory Leak in FIfo Groups in certain condition | 9218 | 10.1.0 | | All |
| GS-11979 | IllegalArgumentException In GSiterator when one of select properties is compressed | 9220 | 10.1.0 | | Java |
| GS-11980 | Deploying space with default values throws SpaceURLValidationException |  | 10.1.0 | | .NET |
| GS-11983 | os-gateway:targets doesn't work with os-core:embedded-space |  | 10.1.0 | | Java |
| GS-11990 | deploy space with cluster-schema=none fails and causes SpaceURLValidationException: The <total_members> attribute must be used together with the <cluster_schema> attribute |  | 10.1.0 | | .NET |
| GS-12025 | Memory keeps growing in Gsc.exe | 9270 | 10.1.0 | | .NET |
| GS-12027 | StackOverflowError in GS-LRMI thread when loading class with large hierarchy |  | 10.1.0 | | All |
| GS-12028 | Redolog keep growing when connection between server and localview client can't be eshtablished | 9256 | 10.1.0 | | Java |
| GS-12029 | Inconsistent Lookup Timeout |  | 10.1.0 | | All |
| GS-12030 | Relocating the feeder of data example stops writing objects |  | 10.1.0 | | Java |
| GS-12035 | UnMarshallingException is occasionally thrown when undeploying data example |  | 10.1.0 | | Java |
| GS-12036 | Session example (web) has concurrency problem |  | 10.1.0 | | Java |
| GS-12040 | Wrong log message (FINEST) when commit transaction failed |  | 10.1.0 | | Java |
| GS-12041 | Querying indexed field with multiple OR'd predicates breaks FIFO ordering | 9291 | 10.1.0 | | Java |
| GS-12042 | ConcurrentMultiDataIterator should expose better root cause exception | 9207 | 10.1.0 | | All |
| GS-12044 | UnsupportedOperation when updating object from ui/cli if object has dynamic properties | 9271 | 10.1.0 | | All |