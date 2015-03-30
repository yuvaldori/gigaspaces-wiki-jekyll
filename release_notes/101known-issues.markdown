---
layout: post
title:  Known Issues and Limitations
categories: RELEASE_NOTES
parent: xap101.html
weight: 400
---


Below is a list of known issues in GigaSpaces 10.1.X.



{: .table .table-bordered .table-condensed}
| Key | Summary | SalesForce ID | Workaround | Platform/s |
|:-------|:--------|:----------------|:------------------|:----------|
| <nobr>GS-11954</nobr> | Bottom section in Applications tab opens with minimum height (Sometimes, mainly when doing a refresh to the page, entering the Applications tab shows the bottom section of the page with a minimum height.) | | | Java |
| GS-11955 | Refreshing the webui might not reload all data (for example Applications -> Events Grid) | | | Java |
| GS-11960 | NullPointerException is printed in GSA when deploying data example | | | Java |
| GS-11967 | start_tutorial.sh printed text is not colored in MacOS | | | Java |
| GS-11970 | Double click on a GSC in the Hosts-services tab throws IllegalArgumentException | | | Java |
| GS-11971 | Unnecessary prints in the UI (Running a query from the gs-ui prints five lines apparently via system.out and not log) | | | Java |
| GS-11980 | Deploying space with default values throws SpaceURLValidationException | | | .Net |
| GS-11983 | When configure wan gateway os-gateway:targets doesn't work with os-core:embedded-space  | | | Java |
| GS-11990 | Deploy space with cluster-schema=none fails and causes SpaceURLValidationException: The <total_members> attribute must be used together with the <cluster_schema> attribute | | | .Net |
| GS-12025 | Memory keeps growing in Gsc.exe | 9270 | | .Net |
| GS-12027 | StackOverflowError in GS-LRMI thread when loading class with large hierarchy | 9244.9199  | | All |
| GS-12028 | Redolog keep growing when connection between server and localview client can't be established | 9256 | | Java |
| GS-12029 | Inconsistent Lookup Timeout, Dynamic locators are initialised even though they are disabled, so the lookup waits the default initialisation delay that is 10sec. Sometimes this happens on the lookup thread | 9270 | | All |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
| GS-12040 |  Wrong log message (FINEST) when commit transaction failed  | 9166 | | Java |
