#!/bin/bash

winpty docker run --rm -v /$(pwd)/data:/home/student/data --user student --hostname biodocker --name biodocker -ti masaomi/biodocker bash --login
