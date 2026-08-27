---
title: SSH tunneling for access to web-based apps on servers
date: 2023-10-13
tags:
- linux
---

SSH local port forwarding exposes a web UI from a remote server on the local machine. This is useful for tools such as Portainer running on a cloud VM.

Run this command on the local machine:

``` bash
ssh -L 9000:127.0.0.1:9000 my_user@my-remote-server
```

This forwards the remote port 9000 to the local machine:

http://localhost:9000 or http://127.0.0.1:9000

At this local address, the Portainer web UI from the remote server is available.
