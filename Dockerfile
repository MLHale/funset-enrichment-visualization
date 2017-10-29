###################################
#
# CYBR8470 Dev Docker Container
# @author Matt Hale
#
###################################

# Pull base image.
FROM python:2.7.13
ENV PYTHONUNBUFFERED 1

# Setup linkages to code repositories and add to image

WORKDIR /var/www/backend

#Linux stuff
RUN apt-get install libevent-dev
RUN pip install python-memcached

#Python packages
RUN pip install Django
RUN pip install djangorestframework
RUN pip install markdown
RUN pip install django-filter
RUN pip install psycopg2
RUN pip install requests
RUN pip install djangorestframework-jsonapi
RUN pip install django-cors-headers

# BIOI Libraries
RUN pip install pronto
RUN pip install serpy
