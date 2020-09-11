[![hypertrace](https://circleci.com/gh/hypertrace/hypertrace/tree/main.svg?style=svg)](https://circleci.com/gh/hypertrace/hypertrace)

# Hypertrace

Hypertrace is a cloud-native distributed tracing based Observability platform
that gives visibility into your dev and production distributed systems.

Hypertrace was originally developed by Traceable as a highly scalable
distributed tracing platform and it is used by Traceable’s cloud-native
application security platform. ‍Realizing that Hypertrace was a powerful
standalone tracing and observability platform, Traceable created this open source
project for the software development community to use in their applications.

---

## Quick-start

If you want to see Hypertrace in action, you can quickly start Hypertrace via Docker.

```bash
git clone https://github.com/hypertrace/hypertrace.git
cd hypertrace/docker
docker-compose -f docker-compose.yml pull
docker-compose -f docker-compose.yml up --force-recreate
```

This will start all services required for Hypertrace. Once you see the service `Hypertrace-UI` start, you can visit the UI at http://localhost:2020.

If you have application instrumented to send traces to Zipkin or Jaeger, you are already covered with Hypertrace.

Even if not you can try Hypertrace with sample application by running

```bash
docker-compose -f docker-compose-zipkin-example.yml up
```

Example app will be served at http://localhost:8081. You can visit URL and refresh it few times to generate some sample requests!

## Deploying with Kubernetes

Please refer to [deployments](https://docs.hypertrace.org/deployments/) section in documentation which lists down steps for deploying Hypertrace on different Kubernetes flavors across different operating systems along with all major cloud providers. You can find the helm charts and installation script with more details [here](/kubernetes).

## Community

[Join the Hypertrace Workspace](https://www.hypertrace.org/get-started) on Slack to connect with other users, contributors and people behind Hypertrace.

## Documentation

Check out [Hypertrace documentation](https://docs.hypertrace.org) to know more about Hypetrace features, architecture and more cool insights!

## Docker images

Released versions of docker images for various Hypertrace components are available on [dockerhub](https://hub.docker.com/u/hypertrace).

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

## Contributing
see [CONTRIBUTING](/CONTRIBUTING.md).

## License

Hypertrace follows open core model where "Hypertrace core" (or simply Core) is
under Apache 2.0 license, which has distributed trace ingestion and exploration
features. Services, Endpoints, Backends and Service Graph features are under
[Traceable Community license](LICENSE).
