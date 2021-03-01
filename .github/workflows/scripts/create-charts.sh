#!/bin/bash
# This script prepares the charts.yaml files for data-services and platform-services of hypertrace based on the latest version of those services.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
HELM_GCS_REPO='"https://storage.googleapis.com/hypertrace-helm-charts"'

print_header() {
    cat ".github/workflows/scripts/header.txt"
    echo
}

get_prior_service_version() {
  prior_version="$(cat "kubernetes/tmp/compatibility_matrix.txt" | grep "^$1:" | cut -d":" -f2-)"
  echo ${prior_version}
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
        echo '    condition: mongodb.enabled'
        echo '  - name: postgresql'
        echo '    repository:' '"https://charts.bitnami.com/bitnami"'
        echo '    version:' 10.2.6
        echo '    condition: postgresql.enabled'
        
} 

update_platform_services_charts() {
        print_header
        echo ""
        echo 'dependencies:'
        echo '  - name: hypertrace-collector'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_collector_version 
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
        echo '  - name: gateway-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $gateway_service_version
        echo '    condition: merge-query-services.disabled'
        echo '  - name: query-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $query_service_version
        echo '    condition: merge-query-services.disabled'
        echo '  - name: entity-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $entity_service_version
        echo '    condition: merge-query-services.disabled'
        echo '  - name: attribute-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $attribute_service_version
        echo '    condition: merge-query-services.disabled'
        echo '  - name: config-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $config_service_version
        echo '    condition: merge-query-services.disabled'
        echo '  - name: hypertrace-data-config-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_service_version
        echo '    condition: merge-query-services.enabled'
        echo '  - name: hypertrace-data-query-service'
        echo '    repository:' $HELM_GCS_REPO
        echo '    version:' $hypertrace_service_version
        echo '    condition: merge-query-services.enabled' 
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
    echo '#### `Hypertrace deployment` '
    changelog -m hypertrace hypertrace $hypertrace_version
    
    attribute_service_old_version=$(get_prior_service_version "attribute-service")
    echo '#### `Attribute service` ' '[('$attribute_service_old_version '..' $attribute_service_version')](https://github.com/hypertrace/attribute-service/releases)'
    changelog -m hypertrace attribute-service $attribute_service_old_version $attribute_service_version

    gateway_service_old_version=$(get_prior_service_version "gateway-service")
    echo '#### `Gateway service` ' '[('$gateway_service_old_version '..' $gateway_service_version')](https://github.com/hypertrace/gateway-service/releases)'
    changelog -m hypertrace gateway-service $gateway_service_old_version $gateway_service_version

    query_service_old_version=$(get_prior_service_version "query-service")
    echo '#### `Query service` ' '[('$query_service_old_version '..' $query_service_version')](https://github.com/hypertrace/query-service/releases)'
    changelog -m hypertrace query-service $query_service_old_version $query_service_version

    entity_service_old_version=$(get_prior_service_version "entity-service")
    echo '#### `Entity service` ' '[('$entity_service_old_version '..' $entity_service_version')](https://github.com/hypertrace/entity-service/releases)'
    changelog -m hypertrace entity-service $entity_service_old_version $entity_service_version

    config_service_old_version=$(get_prior_service_version "config-service")
    echo '#### `Config service` ' '[('$config_service_old_version '..' $config_service_version')](https://github.com/hypertrace/config-service/releases)'
    changelog -m hypertrace config-service $config_service_old_version $config_service_version

    hypertrace_graphql_old_version=$(get_prior_service_version "hypertrace-graphql")
    echo '#### `Hypertrace GraphQL` ' '[(' $hypertrace_graphql_old_version '..' $hypertrace_graphql_version')](https://github.com/hypertrace/hypertrace-graphql/releases)' 
    changelog -m hypertrace hypertrace-graphql $hypertrace_graphql_old_version $hypertrace_graphql_version

    hypertrace_ui_old_version=$(get_prior_service_version "hypertrace-ui")
    echo '#### `Hypertrace UI` ' '[(' $hypertrace_ui_old_version '..' $hypertrace_ui_version')](https://github.com/hypertrace/hypertrace-ui/releases)' 
    changelog -m hypertrace hypertrace-ui $hypertrace_ui_old_version $hypertrace_ui_version

    hypertrace_ingester_old_version=$(get_prior_service_version "hypertrace-ingester")
    echo '#### `Hypertrace ingester` ' '[(' $hypertrace_ingester_old_version '..' $hypertrace_ingester_version')](https://github.com/hypertrace/hypertrace-ingester/releases)' 
    changelog -m hypertrace hypertrace-ingester $hypertrace_ingester_old_version $hypertrace_ingester_version
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
    release_notes_file="RELEASE_NOTES.md"
    write_changelog > "${release_notes_file}"
fi

# This compatiblity matrix file will be written at the end of each run so it will have current versions of all services. 
# Whenever the workflow to update helm charts will run it will compare current i.e. latest version of service with one from this file and create changelog with write_changelog function. 

if [ $1 == "compatibility-matrix" ]; then
    compatibilty_matrix_file="kubernetes/tmp/compatibility_matrix.txt"
    write_to_tmp_source > "${compatibilty_matrix_file}"
fi