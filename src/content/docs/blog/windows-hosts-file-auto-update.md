---
title: Auto-update the Windows hosts file with a hosted list
date: 2025-01-06
tags:
- windows
---

## Why do this

There are many reasons to do this, or to use an application like the one shared here. For example, an application that phones home may need testing for its behavior when it loses connection with an URL, or a system needs to be kept from accessing unsecure sites/services online.

## Where to get hostctl from

hostctl's GitHub page: https://github.com/guumaster/hostctl

## How to use hostctl
Here is a simple example to use this app to update the hosts file with a hosted list on a specific URL.

!!! info inline end "Remember"
	This application works in multiple OSs. I'm just showing how to use it on Windows as an example.

Domains list Example URL: https://listwebsite.local/list.txt

1. Put the executable in a directory covered by your PATH variable.
2. Execute something like the following

``` pwsh
hostctl add <myprofilename> -f https://listwebsite.local/list.txt
```

3. The executable will create a profile called `myprofilename` inside the hosts file. That is to keep additions separate from the default/manually entered ones already in the hosts file.

This application can be used to perform backups and restores of the hosts file too. More about it can be found in the documentation at: https://guumaster.github.io/hostctl/
