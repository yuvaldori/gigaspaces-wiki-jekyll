---
layout: post
title:  Backward Compatibility
categories:  RELEASE_NOTES
parent: xap102.html
weight: 600
---

XAP 10.2 is a major release which includes [new features and improvements.](./102whats-new.html)

{%comment%}
{%tip title=Upgrading from previous versions%}
As a best practice, when upgrading to XAP 10.2, unzip the latest version of XAP 10.1 and port the necessary changes from your previous environment into your new 10.1 environment. It is recommended to use the XAP 10.1 distribution as-is. For more details please refer to the [Upgrade Guide](./101upgrading.html).
{%endtip%}

The following table describes backwards compatibility support in XAP 10.1.x:

{: .table .table-bordered .table-condensed}
|Delivery|XAP API/Configuration|XAP Binaries|Client-Server|Server-Server|
|:-------------------------------|:-------------------------------------------|:----|:----|:----|
| Service Pack / Patch (10.1.x)  | YES                                        | YES | YES | YES |
| Major Version (8.0.x or later) | YES (see note on deprecation policy below) | NO  | YES | NO  |

### Supported

* Applications built using 8.0.x (or later) run without any code changes on a clean 10.1.x installation.
* Clients running on 8.0.x (or later) can run against 10.1.x servers. 
* Servers running different versions of 10.1.x (service packs/patches) can be mixed together (i.e. part of the same cluster).

{%exclamation%} In extreme cases, a service pack or a patch might break backwards compatibility. In such cases, it will be highlighted in the the release notes.

Please refer to the [Deprecation and End-of-Life policy](http://www.gigaspaces.com/EOL) for more details.

### Unsupported

* Servers running on pre-10.1.x cannot be mixed (i.e. part of the same cluster) with 10.1.x servers.
* UI and CLI running on pre-10.1.x is not guaranteed to work with 10.1.x servers.

{%endcomment%}