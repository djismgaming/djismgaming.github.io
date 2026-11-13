---
title: Delete the local-lvm directory from proxmox and resize the local to get the complete disk space
date: 2023-12-01
description: 'Remove the local-lvm storage from Proxmox and expand the local volume to use the full disk space.'
tags:
- commands
---

> **Note**
>
> You'll need to move all disks, isos, etc. from the `local-lvm` storage to the `local` storage before performing these steps.

1. Delete local-lvm from CLI:

``` bash
lvremove /dev/pve/data
```

2. Reallocate the space:

``` bash
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root
```
