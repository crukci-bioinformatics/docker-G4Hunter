
# check latest shiny server downloads at https://download3.rstudio.org/

# build docker image
docker build -t="crukci-bioinformatics/shiny-server" .

# remove danlging/untagged images
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

# start shiny server
docker run --rm -p 4000:3838 crukci-bioinformatics/shiny-server &

# start shiny server with logging to host file system
docker run --rm -p 4000:3838 -v /var/log/:/var/log/ crukci-bioinformatics/shiny-server &

# check running containers
docker ps 

# stop shiny server (container automatically removed)
docker stop compassionate_meninsky

# save image
docker save crukci-bioinformatics/shiny-server > docker_shiny_server.tar

# transfer to bioinf-rstud001
rsync -av --rsh="ssh -c arcfour" --progress docker_shiny_server.tar bioinf-rstud001:/tmp

# start docker service on bioinf-rstud001 if necessary
ssh bioinf-rstud001
sudo service docker status
sudo service docker start

# import image on bioinf-rstud001
cd /tmp
docker load -i docker_shiny_server.tar
docker images

# start shiny server (note different port since existing shiny server already using 3838)
docker run --rm -p 4000:3838 crukci-bioinformatics/shiny-server &

