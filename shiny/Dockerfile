FROM rocker/shiny:latest
RUN apt-get update
RUN apt-get install -y libglpk40
RUN apt-get install -qq -y libpq-dev
RUN install2.r ggplot2 shiny shinydashboard hinydashboardPlus dplyr RPostgres pkgload dbplyr shinyjs shinymanager \
    shinyWidgets shinyvalidate shinytreeview DT readr dm
