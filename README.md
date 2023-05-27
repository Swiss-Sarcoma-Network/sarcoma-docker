# Docker Compose Setup for Development 

This repository contains a docker compose setup to provide a shiny server and Postgres database for development purposes.
Docker compose allows to manage multiple containers, in this case a shiny container and Postgres container, in order to serve different parts of an application such as frontend and backend. 

## Requirements 

Make sure to have a working docker runtime environment with docker and and docker-compose installed and running. 
If you are working on a local machine, e.g., your local notebook, Docker Desktop works well to test things. 



## Example Usage 

Given your Docker runtime environment is up running, e.g., local Docker Desktop, simple start docker compose inside the document root of this repository. I recommend to use the `--force-recreate` flag as long as changes to the docker config are still somewhat frequent. 

```sh
docker-compose up --force-recreate
```

>Note for older versions of docker, you need to call `docker-compose up` instead.


This will start both, a docker container running shiny, exposed at port 3838 and a postgres container serving a Postgres database, exposed
at its default port 5432. As an end user you can reach a demo shiny app on `localhost:3838/demo` using your favorite web browser. 
To reach Postgres you can either use the psql client or any other software that interfaces with Postgres. 

```sh
psql -h 'localhost' -p 5432 -U postgres
```

In the demo setup, your password for the postgres root is simply `postgres`.


## A Demo App

If you look at the docker-compose.yml file, you might have noticed the volume mount `./shiny-home:/srv/shiny-server` which mounts the `shiny-home` sub directory of this directory to the directory inside the shiny container where the apps are at. That way you can simply move your app to `shiny-home/folder-of-your-app` and it will be served at `localhost:3838/demo`. 

The demo will use connect to the Postgres container and get data from a demo schema and table that was populated by demo.sql. 
The shiny displays simply displays the table's content in a table widget. 


## Potential Issues

- make sure directories `pgdata`, `shiny-logs` can be created or create them in advance. Do not add the former two directories to git though. 

- This is setup is tested on OSX with Docker Desktop, untested on Windows' Docker Desktop.  















