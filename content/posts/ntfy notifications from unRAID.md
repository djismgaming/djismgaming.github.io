---
title: ntfy notifications from unRAID using curl
draft: false
date: 2024-10-28
weight: 1
tags: 
  - ntfy
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
