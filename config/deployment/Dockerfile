###################################
#
# CYBR8470 Dev Docker Container
# @author Matt Hale
#
###################################

# Pull base image.
FROM ubuntu:latest


ENV PYTHONUNBUFFERED 1

# Setup linkages to code repositories and add to image


ENV APP_ROOT /var/www/backend



WORKDIR ${APP_ROOT}

#Linux stuff
RUN apt-get update
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
RUN pip install djangorestframework
RUN pip install markdown
RUN pip install django-filter
RUN pip install psycopg2
RUN pip install requests
RUN pip install djangorestframework-jsonapi
RUN pip install django-cors-headers
RUN pip install bleach
RUN pip install django-ipware

RUN pip install gunicorn==19.6.0

ENV APP_USER pathviz


#RUN groupadd -r ${APP_USER} \
    && useradd -r -m \
    --home-dir ${APP_ROOT} \
    -s /usr/sbin/nologin \
    -g ${APP_USER} ${APP_USER}
#USER ${APP_USER}
#ADD . ${APP_ROOT}
