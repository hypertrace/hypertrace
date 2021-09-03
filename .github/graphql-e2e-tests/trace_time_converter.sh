#!/bin/bash

path="./src/main/resources/traces/sample"
currentTime=`date +%s` #seconds from epoch
duration=1800 #30 min
updatedStartTime=$(($currentTime-$duration))
startTimeString="          \"startTime\": $updatedStartTime,"
for file in `ls $path`
do
  absolute_path=$path"/"$file
  sed -i "" "s/.*startTime.*/$startTimeString/g" $absolute_path
  break
done
