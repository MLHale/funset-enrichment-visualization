# @Author: Matthew Hale <mlhale>
# @Date:   2018-02-14T23:02:38-06:00
# @Email:  mlhale@unomaha.edu
# @Filename: DockerFile
# @Last modified by:   mlhale
# @Last modified time: 2018-02-15T00:21:25-06:00
# @License: Funset is a web-based BIOI tool for visualizing genetic pathway information. This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
# @Copyright: Copyright (C) 2017 Matthew L. Hale, Dario Ghersi, Ishwor Thapa


# Pull base image.
FROM ubuntu:latest


ENV PYTHONUNBUFFERED 1

# Setup linkages to code repositories and add to image


ENV APP_ROOT /var/www/backend



WORKDIR ${APP_ROOT}

#Linux stuff
RUN apt-get update --fix-missing
RUN apt-get install python2.7 python-pip -y
RUN pip install --upgrade pip
RUN apt-get install libevent-dev -y

# BIOI Libraries
RUN pip install pronto
RUN pip install serpy
RUN apt-get install libboost-dev -y

#Python packages
RUN pip install python-memcached
RUN pip install Django==1.11
RUN pip install djangorestframework==3.6.3
RUN pip install markdown
RUN pip install django-filter==1.1
RUN pip install psycopg2-binary
RUN pip install requests
RUN pip install djangorestframework-jsonapi
RUN pip install django-cors-headers
RUN pip install bleach
RUN pip install django-ipware
RUN pip install gunicorn==19.6.0
RUN pip install scipy
RUN pip install sklearn

ENV APP_USER pathviz


#RUN groupadd -r ${APP_USER} \
#    && useradd -r -m \
#    --home-dir ${APP_ROOT} \
#    -s /usr/sbin/nologin \
#    -g ${APP_USER} ${APP_USER}
#USER ${APP_USER}
#ADD . ${APP_ROOT}
