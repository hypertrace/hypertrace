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

write_to_tmp_source() {
        echo 'attribute-service:'$attribute_service_version
        echo 'gateway-service:'$gateway_service_version
        echo 'query-service:'$query_service_version
        echo 'entity-service:'$entity_service_version
        echo 'config-service:'$config_service_version
        echo 'hypertrace-graphql:'$hypertrace_graphql_version
        echo 'hypertrace-ui:'$hypertrace_ui_version
        echo 'hypertrace-ingester:'$hypertrace_ingester_version
}

write_changelog() {
    echo '### Attribute service'
    changelog -m hypertrace attribute-service $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^attribute-service:" | cut -d":" -f2-)
    echo '### Gateway service' 
    changelog -m hypertrace gateway-service $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^gateway-service:" | cut -d":" -f2-)
    echo '### Query service' 
    changelog -m hypertrace query-service $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^query-service:" | cut -d":" -f2-)
    echo '### Entity service' 
    changelog -m hypertrace entity-service $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^entity-service:" | cut -d":" -f2-)
    echo '### Config service' 
    changelog -m hypertrace config-service $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^config-service:" | cut -d":" -f2-)
    echo '### Hypertrace GraphQL service' 
    changelog -m hypertrace hypertrace-graphql $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^hypertrace-graphql:" | cut -d":" -f2-)
    echo '### Hypertrace UI' 
    changelog -m hypertrace hypertrace-ui $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^hypertrace-ui:" | cut -d":" -f2-)
    echo '### Hypertrace Ingester' 
    changelog -m hypertrace hypertrace-ingester $(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^hypertrace-ingester:" | cut -d":" -f2-)
}

if [ $1 == "data-services" ]; then
    OUT_DIR="kubernetes/data-services"
    charts_file="${OUT_DIR}/Chart.yaml"
    update_data_services_charts > "${charts_file}"
fi

if [ $1 == "platform-services" ]; then
    OUT_DIR="kubernetes/platform-services"
    charts_file="${OUT_DIR}/Chart.yaml"
    update_platform_services_charts > "${charts_file}"
fi

if [ $1 == "release-notes" ]; then
    release_notes_file="release_notes.md"
    write_changelog > "${release_notes_file}"
fi

if [ $1 == "compatibility-matrix" ]; then
    compatibilty_matrix_file="kubernetes/tmp/compatibility_matrix.txt"
    write_to_tmp_source > "${compatibilty_matrix_file}"
fi