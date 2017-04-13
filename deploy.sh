#!/bin/bash

mkdir -p /opt/shiny/g4hunter/logs
chmod ugo+rwx /opt/shiny/g4hunter/logs
docker run -u shiny --rm -p 80:3838 crukci-bioinformatics/g4hunter:latest &
sleep 2
docker ps -a
