FROM centos:7

RUN yum groupinstall -y 'development tools'
RUN yum install -y wget

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y R

RUN yum install -y libxml2-devel

RUN wget https://download3.rstudio.org/centos6.3/x86_64/shiny-server-1.5.2.837-rh6-x86_64.rpm
RUN yum install -y --nogpgcheck shiny-server-1.5.2.837-rh6-x86_64.rpm

EXPOSE 3838

# Installing R library dependencies
COPY G4Hunter/install-packages.r /etc/shiny-server/
RUN R -f /etc/shiny-server/install-packages.r

COPY shiny-server.sh /usr/bin/shiny-server.sh

# running shiny server as shiny user requires write access to /var/lib/shiny-server
RUN chown -R shiny:shiny /var/lib/shiny-server

#VOLUME /data

RUN mkdir /srv/shiny-server/G4Hunter; mkdir /srv/shiny-server/G4Hunter/www

COPY G4Hunter/www/* /srv/shiny-server/G4Hunter/www/

# modified shiny server configuration file
COPY shiny-server.conf /etc/shiny-server/

COPY *.r /srv/shiny-server/G4Hunter/
COPY *.R /srv/shiny-server/G4Hunter/

CMD ["/usr/bin/shiny-server.sh"]
