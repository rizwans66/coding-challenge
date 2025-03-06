#!/bin/bash

# Variables
SOURCE_DIR="/home/domain/"  # Ensure trailing slash to preserve structure
REMOTE_SERVER="remote_server_IP or FQDN"  # Remote EC2 server IP
REMOTE_USER="ec2-user"  # Change if using Ubuntu (`ubuntu`)
REMOTE_DIR="/home/domain/"  # Target directory on the remote server
SSH_KEY="$HOME/.ssh/my-aws-keyaws"  # Path to SSH private key

DATE_FROM="2025-08-01 09:00:00"  # Start date/time
DATE_TO="2025-08-2 08:00:00"  # End date/time

# Convert dates to timestamps
TIMESTAMP_FROM=$(date -d "$DATE_FROM" +%s)
TIMESTAMP_TO=$(date -d "$DATE_TO" +%s)

# Find all modified files and directories within the date range
FILES_TO_COPY=$(find "$SOURCE_DIR" -newermt "$DATE_FROM" ! -newermt "$DATE_TO")

# Rsync command to copy files & preserve directory structure
rsync -avz -e "ssh -i $SSH_KEY" --relative $FILES_TO_COPY "$REMOTE_USER@$REMOTE_SERVER:$REMOTE_DIR"

# Verify sync status
if [[ $? -eq 0 ]]; then
    echo "Backup completed successfully."
else
    echo "Backup failed. Check for errors."
    exit 1
fi
