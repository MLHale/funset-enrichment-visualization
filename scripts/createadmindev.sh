# @Author: Matthew Hale <matthale>
# @Date:   2018-08-29T23:32:46-05:00
# @Email:  mlhale@unomaha.edu
# @Filename: restore.sh
# @Last modified by:   matthale
# @Last modified time: 2019-02-25T13:27:25-06:00
# @Copyright: Copyright (C) 2018 Matthew L. Hale

#!/bin/bash
if [ -z "$1" ] && [ -z "$2" ]
  then
    echo "Please supply a username and password e.g. ./createadmin.sh <username> <password>"
    exit 0
fi

cd ../cybertrust-dev
docker-compose exec django python manage.py shell -c "from django.contrib.auth.models import User; u = User.objects.create_superuser('$1', 'admin@example.com', '$2');"
echo "...done"
