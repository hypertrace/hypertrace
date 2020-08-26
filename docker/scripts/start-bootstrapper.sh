#!/bin/sh
BOOTSTRAP_CMD="java -cp /app/resources:/app/classes:/app/libs/* org.hypertrace.core.bootstrapper.ConfigBootstrapper -c /app/resources/configs/config-bootstrapper/application.conf -C /app/resources/configs/config-bootstrapper/ --upgrade"
exec $BOOTSTRAP_CMD
