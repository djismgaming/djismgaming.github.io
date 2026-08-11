---
title: "SSH Tunneling for easy access to web-based apps from servers"
date: 2023-10-13
draft: false
tags:
  - linux
  - ssh
showToc: true
---

I had to access Portainer in my cloud VM to modify docker containers. I can access it now via any web browser with SSL (https) no problem, but this way is good in a pinch.

Run this command in your local machine:

```bash
ssh -L 9000:127.0.0.1:9000 my_user@my-remote-server
```

This will forward port 9000 to our local machine:

http://localhost:9000 or http://127.0.0.1:9000

At this local address the Portainer web UI from the remote server will appear.

Nice and neat little SSH trick!