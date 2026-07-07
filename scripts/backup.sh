#!/bin/bash
set -e
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
mkdir -p ./backups
docker exec -t devops_postgres pg_dump -U myuser -d mydatabase > "./backups/backup_$TIMESTAMP.sql"
echo "Backup created successfully!"
