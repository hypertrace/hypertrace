#!/bin/bash
# This script helps in testing hypertrace setup e2e. It is currently mainly used for
# release verification. if HT_ENV is set to minikub, it runs with https://minikube.sigs.k8s.io/docs/start/
set -eEu -o functrace
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HYPERTRACE_CONFIG=${SCRIPT_DIR}/config/hypertrace.properties
if [ ! -f "${HYPERTRACE_CONFIG}" ]; then
    echo "Configuration file not found: '${HYPERTRACE_CONFIG}'"
fi
source ${HYPERTRACE_CONFIG}

if [ ${HT_ENV} == "minikube" ]; then
  minikube start --driver=none
fi

./hypertrace.sh install

kubectl get pods -n hypertrace
kubectl get services -n hypertrace
sleep 40 # you can decrease it but never increase it
kubectl get services -n hypertrace

cd $SCRIPT_DIR/../.github/graphql-e2e-tests/
./ingest-traces.sh
sleep 40

if [[ "$OSTYPE" == "darwin"* ]]; then
  export HTUI_IP=$(kubectl get service hypertrace-ui -n hypertrace | tr -s " " | cut -d' ' -f4 | grep -v "EXTERNAL-IP")
else
  export HTUI_IP=$(kubectl get service hypertrace-ui -n hypertrace -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
fi

./gradlew run

cd $SCRIPT_DIR/../.github/ui-e2e-tests/

npm install 
npm audit fix
if [[ "$OSTYPE" == "darwin"* ]]; then
  CHROMEDRIVER_RELEASE="$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)" && npm run install-web-driver -- --versions.chrome=${CHROMEDRIVER_RELEASE}
else
  CHROMEDRIVER_RELEASE="$(google-chrome --product-version)" && npm run install-web-driver -- --versions.chrome=${CHROMEDRIVER_RELEASE}
fi
npx protractor protractor.conf.js --suite smoke --baseUrl "http://${HTUI_IP}:2020"

cd $SCRIPT_DIR
./hypertrace.sh uninstall

if [ ${HT_ENV} == "minikube" ]; then
  minikube stop
  minikube delete --all
fi