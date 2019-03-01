# @Author: Matthew Hale <matthale>
# @Date:   2018-08-29T23:32:46-05:00
# @Email:  mlhale@unomaha.edu
# @Filename: restore.sh
# @Last modified by:   matthale
# @Last modified time: 2018-09-12T16:06:26-05:00
# @Copyright: Copyright (C) 2018 Matthew L. Hale

#!/bin/bash
if [ -z "$1" ]
  then
    echo "Please supply a file to restore from e.g. ./restore.sh <filename>"
    exit 0
fi
echo "Restoring db from file:" $1
cd ..
echo "Terminating any existing database connections and dropping tables..."
docker-compose exec db psql -U postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname = current_database() AND pid <> pg_backend_pid();"
docker-compose exec db dropdb -U postgres postgres
echo "Recreating database..."
docker-compose exec db createdb -U postgres postgres
echo "Preparing to load data..."
docker-compose exec db psql -U postgres -c "ALTER SYSTEM SET max_wal_size = 6000;"
docker-compose exec db pg_restore -U postgres -d postgres $1
docker-compose exec db psql -U postgres -c "ALTER SYSTEM SET max_wal_size = 1000;"
echo "...done"
