#!/bin/bash

winpty docker run --rm -it --entrypoint bash -v `pwd`/data:/home/student/data masaomi/biodocker
