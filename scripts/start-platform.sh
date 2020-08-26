#!/bin/sh
PLATFORM_CMD="java -cp /app/resources:/app/classes:/app/libs/* org.hypertrace.core.serviceframework.PlatformServiceLauncher"
exec $PLATFORM_CMD