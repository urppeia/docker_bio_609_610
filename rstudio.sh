#!/bin/bash

docker run --rm -p 8780:8787 -e PASSWORD=pass -v `pwd`/data:/home/data dktanwar/bio_609_610
