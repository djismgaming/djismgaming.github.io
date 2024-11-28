---
title: ntfy notifications from unRAID
draft: true
date: 2024-10-28
weight: 1
tags: 
author: djismgaming
showToc: true
TocOpen: false
hidemeta: false
comments: false
description: 
disableHLJS: false
disableShare: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
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
