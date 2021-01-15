#!/bin/bash

docker run -v $(PWD)/resources/traces/trace-1.json:/usr/src/jaeger2zipkin/trace-1.json jbahire/jaeger2zipkin trace-1.json http://host.docker.internal:9411/api/v2/spans
docker run -v $(PWD)/resources/traces/trace-2.json:/usr/src/jaeger2zipkin/trace-2.json jbahire/jaeger2zipkin trace-2.json http://host.docker.internal:9411/api/v2/spans
docker run -v $(PWD)/resources/traces/trace-3.json:/usr/src/jaeger2zipkin/trace-3.json jbahire/jaeger2zipkin trace-3.json http://host.docker.internal:9411/api/v2/spans
docker run -v $(PWD)/resources/traces/trace-4.json:/usr/src/jaeger2zipkin/trace-4.json jbahire/jaeger2zipkin trace-4.json http://host.docker.internal:9411/api/v2/spans