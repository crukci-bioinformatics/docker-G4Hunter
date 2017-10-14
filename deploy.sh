#!/bin/bash
mkdir -p logs
chmod ugo+rwx logs
docker run -u shiny -d --rm -p 80:3838 \
  -v ${PWD}/logs:/var/log/shiny-server \
  crukci-bioinformatics/g4hunter
