#!/bin/bash

winpty docker run --rm -it --entrypooint bash -v `pwd`/data:/home/student/data masaomi/biodocker
