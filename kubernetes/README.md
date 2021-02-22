# [Deploying Hypertrace with Kubernetes](https://docs.hypertrace.org/getting-started/)
Hypertrace installation script uses Helm Charts to deploy Hypertrace on Kubernetes. If you are already using a tracing system, you can start today. Hypertrace accepts all major data formats: Jaeger, OpenTracing, Zipkin, you name it. Once you complete Installation you can see traces from your already instrumented application in Hypertrace. 

## Using helm
### Requirements
- `Docker Desktop` or `Kubernetes` (version 1.5 and above).
- Minimum resources: (3 CPUs, 4GB Memory).
- `Helm` (version 3.2.x and above)
- Bash
- Python (3.x and above)


### How it works
Deploys Hypertrace platform in `docker-desktop` or any Kubernetes context, under the namespace `hypertrace`.

### Ports

Here are the default Hypertrace ports: 

| Port  | Service                 |
|-------|-------------------------|
| 2020  | Used by Hypertrace UI   |
| 14267 | Jaeger thrift collector |
| 14268 | Jaeger HTTP collector   |
| 9411  | Zipkin collector        |

In case of any port collisions, users can modify the following properties in helm file (`platform-services/values.yaml`).
- `ingress.hosts[].paths[].port` -  To change UI port 
- `hypertrace-oc-collector.service.ports[].targetPort` - To change collector ports

### Install
- `git clone https://github.com/hypertrace/hypertrace.git`
- `cd hypertrace/kubernetes`
- Update the config properties under `./config/hypertrace.properties` as needed. The default config will work for a `dev` deployment on Docker for Desktop.
- Run `./hypertrace.sh install`

In case of any issue, install hypertrace in debug mode to get more logs and traces to identify the rootcause.
- Set `HT_ENABLE_DEBUG` to `true` in `./config/hypertrace.properties`
- Debug `bash -x ./hypertrace.sh install`

### Deployments
Please follow docs below to get instructions specific to deployment environment.
- [Docker Desktop](https://docs.hypertrace.org/deployments/docker/)
- [Minikube](https://docs.hypertrace.org/deployments/minikube/)
- [Microk8s](https://docs.hypertrace.org/deployments/microk8s/)
- [AWS](https://docs.hypertrace.org/deployments/aws/)
- [GCP](https://docs.hypertrace.org/deployments/gcp/)
- [Azure](https://docs.hypertrace.org/deployments/Azure/)

### Configuration

| Key                  | Description                                                                                                   | Allowed values       |
|----------------------|---------------------------------------------------------------------------------------------------------------|----------------------|
| `HT_PROFILE`         | Profile is size of your deployment. (Memory, No. of CPU's, etc.).                                             | dev, mini, standard |
| `HT_ENV`             | Platform you are deploying Hypertrace on.                                                                     | aws, gcp, docker-desktop, minikube, microk8s      |
| `HT_KUBE_CONTEXT`    | Kubernetes context to deploy Hypertrace.                                                                      | specific to platform |
| `HT_DATA_STORE`      | Data store to be used with Hypertrace deployment.                                                             | mongo, postgres      |
| `HT_KUBE_NAMESPACE`  | Kubernetes namespace to deploy Hypertrace.                                                                    | hypertrace           |
| `HT_ENABLE_DEBUG`    | In case of any issue, install Hypertrace in debug mode to get more logs and traces to identify the rootcause. | true, false          |
| `HT_INSTALL_TIMEOUT` | Helm install wait timeout.                                                                                    | in minutes           |


### Uninstall
- Run `./hypertrace.sh uninstall`

## Using Kuberntetes manifests
If you are not using helm in your production environment and want to install with kubernetes manifests, we got you covered. 

You can generate manifests using following following commands:

### Create deployment manifests
- Run `./hypertrace.sh generate-manifests`

| command                                    | description                                                                                                                                                                                     |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ./hypertrace.sh generate-manifests                    | Will create helm template manifests for all services and will store them in `helm-deployment-templates` directory for both `data-services` and `platform-services`                        |
| ./hypertrace.sh generate-manifests --service service-name       | Wll create helm template manifests for particular service and will store them in `helm-deployment-templates/service-manifests` directory for both `data-services` and `platform-services` |
| ./hypertrace.sh generate-manifests --deps pre-install-tasks  | Wll create helm template manifests for services with pre-install helm hook and will store them in `helm-deployment-templates/pre-install-tasks` directory for `platform-services`             |
| ./hypertrace.sh generate-manifests --deps post-install-tasks | Wll create helm template manifests for services with post-install helm hook and will store them in `helm-deployment-templates/post-install-tasks` directory for `platform-services`           |

### Install
- `git clone https://github.com/hypertrace/hypertrace.git`
- `cd hypertrace/kubernetes`
- Update the config properties under `./config/hypertrace.properties` as needed. The default config will work for a `dev` deployment on Docker for Desktop.
- Run `./hypertrace.sh generate-manifests` which will generate manifests for both data-services and platform services
- Create Hypertrace namespace using `kubectl create namespace hypertrace`
- Install data services using `kubectl apply -f data-services/helm-deployment-templates/ -n hypertrace --validate=false`
- Once all data-service pods are up go to next step. 
- Now install platform-service manifests using `kubectl apply -f platform-services/helm-deployment-templates/ -n hypertrace --validate=false` 

You can check if all pods are up and running using `kubectl get pods -n hypertrace`

## Troubleshooting
If you are facing some issue with installation, you can look [here](https://docs.hypertrace.org/troubleshooting/installation/) for troubleshooting tips. 

## Verifying Hypertrace UI

Once your Hypertrace installation is successful you can navigate to`http://localhost:2020` or IP address for hypertrace-ui service to access the Hypertarce UI. It looks something like this!

| ![space-1.jpg](https://s3.amazonaws.com/hypertrace-docs/dashboard-1.png) | 
|:--:| 
| *Hypertrace Dashboard* |

## Sending data to Hypertrace
Now you know things are running, let's get some data into Hypertrace. If your applications already send trace data, you can configure them to send data to Hypertrace using the default ports for Jaeger, OpenCensus or Zipkin. If you are just getting started, try out our [demo app](https://docs.hypertrace.org/sample-app). Once you have data in Hypertrace, you are ready to [explore its advanced features](https://docs.hypertrace.org/platform-ui). 

## Cutting release for helm chart updates locally
- Genereate PR by running workflow here: https://github.com/hypertrace/hypertrace/actions?query=workflow%3A%22get+latest+helm+charts%22
- Click on `Run workflow`
- git checkout `update-helm-charts`
- Run e2e tests using
    - `cd kubernetes`
    - `./hypertrace-e2e-test.sh`
- This will install Hypertrace, run e2 tests and then uninstall hypertrace. 
- In case if you run the above script with minikube, update `./config/hypertrace.properties` file 
  HE_ENV and HT_KUBE_CONTEXT with `minikube`

`Note:` We have workflow (`./github/workflows/hypertrace-release.yml`) which runs on self hosted-runner 
that will be enabled in future.
