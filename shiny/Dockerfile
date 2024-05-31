FROM rocker/shiny:4.1.1
RUN apt-get update
RUN apt-get install -qq -y libpq-dev
RUN install2.r ggplot2 shiny shinydashboard  \
               shinydashboardPlus  \
               dplyr RPostgres  \
               pkgload
               
