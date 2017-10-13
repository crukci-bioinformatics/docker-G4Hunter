#!/bin/bash
rm -rf G4Hunter
git clone https://github.com/LacroixLaurent/G4Hunter.git G4Hunter
docker build --tag="crukci-bioinformatics/g4hunter" .
