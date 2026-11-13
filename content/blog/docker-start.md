---
title: docker container startup with ntfy notifications
date: 2023-11-07
description: Start all containers defined in your Docker Compose files, then send an ntfy notification when startup finishes.
tags:
- docker
---

Used on a self-hosted server and also on a VPS.

> **Can be used in a set**
>
> - [Docker Backup](/blog/docker-backup/) to back up your yaml files and container data
> - [Docker Restore](/blog/docker-restore/) to restore your yaml files and container data in the same or another host
> - [Docker Start](/blog/docker-start/) to start all containers in your yaml files

Script to be modified with your own setup:

Example user: ubuntu

``` bash
#!/bin/bash

# Get today's date for our backup filename
startDate=$(date  +'%F')

# this just prints the formatted date variable to the console if you want to see it.
echo "Start date $startDate"

# move to the path where you will keep all of your docker configurations and data
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