---
title: docker container startup with ntfy notifications
description: Used in selfhosted server and also a VPS
tags:
- docker
---

# docker container startup with ntfy notifications

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
startDate=$(date  +'%F')

# this just prints the formated date variable to the console if you want to see it.
echo "Restore date $restoreDate"

# move to the path where you will keep all of yoru docker configurations and data
cd /home/ubuntu/docker

find . -maxdepth 2 -name "docker-compose.yml" -execdir docker compose up -d \;

startDate=$(date  +'%F')
topicurl=https://ntfy.example.com/topic

curl -k \
  -d "Date: $startDate
Docker started on $(hostname)

The start is now complete.
Please check for errors." \
  -H "Title: docker start - $(hostname)" \
  $topicurl
```