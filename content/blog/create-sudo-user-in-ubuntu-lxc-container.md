---
title: create sudo user with access to docker in ubuntu lxc container
date: 2023-10-12
description: 'Create a sudo-enabled user with access to Docker in an Ubuntu LXC container.'
tags:
- commands
---

``` bash
useradd -s /bin/bash -m -G sudo,docker username
```

Alternatively:

``` bash
adduser username
adduser username sudo
adduser username docker
```
