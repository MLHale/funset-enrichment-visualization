# @Author: Matthew Hale <matthale>
# @Date:   2018-08-29T16:28:59-05:00
# @Email:  mlhale@unomaha.edu
# @Filename: backup.sh
# @Last modified by:   matthale
# @Last modified time: 2019-02-25T13:23:18-06:00
# @Copyright: Copyright (C) 2018 Matthew L. Hale

#!/bin/bash
DATE=`date '+%Y-%m-%d-%H-%M-%S'`
echo "Running Backup on" $DATE
cd "$(dirname "$0")";
cd ..
docker-compose exec -d db pg_dump postgres -U postgres -Fc -f database-backup/"$DATE".dump
gcloud auth activate-service-account --key-file database-backup/gcloud-cred.json
gsutil cp database-backup/"$DATE".dump  gs://funset-backups/$1
echo "...done"
