#!/bin/bash

# This script runs a quick E2E test against a running set of services described in ../docker-compose.yml
# and ../docker-compose-zipkin-example.yml.
# 
# Usage:
#
# docker-compose -f docker/docker-compose.yml -f docker/docker-compose-zipkin-example.yml up -d
# sh ./circleci/tests.sh

TRACES_SERVER_HOST=${1:-127.0.0.1}
FRONTEND_SERVICE_HOST=${2:-127.0.0.1}

echo ""
echo "Making sure the traces service is up..."
echo ""

# curl --retry-connrefused is only available since 7.52.0.
NUMBER_OF_RETRIES=5
RETRY_COUNT=0
while : ; do
  if [[ "$RETRY_COUNT" == "$NUMBER_OF_RETRIES" ]]; then
    echo "Failed to connect to $TRACES_SERVER_HOST:2020 after $NUMBER_OF_RETRIES retries."
    exit 1
  fi

  (curl -s -o /dev/null "http://$TRACES_SERVER_HOST:2020") && break
  RETRY_COUNT=$((RETRY_COUNT+1)) 
  sleep 3
done

echo ""
echo "Calling the frontend to generate a trace..."
echo ""
curl -o /dev/null -s http://${FRONTEND_SERVICE_HOST}:8081  || { echo "Host $FRONTEND_SERVICE_HOST is down." ; exit 1; }

echo "Retrieving the list of traces:"
echo ""

TRACES=$(curl http://${TRACES_SERVER_HOST}:2020/graphql -H 'Content-Type: application/json' --data-binary \
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
}"}')

ERROR=$(echo $TRACES | jq -r .errors[0].message)
if [[ "$ERROR" != "null" ]]; then
  echo ""
  echo "Error while retrieving traces: $ERROR";
  exit 1;
fi

TRACE_ID=$(echo $TRACES | jq -r .data.traces.results[0].id)
echo ""
echo "Found trace $TRACE_ID."
exit 0;