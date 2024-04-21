FROM rocker/shiny:latest
RUN apt-get update
RUN apt-get install -qq -y libpq-dev libglpk-dev r-cran-igraph
RUN install2.r ggplot2 shiny shinydashboard  \
               shinydashboardPlus remotes devtools \
               dplyr RPostgres shinymanager 
COPY ssndb_0.0.0.1.tar.gz /R/
COPY DESCRIPTION /R/
RUN R -e 'remotes::install_deps("/R/")'
RUN R -e 'install.packages("/R/ssndb_0.0.0.1.tar.gz", repos = NULL, type = "source")'
# RUN R -e 'ssndb::init_db()'

