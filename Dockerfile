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

#Python packages
RUN pip install Django
RUN pip install djangorestframework
RUN pip install markdown
RUN pip install django-filter
RUN pip install psycopg2
RUN pip install requests
RUN pip install djangorestframework-jsonapi

# BIOI Libraries
RUN pip install pronto
