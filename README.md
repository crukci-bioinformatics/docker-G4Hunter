Docker image for G4Hunter Shiny app
===================================

[G4Hunter](http://bioinformatics.cruk.cam.ac.uk/G4Hunter) is a web application developed by
[Bedrat et al., NAR 2016](https://academic.oup.com/nar/article-lookup/doi/10.1093/nar/gkw006)
to evaluate the propensity for DNA and RNA sequences to form G-quadruplex structures.

This repository contains a Dockerfile used to build a [Docker](https://www.docker.com) image in
which [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server), R, the G4Hunter web
application and all its R package dependencies are installed. The Docker image is built on the
[shiny-base](https://github.com/crukci-bioinformatics/shiny-base/blob/master/README.md)
image which packages Shiny Server, R and the [tidyverse](https://www.tidyverse.org/)
R packages.


### Building the Docker image

To build the Docker image run the following command within the directory containing
the Dockerfile:

```
docker build --tag="crukcibioinformatics/g4hunter" .
```


### Obtaining a pre-built image

Alternatively, a pre-built image can be obtained from
[Docker Hub](https://hub.docker.com/r/crukcibioinformatics/shiny-base/)
as follows:

```
docker pull crukcibioinformatics/g4hunter
```


### Deployment using Docker

To deploy the application within a Docker container running Shiny Server:

```
docker run -p 3838:3838 crukcibioinformatics/g4hunter
```

To deploy the application in detached mode (`-d`), listening on the host's port
8080 (`-p 8080:3838`), capturing logging information so that this is accessible
outside the container, and running more securely within the container as the
shiny user instead of root:

```
mkdir -p logs
chmod ugo+rwx logs
docker run -u shiny -d -p 8080:3838 -v ${PWD}/logs:/var/log/shiny-server crukcibioinformatics/g4huner
```


### Configuring Shiny Server

Shiny Server can be configured by creating a configuration file and using this
in place of the default one installed in the Docker container in
`/etc/shiny-server/shiny-server.conf`. See the
[shiny-base](https://github.com/crukci-bioinformatics/shiny-base/blob/master/README.md)
Docker image for more details.


### Deployment using Singularity

The [G4Hunter site](http://bioinformatics.cruk.cam.ac.uk/G4Hunter) is deployed
using [Singularity](http://singularity.lbl.gov), which is another container
system. A Singularity image in which Shiny Server, R, the G4Hunter Shiny
application and its R package dependencies can be built from the Docker image
available on Docker Hub as follows:

```
sudo singularity build g4hunter.img docker://crukcibioinformatics/g4hunter
```

This does not require Docker to be installed but does require `sudo` privileges
on the machine on which you build the Singularity image. The ownership, both user
and group, of the image should then be changed using `chown`.

The image can be run as follows:

```
mkdir -p logs
singularity run -B logs:/var/log/shiny-server g4hunter.img
```

