#!/bin/bash

# Configuration
DB_CONTAINER_NAME="inexture-db-1"
DB_NAME="mydatabase"
DB_USER="root"
DB_PASSWORD="password"
BACKUP_DIR="/backup"
GITHUB_REPO_URL="git@github.com:PagiBharat/python-sample-app.git"
TIMESTAMP=$(date +"%Y%m%d_%H%M")

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Dump MySQL database with compression
docker exec $DB_CONTAINER_NAME /usr/bin/mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME | gzip > $BACKUP_DIR/db_backup_$TIMESTAMP.sql.gz

# Clone the GitHub repository
git clone $GITHUB_REPO_URL /tmp/your-repo

# Create a timestamped ZIP file with the database dump and source code
zip -r $BACKUP_DIR/backup_$TIMESTAMP.zip $BACKUP_DIR/db_backup_$TIMESTAMP.sql.gz /tmp/your-repo

# Clean up temporary files
rm -rf /tmp/your-repo
rm $BACKUP_DIR/db_backup_$TIMESTAMP.sql.gz

echo "Backup completed successfully at $BACKUP_DIR/backup_$TIMESTAMP.zip"
