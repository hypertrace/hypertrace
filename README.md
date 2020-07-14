# Hypertrace
Hypertrace is a cloud-native distributed tracing based Observability platform
that gives visibility into your dev and production distributed systems.

Hypertrace was originally developed by Traceable as a highly scalable
distributed tracing platform and is used by Traceable’s cloud-native
application security platform. ‍ Realizing that Hypertrace was a powerful
standalone tracing and observability platform, Traceable created this open source
project for the software development community to use in their applications.

---


### To start using Hypertrace
- [Join the Hypertrace Workspace](https://www.hypertrace.org/get-started) on Slack to chat with other Hypertrace users.
- You will be invited to a private channel where you can download and unzip or unpack the installer file.
- Run `./hypertrace.sh install`

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
