#!/bin/bash

HOST=${1:-127.0.0.1}

curl --retry-connrefused --retry-max-time 60 "http://${HOST}:2020/" > /dev/null

curl -i http://${HOST}:8081

curl http://${HOST}:2020/graphql -i -H 'Content-Type: application/json' --data-binary \
'{"query":"{
  traces(
    type: API_TRACE
    between: {
      startTime: \"2020-01-01T00:00:00.000Z\"
      endTime: \"2025-01-01T00:00:00.000Z\"
    }
  ) {
    results {
      id
    }
  }
}"}'