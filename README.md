# FunSet Enrichment Visualization
The FunSet webserver performs Gene Ontology (GO) enrichment analysis, identifying GO terms that are statistically overrepresented in a target set with respect to a background set. The enriched terms are displayed in a 2D plot that captures the semantic similarity between terms, with the option to cluster the terms and identify a representative term for each cluster. FunSet can be used interactively or programmatically, and allows users to download the enrichment results both in tabular form and in graphical form as SVG files or in data format as JSON.

## Requirements
This app is fully containerized. There is only 1 requirement:
* Docker (https://docs.docker.com/install/)

## API (Backend) Installation
You need to build the docker image from the provided DockerFile using Docker Compose. To do this:

### Acquiring the files
```bash
git clone --recursive https://github.com/MLHale/funset-builds.git
cd funset-builds
git submodule sync
git submodule update --init --recursive --remote
```

### Building and Running the API
```bash
docker-compose build
docker-compose up -d
```

This creates a few docker containers with all of the requisite installed dependencies to run the dev environment. It also initializes the database and starts the containers.

### Setup an Admin user and compile C libraries
To create a new admin user for use in the admin portal do the following once the containers are up and running (i.e. `docker-compose up -d` has been run).

```bash
docker-compose exec django bash
python manage.py createsuperuser
# provide admin credentials
python loadterms.py -i ../../../GOUtildata/go.obo
cd ../../../GOUtil
g++ -O3 -o enrich enrich.C utilities.C --std=gnu++11
g++ -O3 -o funSim funSim.C utilities.C --std=gnu++11
exit
```
> This may take some time, especially when loading the terms from the go ontology.

Now visit `localhost` in your host browser to view the API.

## Client-side App Installation
The client-side app is designed to run separately from the API as a static web app.

### Building the app
* install npm 6.0.0+
* install ember-cli 2.16.2 +

Then, from the `funset-builds/frontend/` folder):

```bash
npm install
```

- open `frontend/config/environment`
- set `ENV.host` to the url where your backend server is deployed
- save the file
- then do the following from within the `frontend` folder:

```bash
ember build -p
```
> This will build the client-side app as a set of html/css/js files in the `dist/` directory.

### Deploy the client-side app to a production CDN using surge
The client-side app should be served using a content deployment network (CDN). A good one is [surge](surge.sh).

To setup surge:
```bash
npm install --global surge
```

To deploy the client app to surge, do the following:

```bash
ember build -p
surge dist/
#specify the url to deploy to, surge will create a funny name for you by default, replace with your own domain name.
```
> Note that `surge dist/ <url>` shortcuts the need to type in the url.

## Development Environment
### Running the backend API in development
In addition to the production deployment, you can also run the server in development mode. In development mode, the server will reload automatically whenever you make any sort of code changes in python.

To run the server in dev mode, simply execute the following from within the `dev` folder:

```bash
docker-compose build
docker-compose up -d
```
Now visit `localhost` in your host browser to view the api.

### Setup an Admin user and compile C libraries
If you run the server in dev mode, you will still need to set it up first.

```bash
docker-compose exec django bash
python manage.py createsuperuser
# provide admin credentials
python loadterms.py -i ../../../GOUtildata/go.obo
cd ../../../GOUtil
g++ -O3 -o enrich enrich.C utilities.C --std=gnu++11
g++ -O3 -o funSim funSim.C utilities.C --std=gnu++11
exit
```
> This may take some time, especially when loading the terms from the go ontology.


### Running the client-side ember app in development
Like the backend API, the front-end client-side app can also be run locally in development mode (i.e. instead of pushing to surge). While running in dev mode any changes to the javascript code will automatically recompile and re-run the app. The following commands runs the client-side app in dev mode:

from `frontend`, run:
```bash
ember s
```

visit the client-side app at: `localhost:4200`

### Updating to latest versions of of the code
To update to the latest frontend and backend codebases, simply do the following to update the provided submodules.

```bash
cd frontend
git pull
cd ../backend
git pull
```
or type:

```bash
git submodule update --remote
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

Now visit ```localhost:8080``` or ```<ip>:8080``` to view the current performance. You should see monitoring tools that resemble:

![cadvisor](docs/img/cadvisor.png)

## License
Funset is a web-based BIOI tool for visualizing genetic pathway information.
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
