# Hypertrace
Hypertrace is a highly scalable, cloud-native observability platform that uses distributed tracing to give you visibility into your dev, test and production systems.

Traceable runs its cloud-native application security platform upon Hypertrace. Realizing that Hypertrace was a powerful standalone tracing and observability platform, Traceable created this open source project for the software development community to use in their applications.

---
## Quick Start
If you want to see Hypertrace in action, you can quickly start Hypertrace with [Docker Compose](https://docs.docker.com/compose/install/).

```
git clone https://github.com/hypertrace/hypertrace.git
cd hypertrace/docker
docker-compose -f docker-compose.yml up
```
This will pull all images and start all services required for Hypertrace. Within 1 minute, you may see `Hypertrace-UI` is 'Up (healthy)' in the terminal logs. Then you can visit Hypertrace at http://localhost:2020. 

If you have application that is already instrumented to send traces to Zipkin or Jaeger, you may use it with Hypertrace. 

If you don't, you can try Hypertrace with our sample application by running:

```
docker-compose -f docker-compose-zipkin-example.yml up
```
This example app may be visited at http://localhost:8081. Click a few buttons to generate some sample requests. Then go back to Hypertrace and view the results!

## Deploying with Kubernetes
Please refer to [deployments](https://docs.hypertrace.org/deployments/) section in documentation which lists down steps for deploying Hypertrace on different Kubernetes flavors across different operating systems along with all major cloud providers. You can find the helm charts and installation script with more details [here](/kubernetes).

## Community
[Join the Hypertrace Workspace](https://www.hypertrace.org/get-started) on Slack to connect with other users, contributors and people behind Hypertrace. 

## Documentation
Check out [Hypertrace documentation](https://docs.hypertrace.org) to know more about Hypetrace features, architecture and more cool insights!

## Docker imgaes
Released versions of docker images for various Hypertrace components are availale on [dockerhub](https://hub.docker.com/u/hypertrace).

## Related Repositories

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
[Traceable Community license](LICENSE).
