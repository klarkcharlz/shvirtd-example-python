 #!/bin/bash

SCRIPT_DIR=$(dirname $(realpath $0))

set -a
. "$SCRIPT_DIR/.env"
set +a

# Текущая дата и время для имени файла
TIMESTAMP=$(date +"%F-%H-%M-%S")
BACKUP_DIR="/opt/backup"
BACKUP_NAME="db-backup-$TIMESTAMP.sql"

sudo mkdir -p $BACKUP_DIR

docker run \
    --rm --entrypoint "" \
    -v `pwd`$BACKUP_DIR:/backup \
    --network=bridge \  # под таким именем у меня создалась сеть, а не backend
    schnitzler/mysqldump \
    mysqldump --opt -h $DB_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD "--result-file=/backup/dumps.sql" database

if [ $? -eq 0 ]; then
 echo "Backup was created successfully"
else
 echo "Backup failed"
 exit 1
fi
