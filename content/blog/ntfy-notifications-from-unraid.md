---
title: "ntfy notifications from unRAID using curl"
date: 2024-10-28
draft: false
tags:
  - ntfy
  - selfhosting
showToc: false
---

```bash
#!/bin/bash
OUTPUT=$(docker image prune -af | tail -1)
topicurl=https://ntfy.example.com/topic

curl --insecure \
  -d "$OUTPUT" \
  -H "Title: Dangling images cleaned on $(hostname)" \
  $topicurl
```