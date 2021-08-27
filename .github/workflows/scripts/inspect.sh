#!/bin/bash

# This script displays the state and logs for the containers in the docker-compose.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DOCKER_COMPOSE_FILE_DIR="$(dirname $SCRIPT_DIR)/docker"

echo "Executing INSPECT_SCRIPT. ARGUMENT $1  SCRIPT_DIR: $SCRIPT_DIR DOCKER_COMPOSE_FILE_DIR: $DOCKER_COMPOSE_FILE_DIR"

echo ""
if [[ "$1" == "postgres" ]]; then
   containers=$(docker-compose -f ${DOCKER_COMPOSE_FILE_DIR}/docker-compose.yml -f ${DOCKER_COMPOSE_FILE_DIR}/docker-compose.postgres.yml -f ${DOCKER_COMPOSE_FILE_DIR}/docker-compose-zipkin-example.yml ps -q -a)
else
   containers=$(docker-compose -f ${DOCKER_COMPOSE_FILE_DIR}/docker-compose.yml -f ${DOCKER_COMPOSE_FILE_DIR}/docker-compose-zipkin-example.yml ps -q -a)
fi     

while IFS= read -r container; do
    name=$(docker inspect $container | jq -r '.[0].Name')
    echo "=================="
    echo ""
    echo "${name#'/'}"
    echo ""
    docker inspect --format='{{json .State.Health}}' $container | jq .
    echo ""
    docker logs $container
    echo ""
done <<< "$containers"
