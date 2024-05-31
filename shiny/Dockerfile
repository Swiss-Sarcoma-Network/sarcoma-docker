FROM rocker/shiny:latest

# Update apt-get and install dependencies
RUN apt-get update && apt-get install -qq -y libpq-dev

# Install R packages from CRAN
RUN R -e "install.packages(c('ggplot2', 'shiny', 'shinydashboard', 'shinydashboardPlus', 'dplyr', 'RPostgres', 'pkgload', 'dbplyr', 'shinyjs', 'shinymanager', 'shinyWidgets', 'shinyvalidate', 'shinytreeview', 'DT', 'readr', 'dm'), repos='http://cran.rstudio.com/')"

# Install any additional packages that might not be available on CRAN
RUN R -e "if (!requireNamespace('shinytreeview', quietly = TRUE)) devtools::install_github('ropensci/shinytreeview')"
RUN R -e "if (!requireNamespace('dm', quietly = TRUE)) devtools::install_github('cynkra/dm')"
