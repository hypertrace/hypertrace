# Hypertrace

[![Documentation Status](https://readthedocs.org/projects/ansicolortags/badge/?version=latest)](http://docs.hypertrace.org/)

<img src="https://hypertrace-docs.s3.amazonaws.com/ht-logo-horizontal.png" width="200">

---

Hypertrace was originally developed by Traceable as a highly scalable distributed tracing platform. It collects rich, granular production application usage data and trains machine learning algorithms for Traceable’s cloud-native application security platform. ‍ Realizing that Hypertrace was a powerful standalone tracing and observability platform, Traceable created this open source project for the software development community to use in their applications.

It's designed to ingest and analyze large volumes of production trace data. Various open source and enterprise agents and tracers collect and send observability data directly from applications to Hypertrace for analysis. Data visualizations, reports, and dashboards are available in a web-based console to assist in monitoring cloud-native applications and resolving application and service performance problems.

---

## Feature Table
| Feature                                | Description                                                                                                                                            |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Aggregations                           | Hypertrace Explorer provides multiple parameters to help you aggregate your API and trace searches                                                     |
| Slice and dice                         | Hypertrace provides the ability to slice and dice traces to derive advanced insights                                                                  |
| Supports scalable real-time processing                        | Unlike most of the current open source solutions Hypertrace supports efficient and scalable real-time processing. |
| Native suppport for various collectors | Send and receive traces from OpenCesnus, Jaeger, Zipkin and OpenTelemetry                                                                             |
| Cloud Native Deployment                | Deploy Hypertrace on any Kubernetes cluster with Helm Charts and an installation script                                                               |
| Observability & Multiple APM features  | Hypertrace provides many observability metrics in it's dashboard and throughout the platform as needed and also provides some basic APM features      |

## Architecture

| ![space-1.jpg](https://s3.amazonaws.com/fininity.tech/DT/architecture.png) | 
|:--:| 
| *Hypertrace Architecture* |

## To start using Hypertrace

See our documentation on [docs.hypertrace.org](https://docs.hypertrace.org/).

| ![space-1.jpg](https://s3.amazonaws.com/fininity.tech/DT/getting-started.png) | 
|:--:| 
| *Getting started with Hypertrace* |

Follow these steps to get started with hypertrace:
- [Installation](https://docs.hypertrace.org/getting-started/installation/)
- [Instrumentation](https://docs.hypertrace.org/getting-started/Instrumentation/)
- [Quick start with sample app](https://docs.hypertrace.org/getting-started/quick-start/)

## To start tracing with Hypertrace

The [community repository] hosts all information about building Hypertrace from source, how to contribute code and documentation, who to contact about what, etc.

If you want to deploy hypertrace right away on docker desktop or any cloud platform you can refer to our [deployment docs]() or here are steps to quick start with docker desktop. 

### You have a working [Docker environment]() with [Kubernetes]() enabled.

```
git clone https://github.com/hypertrace/hypertrace-helm
cd hypertrace-helm
./hypertrace.sh install
```

For the full story, head over to the [developer's documentation].

## License



