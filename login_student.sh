#!/bin/bash

command=`docker container ls -a|grep biodocker`
#echo $command
if [ -z "$command" ]; then
  docker run -v `pwd`/data:/home/student/data --user student --hostname biodocker --name biodocker -ti biodocker bash --login
else
  docker container start biodocker
  docker exec -it biodocker bash
fi
