# @Author: Matthew Hale <matthale>
# @Date:   2018-08-29T23:32:46-05:00
# @Email:  mlhale@unomaha.edu
# @Filename: restore.sh
# @Last modified by:   matthale
# @Last modified time: 2019-02-25T13:23:58-06:00
# @Copyright: Copyright (C) 2018 Matthew L. Hale

#!/bin/bash

echo "Migrating DB..."
cd ../funset-dev
docker-compose exec django python manage.py makemigrations
docker-compose exec django python manage.py makemigrations api
docker-compose exec django python manage.py migrate
echo "...done"
