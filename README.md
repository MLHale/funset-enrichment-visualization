# CYBR8470-building-a-webservice-lab
This repository provides a central location that contains sub-modules related to the programmatic environment for the building a server lab in CYBR 8470.

### Requirements
* Docker (https://www.docker.com/)

### Installation
You need to build the docker image from the provided DockerFile using Docker Compose. To do this, ensure docker is running, and then:

```bash
git clone --recursive https://github.com/MLHale/CYBR8470-building-a-webservice-lab.git
cd CYBR8470-building-a-webservice-lab
docker-compose build
```

This creates a few docker containers with all of the requisite installed dependencies to run the dev environment.

### Setup
First, upon initial install, you need to do some basic setup.

#### Django
We need to initialize the Django database in postgres

```bash
docker-compose run django bash
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser --username admin --email admin
exit
```
Specify a password for admin. In development, use admin1234 for simplicity.

### Run the app
```bash
docker-compose up
```
