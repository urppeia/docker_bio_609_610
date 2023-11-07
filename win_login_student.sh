#!/bin/bash

command=`docker container ls -a|grep biodocker`

if [ -z "$command" ]; then
  winpty docker run -v `pwd`/data:/home/student/data --user student --hostname biodocker --name biodocker -ti dktanwar/bio_609_610 bash --login
else
  winpty docker container start biodocker
  winpty docker exec -it --user student biodocker bash
fi
