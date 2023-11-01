#!/bin/bash

winpty docker run --rm -v /$(pwd)/data:/home/student/data --user student --hostname biodocker --name biodocker -ti dktanwar/bio_609_610 bash --login
