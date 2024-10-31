---
draft: true
date: 2023-10-28
categories:
  # - Gaming
  # - unRAID
  # - Proxmox
tags:
  - linux
  - proxmox
  # - autohotkey
  # - windows
  # - gaming
  # - origin
  # - EA Desktop
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
