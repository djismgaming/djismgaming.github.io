---
title: ntfy notifications from unRAID using curl
draft: false
date: 2024-10-28
tags:
  - ntfy
authors:
  - djismgaming
categories:
  - Selfhosting
---
``` bash
#!/bin/bash
OUTPUT=$(docker image prune -af | tail -1)
topicurl=https://ntfy.example.com/topic

curl --insecure \
  -d "$OUTPUT" \
  -H "Title: Dangling images cleaned on $(hostname)" \
  $topicurl
```
