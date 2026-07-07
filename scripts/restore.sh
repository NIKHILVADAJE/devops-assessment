#!/bin/bash
set -e
BACKUP_FILE=$(ls -t ./backups/backup_*.sql | head -n 1)
docker exec -i devops_postgres psql -U myuser -d mydatabase < "$BACKUP_FILE"
echo "Restore completed successfully!"
