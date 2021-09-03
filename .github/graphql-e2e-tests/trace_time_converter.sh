#!/bin/bash

path="./src/main/resources/traces/"
#starttime="          \"startTime\": 1," #currnt time - 30 min
for file in `ls $path`
do
  absolute_path=$path"/"$file
  sed -i "" "s/.*startTime.*/$starttime/g" $absolute_path
  break
done
