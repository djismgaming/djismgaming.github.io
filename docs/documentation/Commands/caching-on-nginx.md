---
description: For linuxserver/nginx
---

# Caching on nginx

Caching config ([https://www.nginx.com/resources/wiki/start/topics/examples/reverseproxycachingexample/](https://www.nginx.com/resources/wiki/start/topics/examples/reverseproxycachingexample/))

This part goes into nginx.conf:

{% code overflow="wrap" %}
```
proxy_cache_path /config/nginx/cache levels=1:2 keys_zone=STATIC:10m inactive=24h max_size=1g;
```
{% endcode %}

This part goes in the location of the proxy-confs to cache:

<pre class="language-nginx" data-overflow="wrap"><code class="lang-nginx"><strong>proxy_buffering on;
</strong>proxy_cache STATIC;
proxy_cache_valid 200 1d;
proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
</code></pre>
