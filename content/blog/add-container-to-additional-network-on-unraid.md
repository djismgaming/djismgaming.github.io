---
title: add container to additional network on unRAID
date: 2023-10-12
description: Create the custom Docker network first with docker network create, then connect an existing container to it through its Post Arguments on unRAID.
tags:
- containers
- unraid
- commands
---

The custom docker network needs to be created first with `docker network create <networkname>`, and the unRAID Docker setting "Preserve user defined networks" must be enabled.

Edit the container in the advanced view.
Under "Post Arguments", append the following command:

``` bash
&& docker network connect <networkname> <containername>
```
