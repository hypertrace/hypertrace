[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![E2E-test][github-actions-shield]][github-actions-url]
[![Twitter][twitter-shield]][twitter-url]

<br />
<p align="center">
  <a href="https://github.com/hypertrace/hypertrace">
    <img src="https://avatars.githubusercontent.com/u/65374698?s=200&v=4" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Hypertrace</h3>
  <p align="center">
    An open distributed tracing & observability platform! 
    <br />
    <a href="https://docs.hypertrace.org"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://blog.hypertrace.org">Visit our blog</a>
    ·
    <a href="https://github.com/hypertrace/hypertrace/issues">Report Bug</a>
    ·
    <a href="https://github.com/hypertrace/hypertrace/issues">Request Feature</a>
  </p>
</p>


> CVE-2021-44228 and CVE-2021-45046 disclosed security vulnerabilities in the Apache Log4j 2 version 
> 2.15 or below.
> 
> We have upgraded all the dependent hypertrace repositories and have cut the new release with 
> a safe version of Log4j (2.17). We strongly encourage upgrading to the latest version 
> [(v0.2.7)](https://github.com/hypertrace/hypertrace/releases/tag/0.2.7) of hypertrace or using appropriate charts from the latest release.

# About The Project

Hypertrace is a cloud-native distributed tracing based Observability platform that gives visibility into your dev and production distributed systems.

Hypertrace converts distributed trace data into relevant insight for everyone. Infrastructure teams can identify which services are causing overload. Service teams can diagnose why a specific user's request failed, or which applications put their service objectives at risk. Deployment teams can know if a new version is causing a problem.

With Hypertrace you can, 
- Perform Root cause analysis(RCA) whenever something breaks in your system.
- Watch roll-outs and compare key metrics.
- Determine performance bottlenecks and identify slow operations like slow API calls or DB queries. 
- Monitor microservice dependencies and Observe your applications. 

| [![Product Name Screen Shot][product-screenshot]](https://hypertrace.org) | 
|:--:| 
| *Hypertrace* |


# Getting Started
## Quick-start with docker-compose

If you want to see Hypertrace in action, you can quickly start Hypertrace.

### Prerequisites
- [docker-engine](https://docs.docker.com/engine/install/) (17.12.0+)
- [docker-compose](https://docs.docker.com/compose/install/) (1.21.0 +)
- **We recommend you change the [Docker Desktop default settings](https://hypertrace-docs.s3.amazonaws.com/docker-desktop.png) from `2 GB` of memory to `4 GB` of memory, and set CPUs to at least 4 CPUs.** 

### Run with docker-compose
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
- [Join the Hypertrace Workspace](https://join.slack.com/t/hypertrace/shared_invite/zt-oln0psj9-lm1CSkXE1vsWdcw6YKWGDg) on Slack to connect with other users, contributors and people behind Hypertrace.
- We have **public** [monthly meeting](https://traceable-ai.zoom.us/j/85283423421?pwd=Nk11SUdZZGc1TC80NWgxRlF4Y05GUT09) on **last Thursday of the month** at 8:00 AM PST/ 8:30 PM IST/ 11:00 AM ET/ 5:00 PM CET where we try to give our community a holistic overview of new features in Hypertrace and community activities. We would like to hear feedback, discuss feature requests and also help new contributors to get started with contributing to projects. You can join the zoom meeting [here](https://traceable-ai.zoom.us/j/85283423421?pwd=Nk11SUdZZGc1TC80NWgxRlF4Y05GUT09) or use zoom meeting details as below:
    - Meeting ID: 990 5679 8944
    - Passcode: 111111
- If you want to discuss any ideas or have any questions or show us how you are using Hypertrace, you can use [GitHub discsussions](https://github.com/hypertrace/hypertrace/discussions) as well. 

## Docker images

Released versions of Docker images for various Hypertrace components are available on [dockerhub](https://hub.docker.com/u/hypertrace).

## Roadmap

See the [open issues](https://github.com/hypertrace/hypertrace/issues) for a list of proposed features (and known issues).

## Contributing

Contributions are what make the open community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. Check out our [Contribution Guidelines](https://github.com/hypertrace/hypertrace/blob/main/.github/CONTRIBUTING.md) for more details. 

## License

Hypertrace follows the open core model where "Hypertrace core" (or simply Core) is made available under the Apache 2.0 license, which has distributed trace ingestion and exploration features. The Services, Endpoints, Backends and Service Graph features of Hypertrace Community Edition are made available under the
[Traceable Community license](LICENSE).


[contributors-shield]: https://img.shields.io/github/contributors/hypertrace/hypertrace.svg?style=for-the-badge
[contributors-url]: https://github.com/hypertrace/hypertrace/graphs/contributors
[github-actions-shield]: https://img.shields.io/github/workflow/status/hypertrace/hypertrace/e2e%20test?color=orange&label=e2e-test&logo=github&logoColor=orange&style=for-the-badge
[github-actions-url]: https://github.com/hypertrace/hypertrace/actions/workflows/docker-tests.yml
[forks-shield]: https://img.shields.io/github/forks/hypertrace/hypertrace.svg?style=for-the-badge
[forks-url]: https://github.com/hypertrace/hypertrace/network/members
[stars-shield]: https://img.shields.io/github/stars/hypertrace/hypertrace.svg?style=for-the-badge
[stars-url]: https://github.com/hypertrace/hypertrace/stargazers
[issues-shield]: https://img.shields.io/github/issues/hypertrace/hypertrace.svg?style=for-the-badge
[issues-url]: https://github.com/hypertrace/hypertrace/issues
[twitter-shield]: https://img.shields.io/badge/-Twitter-black.svg?style=for-the-badge&logo=twitter&colorB=555
[twitter-url]: https://twitter.com/hypertraceorg
