---
title: docker container restore with ntfy notifications
description: Used in selfhosted server and also a VPS
tags:
- docker
---

# docker container restore with ntfy notifications

Used in selfhosted server and also a VPS

> **Can be used in a set**
>
> - [Docker Backup](/blog/docker-backup/) to backup your yaml files and container data
> - [Docker Restore](/blog/docker-restore/) to restore your yaml files and container data in the same or another host
> - [Docker Start](/blog/docker-start/) to start all containers in your yaml files

Script to be modified with your own setup:

Example user: ubuntu

``` bash
#!/bin/bash

# Get today's date for our backup filename
restoreDate=$(date  +'%F')

# this just prints the formated date variable to the console if you want to see it.
echo "Restore date $restoreDate"

# move to the path where you will keep all of yoru docker configurations and data
cd /home/ubuntu/docker

for file in /home/ubuntu/docker/_backups/*.tar.gz
do
    tar -xvzf "$file" -C /home/ubuntu/docker/
done

restoreDate=$(date  +'%F')
topicurl=https://ntfy.example.com/topic

curl \
  -d "Date: $restoreDate
Backup location: /home/ubuntu/docker/_backups
Restore location: /home/ubuntu/docker/

The restore is now complete.
Please check for errors." \
  -H "Title: docker restore - $(hostname)" \
  $topicurl
```
