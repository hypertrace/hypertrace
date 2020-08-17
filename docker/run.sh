COUNT=0
URL=$1

[[ -z ${URL} ]] && URL=http://localhost:8081

while true
do
    COUNT=$((COUNT+1))
    curl ${URL}
    echo " ${COUNT}"
    sleep 1
done