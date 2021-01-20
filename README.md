[![hypertrace](https://circleci.com/gh/hypertrace/hypertrace/tree/main.svg?style=svg)](https://circleci.com/gh/hypertrace/hypertrace)
![e2e test](https://github.com/hypertrace/hypertrace/workflows/e2e%20test/badge.svg)

# Hypertrace

Hypertrace is a cloud-native distributed tracing based Observability platform
that gives visibility into your dev and production distributed systems.

Hypertrace was originally developed by Traceable as a highly scalable
distributed tracing platform and it is used by Traceable’s cloud-native
application security platform. Realizing that Hypertrace was a powerful
standalone tracing and observability platform, Traceable created this open source
project for the software development community to use in their applications.

---

## Quick-start

If you want to see Hypertrace in action, you can quickly start Hypertrace.

### Requirements:
- [docker-engine](https://docs.docker.com/engine/install/) (17.12.0+)
- [docker-compose](https://docs.docker.com/compose/install/) (1.21.0 +)
- **We recommend you change the [Docker Desktop default settings](https://hypertrace-docs.s3.amazonaws.com/docker-desktop.png) from `2 GB` of memory to `4 GB` of memory, and set CPUs to at least 4 CPUs.** 
`Note`: When reporting problems, please include the output of `docker stats --no-stream`.


```bash
git clone https://github.com/hypertrace/hypertrace.git
cd hypertrace/docker
docker-compose pull
docker-compose up --force-recreate
```

This will start all services required for Hypertrace. Once you see the service `Hypertrace-UI` start, you can visit the UI at http://localhost:2020.

If your application is already instrumented to send traces to Zipkin or Jaeger, it will work with Hypertrace.

If not, you can try Hypertrace with our sample application by running

```bash
docker-compose -f docker-compose-zipkin-example.yml up
```

the sample app will run at http://localhost:8081. You should request the URL a few times to generate some sample trace requests!

## Deploy in production with Kubernetes

We support helm charts to simplify deploying Hypertrace in Kubernetes environment, maybe on your on-premise server or cloud instance! 

Please refer to the [deployments section](https://docs.hypertrace.org/deployments/) in our documentation which lists the steps to deploy Hypertrace on different Kubernetes flavors across different operating systems and cloud providers. You can find the Helm Charts and installation scripts with more details [here](https://github.com/hypertrace/hypertrace/tree/main/kubernetes).

`Note:` We have created `hypertrace-ingester` and `hypertrace-service` to simplify local deployment and quick-start with Hypertrace. As of now, we don't support them for production because of some limitations and some unreliabiliy with scaling. So, we will encourage you to deploy individual components for staging as well as production deployments. 

## Community

[Join the Hypertrace Workspace](https://www.hypertrace.org/get-started) on Slack to connect with other users, contributors and people behind Hypertrace.

## Documentation

Check out [Hypertrace documentation](https://docs.hypertrace.org) to learn more about Hypetrace features, it's architecture and other insights!

## Docker images

Released versions of Docker images for various Hypertrace components are available on [dockerhub](https://hub.docker.com/u/hypertrace).

## Related Repositories

### Data Ingestion Pipeline

* [Hypertrace Ingester](https://github.com/hypertrace/hypertrace-ingester)

### Query Layer Services

* [GraphQL](https://github.com/hypertrace/hypertrace-graphql)
* [Gateway Service](https://github.com/hypertrace/gateway-service)
* [Query Service](https://github.com/hypertrace/query-service)
* [Entity Service](https://github.com/hypertrace/entity-service)
* [Attribute Service](https://github.com/hypertrace/attribute-service)
* [Config Service](https://github.com/hypertrace/config-service)

### UI

* [Hypertrace UI](https://github.com/hypertrace/hypertrace-ui)
* [Hyperdash](https://github.com/hypertrace/hyperdash)
* [Hyperdash Angular](https://github.com/hypertrace/hyperdash-angular)

### Data Service Deployment

* [Kafka helm charts](https://github.com/hypertrace/kafka)
* [Pinot helm charts](https://github.com/hypertrace/pinot)
* [MongoDB helm charts](https://github.com/hypertrace/mongodb)

## License

Hypertrace follows the open core model where "Hypertrace core" (or simply Core) is made available under the Apache 2.0 license, which has distributed trace ingestion and exploration features. The Services, Endpoints, Backends and Service Graph features of Hypertrace Community Edition are made available under the
[Traceable Community license](LICENSE).
