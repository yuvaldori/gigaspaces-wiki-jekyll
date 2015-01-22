---
layout: post
title:  What's New
categories: RELEASE_NOTES
parent: xap101.html
weight: 100
---

This page lists the main new features in XAP 10.1 (Java and .Net editions). It's not an exhaustive list of all new features. For a full change log for 10.1 please refer to the [new features](./101new-features.html) and [fixed issues](./101fixed-issues.html) pages.


{%panel%}

- [Mertics](#metrics)

- [Sequence Number](#snumber)

REST

- [REST API](#rest1)

- [Deploy REST API via CLI](#rest2)


<br>

Third Party library upgrades

- [Hibernate  4.1 support](#hibernate)

- [Spring  4.1 support](#spring)

{%endpanel%}

{%comment%}

Elastic deployment with command line


Sequence Number   http://localhost:4000/xap101/pojo-attribute-annotations.html#sequence-number



Matrics    xap101adm/metrics-overview.markdown



REST API    xap101/rest-service-overview.markdown
Deploy REST API via CLI xap101adm/rest-deploy-command-line-interface.markdown


upgrade to hibernate 4.1.8
upgrading to Spring 4.1

{%endcomment%}


{%anchor hibernate%}


{%anchor metric%}

# Metrics

XAP provides a framework for collecting and reporting metrics from the distributed runtime environment into a metric repository of your choice, which can then be analysed and used to identity trends in the system behaviour.

{%learn%}/xap101adm/metrics-overview.html{%endlearn%}

# Third Party library updates

### Hibernate 4.1 support

This release supports the Hibernate framework 4.1

{%anchor spring%}

### Spring 4.1 support

This release supports the Spring framework 4.1
