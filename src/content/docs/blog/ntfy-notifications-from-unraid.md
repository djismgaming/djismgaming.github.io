---
title: ntfy notifications from unRAID using curl
date: 2024-10-28
tags:
- ntfy
---

Send notifications from an unRAID server to [ntfy](https://ntfy.sh/) using `curl`. The example below notifies the result of a Docker image prune:

``` bash
#!/bin/bash
OUTPUT=$(docker image prune -af | tail -1)
topicurl=https://ntfy.example.com/topic

curl --insecure \
  -d "$OUTPUT" \
  -H "Title: Dangling images cleaned on $(hostname)" \
  $topicurl
```
