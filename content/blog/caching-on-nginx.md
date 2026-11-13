---
title: Caching on nginx
date: 2023-10-12
description: 'Enable reverse-proxy caching on nginx, as configured for the linuxserver/nginx image.'
tags:
- commands
---

Caching configuration ([https://www.nginx.com/resources/wiki/start/topics/examples/reverseproxycachingexample/](https://www.nginx.com/resources/wiki/start/topics/examples/reverseproxycachingexample/))


This part goes into nginx.conf:
```
proxy_cache_path /config/nginx/cache levels=1:2 keys_zone=STATIC:10m inactive=24h max_size=1g;
```
This part goes in the location block of the proxy-confs to cache:



```nginx
proxy_buffering on;
proxy_cache STATIC;
proxy_cache_valid 200 1d;
proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
```

