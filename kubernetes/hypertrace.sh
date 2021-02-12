#!/usr/bin/env bash

set -eEu -o functrace
script=$0

function clean() {
  EXIT_CODE=0
  kubectl get ns ${HT_KUBE_NAMESPACE} ${KUBE_FLAGS} >/dev/null 2>&1 || EXIT_CODE=$?
  if [ ${EXIT_CODE} != 0 ]; then
    echo "[ERROR] Couldn't find namespace to uninstall. namespace: ${HT_KUBE_NAMESPACE}, context: ${HT_KUBE_CONTEXT}"
    exit 1
  fi

  EXIT_CODE=0
  helm get all hypertrace-platform-services ${HELM_FLAGS} >/dev/null 2>&1 || EXIT_CODE=$?
  if [ ${EXIT_CODE} == 0 ]; then
    echo "[INFO] found existing platform services deployment. running helm uninstall. release: 'hypertrace-platform-services'"
    helm uninstall hypertrace-platform-services ${HELM_FLAGS}
  else
    echo "[INFO] Couldn't find helm release 'hypertrace-platform-services'"
  fi

  EXIT_CODE=0
  helm get all hypertrace-data-services ${HELM_FLAGS} >/dev/null 2>&1 || EXIT_CODE=$?
  if [ ${EXIT_CODE} == 0 ]; then
    echo "[INFO] found existing data services deployment. running helm uninstall. release: 'hypertrace-data-services'"
    helm uninstall hypertrace-data-services ${HELM_FLAGS}
  else
    echo "[INFO] Couldn't find helm release 'hypertrace-data-services'"
  fi
  echo "[INFO] We are clean! good to go!"
}

error_report() {
    local retval=$?
    echo "${script}: Error at line#: $1, command: $2, error code: ${retval}"
    exit ${retval}
}

trap 'error_report ${LINENO} ${BASH_COMMAND}' ERR

function usage() {
    echo "usage: $script {install|uninstall|dry-run} [option]"
    echo " "
    echo "available options for install:"
    echo " "
    echo "--clean             removes previous deployments of Hypertrace and do clean install"
    echo "available options for dry-run:"
    echo " "
    echo "servicename          enter name of the service for which you want to generate manifests"
    echo " "
    echo "pre-install-tasks    generates manifests for services with pre-install helm hook"
    echo " "
    echo "post-install-tasks    generates manifests for services with post-install helm hook"

    exit 1
}

function cleanup(){
    echo "[INFO] cleaning up any helm temporary working directory"
    rm -rf ${HYPERTRACE_HOME}/data-services/charts
    rm -rf ${HYPERTRACE_HOME}/data-services/tmpcharts
    rm -rf ${HYPERTRACE_HOME}/data-services/Chart.lock
    rm -rf ${HYPERTRACE_HOME}/platform-services/charts
    rm -rf ${HYPERTRACE_HOME}/platform-services/tmpcharts
    rm -rf ${HYPERTRACE_HOME}/platform-services/Chart.lock
}

function create_helm_install_manifests(){
  if [ $HT_DATA_STORE == "postgres" ]; then
    helm install --dry-run hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services/ -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/platform-services/postgres/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/install-manifests.yaml
  else
    helm install --dry-run hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services/ -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/install-manifests.yaml
  fi
}

HYPERTRACE_HOME="`dirname \"$0\"`"
HYPERTRACE_HOME="`( cd \"${HYPERTRACE_HOME}\" && pwd )`"  # absolutized and normalized

HYPERTRACE_CONFIG=${HYPERTRACE_HOME}/config/hypertrace.properties

if [ ! -f "${HYPERTRACE_CONFIG}" ]; then
    echo "Configuration file not found: '${HYPERTRACE_CONFIG}'"
fi
source ${HYPERTRACE_CONFIG}

LOG_DIR=${HYPERTRACE_HOME}/logs
LOG_FILE=hypertrace.log
mkdir -p ${LOG_DIR}

if [ x${HT_KUBE_CONTEXT} == "x" ]; then
  HT_KUBE_CONTEXT="$(kubectl config current-context)"
fi

