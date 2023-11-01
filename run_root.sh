#!/bin/bash

command=`docker container ls -a|grep biodocker`

if [ -z "$command" ]; then
  docker run -v `pwd`/data:/home/student/data --user root --hostname biodocker --name biodocker -ti biodocker bash --login
else
  docker container start biodocker
  docker exec -it --user root biodocker bash
fi
