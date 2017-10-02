FROM crukcibioinformatics/shiny-base

# Installing R library dependencies
COPY G4Hunter/install-packages.r /etc/shiny-server/
RUN R -f /etc/shiny-server/install-packages.r

RUN mkdir /srv/shiny-server/G4Hunter
RUN mkdir /srv/shiny-server/G4Hunter/www

COPY G4Hunter/www/* /srv/shiny-server/G4Hunter/www/

COPY G4Hunter/*.r /srv/shiny-server/G4Hunter/
COPY G4Hunter/*.R /srv/shiny-server/G4Hunter/

