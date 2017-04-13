#!/bin/bash
chmod ugo+r /opt/shiny/G4Hunter/data/*
mkdir -p /opt/shiny/G4Hunter/logs
chmod ugo+rwx /opt/shiny/G4Hunter/logs
docker run -u shiny --rm -p 80:3838 crukci-bioinformatics/G4Hunter:latest &
sleep 2
docker ps -a
