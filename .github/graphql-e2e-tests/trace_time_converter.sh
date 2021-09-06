#!/bin/bash

path="./src/main/resources/traces/"
currentTime=`date +%s` #seconds from epoch
currentTime=$(($currentTime * 1000000)) #convert in microseconds
duration=$((30 * 60 * 1000000)) #30 min into microseconds
updatedStartTime=$(($currentTime-$duration))
startTimeString="          \"startTime\": $updatedStartTime,"
for file in `ls $path`
do
  absolute_path=$path"/"$file
  sed -i "" "s/.*startTime.*/$startTimeString/g" $absolute_path
done
