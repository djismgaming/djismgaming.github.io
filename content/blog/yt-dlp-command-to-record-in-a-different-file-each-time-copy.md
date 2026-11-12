---
title: yt-dlp command to record in a different file each time
date: 2026-08-18
tags:
- commands
---

# yt-dlp command to record in a different file each time

``` sh
yt-dlp -o "%(epoch)s.%(ext)s" --no-part --hls-use-mpegts
```
