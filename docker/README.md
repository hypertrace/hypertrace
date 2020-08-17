# Quick start with Hypertrace

## Running Hypertrace with docker-compose

**Note:** *It is recommended to change default memory for docker from `2GiB` to `4GiB` and default CPU's to 3 to get Hypertrace up and running.* 

### Start Hypertrace

If you want to see Hypertrace in action, you can quickly start Hypertrace via Docker.

```
git clone https://github.com/hypertrace/hypertrace.git
cd hypertrace/docker
docker-compose -f docker-compose.yml up
```

This will start all services required for Hypertrace. Once you see the service hypertrace-ui start, you can visit Hypertrace UI at http://localhost:2020 . 

| ![space-1.jpg](https://s3.amazonaws.com/hypertrace-docs/dashboard-1.png) | 
|:--:| 
| *Hypertrace Dashboard* |

### Ports

Here are the default Hypertrace ports:

| Port  | Service                 |
|-------|-------------------------|
| 2020  | Used by Hypertrace UI   |
| 14267 | Jaeger thrift collector |
| 14268 | Jaeger HTTP collector   |
| 9411  | Zipkin collector        |


### Sample application
- The example app has two services: frontend and backend. They both report trace data to Hypertrace. To setup the demo, you need to start Frontend, Backend and Hypertrace. 
- You can start sample by running `docker-compose -f docker-compose-zipkin-example.yml up` if you have hypertrace running already. 
- You can start sample app with Hypertrace using `docker-compose -f docker-compose.yml -f docker-compose-zipkin-example.yml up`.
- Example app will be served at http://localhost:8081 . You can visit app to generate some sample requests!
