# docker container backup with ntfy notifications

Used in selfhosted server and also a VPS

??? note "Can be used in a set"

    - [Docker Backup](docker-backup.md) to backup your yaml files and container data
    - [Docker Restore](docker-restore.md) to restore your yaml files and container data in the same or another host
    - [Docker Start](docker-start.md) to start all containers in your yaml files

Script to be modified with your own setup:

Example user: ubuntu

``` bash
#!/bin/bash

# Get today's date for our backup filenames
backupDate=$(date  +'%F')

# this just prints the formated date variable to the console if you want to see it.
echo "Backup date $backupDate"

# move to the path where you will keep all of yoru docker configurations and data
cd /home/ubuntu/docker

cd gateway
docker compose stop
cd ../
tar -czvf ./_backups/gateway-backup-$backupDate.tar.gz gateway
cd gateway
docker compose start

cd ../comingsoon
docker compose stop
cd ../
tar -czvf ./_backups/comingsoon-backup-$backupDate.tar.gz comingsoon
cd comingsoon
docker compose start

# # move to the path where you will keep all of your docker configurations and data
cd ../

# # now go back to home, and copy my backup file to my NAS
echo ""
echo "Backup copy is running..."

# # copy the tar archive to your final backup location 
backuplog=$(rsync -avz -e ssh /home/ubuntu/docker/_backups ubuntu@IP:/mnt/ubuntu/backups/)

# # remove the tar file from the main home folder after it's copied
mv ./_backups/* /mnt/backups/
# rm ./_backups/*

topicurl=https://ntfy.example.com/topic

curl \
  -d "Date: $backupDate 
--- backup transfer start ---
$backuplog
--- backup transfer end ---

The backup is now complete.
Please check for errors." \
  -H "Title: docker backup - $(hostname)" \
  $topicurl
```
