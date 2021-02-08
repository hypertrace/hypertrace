# This script will install Hypertrace on minikube, run e2e tests and clean your setup once done
git checkout update-helm-charts
minikube start --driver=none
kubectl create ns hypertrace
cd kubernetes
./hypertrace.sh install --clean

kubectl get pods -n hypertrace
kubectl get services -n hypertrace
sleep 40 # you can decrease it but never increase it
kubectl get services -n hypertrace

cd .github/graphql-e2e-tests/
./ingest-traces.sh

export HTUI_IP=$(kubectl get service hypertrace-ui -n hypertrace -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
./gradlew run

cd 
cd .github/ui-e2e-tests/

npm install 
npm audit fix
CHROMEDRIVER_RELEASE="$(google-chrome --product-version)" && npm run install-web-driver -- --versions.chrome=${CHROMEDRIVER_RELEASE}
export HTUI_IP=$(kubectl get service hypertrace-ui -n hypertrace -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
npx protractor protractor.conf.js --suite smoke --baseUrl "http://${HTUI_IP}:2020"

cd 
cd kubernetes

echo "Choose an option to continue"

select yn in "Yes" "No"; do
    case $yn in
        Yes )
            ./hypertrace.sh uninstall
            echo "[INFO] Uninstall successful."
            break;;

        No )
            echo "[INFO] Uninstall cancelled."
            exit;;
    esac
done
;;

minikube stop
minikube delete --all