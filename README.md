# cybertrust-builds
Contains docker files for dev and production builds of cybertrust

### Requirements
* Docker (https://www.docker.com/)

### Installation
You need to build the docker image from the provided DockerFile and Docker Compose. To do this:

```bash
git clone --recursive https://github.com/MLHale/pathway-viz-builds.git
cd pathway-viz-builds
docker-compose build
```

This creates a few docker containers with all of the requisite installed dependencies to run the dev environment.

### Development Environment Setup
First, upon initial install, you need to build the ember dependencies. Do the following (on the host):

* install npm 6.0.0+
* install ember-cli 2.16.2 +

Then:

```bash
cd frontend/
npm install
```

### Ember to Django Build Pipeline
Turns out docker has poor performance for bound volumes. Until it is resolved, the recommended build process is the following:

```bash
docker-compose up
```
This will run the django container, binding the server to localhost:8000

Open a separate terminal and:

```bash
cd frontend
ember build -w -o ../backend/static/ember
```

### Updating to latest versions of of the code
To update to the latest frontend and backend codebases, simply do the following to update the provided submodules.

```bash
cd frontend
git pull
cd ../backend
git pull
```

## Collaborating on this project
To prevent merge conflicts, always make sure you are working on a git branch. Read more about git branching here: https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
For an overview of useful git commands, visit: https://services.github.com/on-demand/downloads/github-git-cheat-sheet.pdf

To create a new branch in each repo, navigate to the parent directory:
```bash
cd <path to this project directory>
git pull
git branch <yourname>-<feature-name>
cd backend/
git pull
git branch <yourname>-<feature-name>
cd ../frontend/
git pull
git branch <yourname>-<feature-name>
```
It is good practice to name the branch using a combination of your name and the feature you are working on. For example ```git branch mlhale-userinterface``` might be an acceptable branch name.

### When to make a pull request
Once you have finished developing whatever feature you are working on, make a pull request. To make a pull request, use the github web or desktop interfaces to select where the pull request targets (usually the ```master``` branch).

Visit https://help.github.com/articles/about-pull-requests/ for more information.

## Monitoring containers
If desired, you can view the performance of containers using the google cAdvisor project (see https://github.com/google/cadvisor).

To run do the following:
```bash
docker pull google/cadvisor:latest
sudo docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest
```

Now visit ```localhost:8080``` to view the current performance. You should see monitoring tools that resemble:

![cadvisor](docs/img/cadvisor.png)

## License
Pathway Viz is a web-based BIOI tool for visualizing genetic pathway information.
Copyright (C) 2017  Matthew L. Hale, Dario Ghersi, Ishwor Thapa

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
