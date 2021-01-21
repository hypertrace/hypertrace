#!/bin/bash
# This script prepares the charts.yaml files for data-services and platform-services of hypertrace based on the latest version of those services.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
HELM_GCS_REPO='"https://storage.googleapis.com/hypertrace-helm-charts"'

print_header() {
    cat ".github/workflows/header.txt"
    echo
}

update_data_services_charts() {
        print_header
        echo ""
        echo 'dependencies:'
        echo '  - name: kafka'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $kafka_version 
        echo '  - name: zookeeper'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $zookeeper_version
        echo '  - name: pinot'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $pinot_version 
        echo '  - name: schema-registry'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $schema_registry_version
        echo '  - name: mongodb'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $mongodb_version
} 

update_platform_services_charts() {
        print_header
        echo ""
        echo 'dependencies:'
        echo '  - name: hypertrace-oc-collector'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_oc_collector_version 
        echo '  - name: span-normalizer'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_ingester_version
        echo '  - name: raw-spans-grouper'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_ingester_version
        echo '  - name: hypertrace-trace-enricher'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_ingester_version
        echo '  - name: hypertrace-view-generator'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_ingester_version
        echo '  - name: hypertrace-ui'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_ui_version 
        echo '  - name: hypertrace-graphql-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_graphql_version
        echo '  - name: attribute-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $attribute_service_version
        echo '  - name: gateway-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $gateway_service_version
        echo '  - name: query-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $query_service_version
        echo '  - name: entity-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $entity_service_version
        echo '  - name: config-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $config_service_version
        echo '  - name: kafka-topic-creator'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' 0.1.7
        echo '    condition: kafka-topic-creator.enabled'
} 


if [ $1 == "data-services" ]; then
    OUT_DIR="kubernetes/data-services"
    charts_file="${OUT_DIR}/Chart.yaml"
    update_data_services_charts > "${charts_file}"

elif [ $1 == "platform-services" ]; then
    OUT_DIR="kubernetes/platform-services"
    charts_file="${OUT_DIR}/Chart.yaml"
    update_platform_services_charts > "${charts_file}"
fi
