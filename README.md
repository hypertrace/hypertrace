# Hypertrace
Hypertrace is a cloud-native distributed tracing based Observability platform
that gives visibility into your dev and production distributed systems.

Hypertrace was originally developed by Traceable as a highly scalable
distributed tracing platform. It collects rich, granular production application
usage data and trains machine learning algorithms for Traceable’s cloud-native
application security platform. ‍ Realizing that Hypertrace was a powerful
standalone tracing and observability platform, Traceable created this open source
project for the software development community to use in their applications.

It's designed to ingest and analyze large volumes of production trace data.
Various open source and enterprise agents and tracers collect and send
observability data directly from applications to Hypertrace for analysis.
Data visualizations, reports, and dashboards are available in a web-based console
to assist in monitoring and debugging cloud-native application issues.

---

## Features

### Ingest spans in different formats
Hypertrace supports ingestion of spans in different formats like Zipkin, OpenCesnus,
OpenTracing and Jaeger. We plan to use OpenTelemetry collector service also
in future, when it's ready but the goal is to support all formats so that the
user doesn't have to change a lot in the existing environments.

### Scalable real-time processing
Hypertrace's data processing is built with streaming technologies like
Kafka and Flink, which allows the platform to scale millions, even billions,
of spans per day with the same installation. Just add more resources to the
Kubernetes cluster, let the services scale horizontally to handle more load.

### Scalable Service Graph
Hypertrace provides highly scaleable service graph for your applications in real-time
without running any additional jobs or without delay. Service Graph UI even allows
you to selectively drill into a part of the graph and look at different metrics
like percentile latencies, call volumes, error rates, etc.

### Ad-hoc analytics support
Hypertrace's Explorer lets you analyze the trace data on different dimensions and
easily dig out meaningful insights at scale. Even better, you can segment the data,
slice & dice different metrics and see them visualizations. This is very powerful
and opens up lot more use cases instead of just a few pre-canned dashboards.

### Metric Aggregations
By leveraging an OLAP storage backend and modeling data for analytics, different
metrics collected via tracers can be aggregated at arbitrary dimensions, opening
up wide variety of use cases and opportunities to investigate unknown issues in
production applications at scale.

### Pre-built dashboards for everyone
Hypertrace has pre-built dashboards highlighting the KPIs(Key Performance Indicators)
and patterns of metrics for different components like Services,Backends and Endpoints,
enabling different personal like Devs, DevOps and Deployment specialists to get to
the problems they are debugging very quickly.

## Architecture

| ![space-1.jpg](https://s3.amazonaws.com/fininity.tech/DT/architecture.png) |
|:--:|
| *Hypertrace Architecture* |

### To start using Hypertrace

Visit Hypertrace documentation at [docs.hypertrace.org](https://docs.hypertrace.org/).

Follow these steps to get started with hypertrace:
- [Installation](https://docs.hypertrace.org/docs/getting-started/)
- [Quick start with sample app](https://docs.hypertrace.org/docs/sample-app/)

### To start tracing with Hypertrace

The [community repository]() hosts all information about building Hypertrace from source, how to contribute code and documentation, who to contact about what, etc.

If you want to deploy hypertrace right away on docker desktop or any cloud platform you can refer to our [deployment docs](https://docs.hypertrace.org/deployments/) or here are steps to quick start with docker desktop.

### You have a working [Docker environment](https://www.docker.com/) with [Kubernetes](https://kubernetes.io/) enabled.

```
git clone https://github.com/hypertrace/hypertrace-helm
cd hypertrace-helm
./hypertrace.sh install
```

For the full story, head over to the [developer's documentation].

## Related Repositories
### Documentation
* [Docs website](https://github.com/hypertrace/hypertrace-docs-website)

### Data Ingestion Pipeline
* [Span Normalizer](https://github.com/hypertrace/span-normalizer)
* [Span Aggregator](https://github.com/hypertrace/raw-spans-grouper)
* [Trace Enrichers](https://github.com/hypertrace/hypertrace-trace-enricher)
* [View Generators](https://github.com/hypertrace/hypertrace-view-generator)

### Query Layer Services
* [GraphQL](https://github.com/hypertrace/hypertrace-graphql)
* [Gateway Service](https://github.com/hypertrace/gateway-service)
* [Query Service](https://github.com/hypertrace/query-service)
* [Entity Service](https://github.com/hypertrace/entity-service)
* [Attribute Service](https://github.com/hypertrace/attribute-service)

### UI
* [Hypertrace UI](https://github.com/hypertrace/hypertrace-ui)
* [Hyperdash](https://github.com/hypertrace/hyperdash)
* [Hyperdash Angular](https://github.com/hypertrace/hyperdash-angular)

### Data Service Deployment
* [Kafka helm charts](https://github.com/hypertrace/kafka)
* [Pinot helm charts](https://github.com/hypertrace/pinot)
* [MongoDB helm charts](https://github.com/hypertrace/mongodb)


## License
Hypertrace follows open core model where "Hypertrace core" (or simply Core) is
under Apache 2.0 license, which has distributed trace ingestion and exploration
features. Services, Endpoints, Backends and Service Graph features are under
Traceable Community license.
