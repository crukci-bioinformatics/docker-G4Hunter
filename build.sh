#!/bin/bash

rm -rf G4Hunter

git clone https://github.com/LacroixLaurent/G4Hunter.git G4Hunter

chmod ugo+r G4Hunter/*.R
chmod ugo+r G4Hunter/*.r
chmod ugo+r G4Hunter/www/*
chmod ugo+r shiny-server.conf

# build docker image
docker build --tag="crukci-bioinformatics/g4hunter" .

# or build docker image from scratch without using cache
#docker build --tag="crukci-bioinformatics/g4hunter" --no-cache .

# remove dangling/untagged images
#docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

