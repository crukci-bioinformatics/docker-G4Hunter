#!/bin/bash

git clone https://github.com/crukci-bioinformatics/G4Hunter.git G4Hunter

chmod ugo+r G4Hunter/*.R
chmod ugo+r G4Hunter/*.r
chmod ugo+r G4Hunter/www/*
chmod ugo+r shiny-server.conf

# build docker image
docker build --tag="crukci-bioinformatics/g4hunter" .
#docker build --tag="crukci-bioinformatics/G4Hunter" --no-cache .

# remove dangling/untagged images
#docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
