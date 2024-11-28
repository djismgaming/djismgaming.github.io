---
draft: false
date: 2024-10-28
categories:
  - unRAID
tags:
  - linux
  - proxmox
authors:
  - ismael
---

# ntfy notifications from unRAID

``` bash
#!/bin/bash
OUTPUT=$(docker image prune -af | tail -1)
topicurl=https://ntfy.example.com/topic

curl --insecure \
  -d "$OUTPUT" \
  -H "Title: Dangling images cleaned on $(hostname)" \
  $topicurl
```