HELM_FLAGS="--kube-context=${HT_KUBE_CONTEXT} --namespace=${HT_KUBE_NAMESPACE} --log-dir=${LOG_DIR} --log-file=${LOG_FILE} --log-file-max-size=16 --alsologtostderr=true --logtostderr=false"
KUBE_FLAGS="--context=${HT_KUBE_CONTEXT} --namespace=${HT_KUBE_NAMESPACE} --log-dir=${LOG_DIR} --log-file=${LOG_FILE} --log-file-max-size=16 --alsologtostderr=true --logtostderr=false"


if [[ "$HT_ENABLE_DEBUG" == "true" ]]; then
  HELM_FLAGS="$HELM_FLAGS --debug --v=4"
  KUBE_FLAGS="$KUBE_FLAGS --v=4"
fi

servicename=""

if [ "$#" -gt 1 ]; then
  if [[ $2 == "--clean" ]]; then
      clean
  else
      servicename=$2
    fi
elif [ "$#" -ne 1 ]; then
    echo "[ERROR] Illegal number of parameters"
    echo "-------------------------------------"
    usage
fi

subcommand=$1; shift

case "$subcommand" in
  dry-run)
    EXIT_CODE=0;
    cleanup
    if [[ "$servicename" != "" && $( echo "${servicename}" | egrep -c "^(kafka|zookeeper|pinot|schema-registry|mongo|postgres)$" ) -ne 0 ]]; then
      echo "[INFO] creating helm deployment template for" $servicename
      helm dependency update ${HYPERTRACE_HOME}/data-services ${HELM_FLAGS}
      tar -xvf ${HYPERTRACE_HOME}/data-services/charts/"$servicename"* -C ${HYPERTRACE_HOME}/data-services/charts/
      if [ $HT_DATA_STORE == "postgres" ]; then
        helm template ${HYPERTRACE_HOME}/data-services/charts/$servicename -f ${HYPERTRACE_HOME}/data-services/values.yaml -f ${HYPERTRACE_HOME}/data-services/postgres/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/data-services/helm-deployment-templates/service-manifests/$servicename-manifests.yaml
      else
        helm template hypertrace-data-services ${HYPERTRACE_HOME}/data-services/charts/$servicename -f ${HYPERTRACE_HOME}/data-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/data-services/helm-deployment-templates/service-manifests/$servicename-manifests.yaml
      fi
      cleanup

    elif [[ "$servicename" != "" ]]; then
      helm dependency update ${HYPERTRACE_HOME}/platform-services ${HELM_FLAGS}
        if [[ "$servicename" == "pre-install-tasks" ]]; then
          create_helm_install_manifests
          echo "[INFO] creating helm deployment template for pre-install tasks"
          python pre_post_install_task_generator.py pre ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/install-manifests.yaml ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/pre-install-tasks/pre-install-manifests.yaml
        elif [[ "$servicename" == "post-install-tasks" ]]; then
          create_helm_install_manifests
          echo "[INFO] creating helm deployment template for post-install tasks"
          python pre_post_install_task_generator.py post ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/install-manifests.yaml ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/post-install-tasks/post-install-manifests.yaml
        else
          tar -xvf ${HYPERTRACE_HOME}/platform-services/charts/$servicename* -C ${HYPERTRACE_HOME}/platform-services/charts/ 
          if [ $HT_DATA_STORE == "postgres" ]; then
            helm template hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services/charts/$servicename -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/platform-services/postgres/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/service-manifests/$servicename-manifests.yaml
          else
            helm template hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services/charts/$servicename -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/service-manifests/$servicename-manifests.yaml
          fi
        fi
        cleanup

    elif [[ "$servicename" == "" ]]; then
      echo "[INFO] creating helm deployment template for hypertrace data services."
      helm dependency update ${HYPERTRACE_HOME}/data-services ${HELM_FLAGS}
      if [ $HT_DATA_STORE == "postgres" ]; then
        helm template hypertrace-data-services ${HYPERTRACE_HOME}/data-services -f ${HYPERTRACE_HOME}/data-services/values.yaml -f ${HYPERTRACE_HOME}/data-services/postgres/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/data-services/helm-deployment-templates/manifests.yaml
      else
        helm template hypertrace-data-services ${HYPERTRACE_HOME}/data-services -f ${HYPERTRACE_HOME}/data-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/data-services/helm-deployment-templates/manifests.yaml
      fi
      echo "[INFO] creating helm deployment template for hypertrace platform services."
      helm dependency update ${HYPERTRACE_HOME}/platform-services ${HELM_FLAGS}
      if [ $HT_DATA_STORE == "postgres" ]; then
        helm template hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/platform-services/postgres/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/manifests.yaml
      else
        helm template hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --set htEnv=${HT_ENV} > ${HYPERTRACE_HOME}/platform-services/helm-deployment-templates/manifests.yaml
      fi
      cleanup
    fi
      echo "[INFO] Hypertrace deployment templates created successfully."
    ;;

  install)
    EXIT_CODE=0;

    # namespace - create when it doesn't exists. ignore, otherwise.
    kubectl get ns ${HT_KUBE_NAMESPACE} ${KUBE_FLAGS} >/dev/null 2>&1 || EXIT_CODE=$?
    if [ ${EXIT_CODE} == 0 ]; then
      echo "[WARN] Skipping namespace creation. Namespace already exists. namespace: ${HT_KUBE_NAMESPACE}, context: ${HT_KUBE_CONTEXT}"
    else
      echo "[INFO] Creating namespace. namespace: ${HT_KUBE_NAMESPACE}, context: ${HT_KUBE_CONTEXT}"
      kubectl create ns ${HT_KUBE_NAMESPACE} ${KUBE_FLAGS}
    fi

    cleanup
    echo "[INFO] installing hypertrace data services. namespace: ${HT_KUBE_NAMESPACE}, context: ${HT_KUBE_CONTEXT}"
    helm dependency update ${HYPERTRACE_HOME}/data-services ${HELM_FLAGS}
    if [ $HT_DATA_STORE == "postgres" ]; then
      helm upgrade hypertrace-data-services ${HYPERTRACE_HOME}/data-services -f ${HYPERTRACE_HOME}/data-services/values.yaml -f ${HYPERTRACE_HOME}/data-services/postgres/values.yaml  -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --install --wait ${HELM_FLAGS} --timeout ${HT_INSTALL_TIMEOUT}m --set htEnv=${HT_ENV}
    else
      helm upgrade hypertrace-data-services ${HYPERTRACE_HOME}/data-services -f ${HYPERTRACE_HOME}/data-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --install --wait ${HELM_FLAGS} --timeout ${HT_INSTALL_TIMEOUT}m --set htEnv=${HT_ENV}
    fi
    echo "[INFO] installing hypertrace platform services. namespace: ${HT_KUBE_NAMESPACE}, context: ${HT_KUBE_CONTEXT}"
    helm dependency update ${HYPERTRACE_HOME}/platform-services ${HELM_FLAGS}
    if [ $HT_DATA_STORE == "postgres" ]; then
      helm upgrade hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/platform-services/postgres/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --install ${HELM_FLAGS} --timeout ${HT_INSTALL_TIMEOUT}m --set htEnv=${HT_ENV}
    else
      helm upgrade hypertrace-platform-services ${HYPERTRACE_HOME}/platform-services -f ${HYPERTRACE_HOME}/platform-services/values.yaml -f ${HYPERTRACE_HOME}/clusters/$HT_PROFILE/values.yaml --install ${HELM_FLAGS} --timeout ${HT_INSTALL_TIMEOUT}m --set htEnv=${HT_ENV}
    fi
    echo "[INFO] Hypertrace installation completed"
    ;;

  uninstall)
    echo "[INFO] Uninstalling Hypertrace deletes the hypertrace namespace and deletes any data stored."
    echo "Choose an option to continue"

    select yn in "Yes" "No"; do
        case $yn in
            Yes )
              clean
              cleanup
              kubectl delete ns ${HT_KUBE_NAMESPACE} ${KUBE_FLAGS}
              echo "[INFO] Uninstall successful."
              break;;

            No )
              echo "[INFO] Uninstall cancelled."
              exit;;
        esac
    done
    ;;
  *)
    echo "[ERROR] Unknown command: ${subcommand}"
    usage
    ;;
esac
