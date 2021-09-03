#!/bin/bash

COLLECTOR_IP="$(kubectl get service hypertrace-collector -n hypertrace | tr -s " " | cut -d' ' -f4 | grep -v "EXTERNAL-IP")"

if [[ "$OSTYPE" == "darwin"* && "$COLLECTOR_IP" == "localhost" ]]; then
    COLLECTOR_IP="docker.for.mac.localhost"
fi
#./trace_time_converter.sh
docker run -v $(pwd)/src/main/resources/traces/trace-1.json:/usr/src/jaeger2zipkin/trace-1.json jbahire/jaeger2zipkin trace-1.json http://$COLLECTOR_IP:9411/api/v2/spans
docker run -v $(pwd)/src/main/resources/traces/trace-2.json:/usr/src/jaeger2zipkin/trace-2.json jbahire/jaeger2zipkin trace-2.json http://$COLLECTOR_IP:9411/api/v2/spans
docker run -v $(pwd)/src/main/resources/traces/trace-3.json:/usr/src/jaeger2zipkin/trace-3.json jbahire/jaeger2zipkin trace-3.json http://$COLLECTOR_IP:9411/api/v2/spans
docker run -v $(pwd)/src/main/resources/traces/trace-4.json:/usr/src/jaeger2zipkin/trace-4.json jbahire/jaeger2zipkin trace-4.json http://$COLLECTOR_IP:9411/api/v2/spans
