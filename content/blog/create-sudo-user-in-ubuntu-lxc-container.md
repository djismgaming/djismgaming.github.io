---
title: create sudo user with access to docker in ubuntu lxc container
date: 2023-10-12
description: or alternatively
tags:
- commands
---

# create sudo user with access to docker in ubuntu lxc container

``` bash
useradd -s /bin/bash -m -G sudo,docker username
```

or alternatively

``` bash
adduser username
adduser username sudo
adduser username docker
```
