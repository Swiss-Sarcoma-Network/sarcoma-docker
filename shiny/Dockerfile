FROM rocker/shiny:latest
RUN apt-get update
RUN apt-get install -y libglpk40
RUN apt-get install -qq -y libpq-dev
RUN install2.r ggplot2 shiny shinydashboard hinydashboardPlus dplyr RPostgres pkgload dbplyr shinyjs shinymanager \
    igraph shinyWidgets shinyvalidate DT readr devtools
RUN install2.r dm
RUN R -e "devtools::install_github('dreamRs/shinytreeview')"
