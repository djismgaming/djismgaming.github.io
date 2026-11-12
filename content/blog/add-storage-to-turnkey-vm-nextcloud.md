---
title: Add storage to a Turnkey VM like Nextcloud
date: gitLastModified
description: Managing LVM on Proxmox
tags:
- vm
- turnkey
- lvm
- proxmox
- commands
---

# Add storage to a Turnkey VM like Nextcloud

Managing LVM on Proxmox

- Add additional disk to Turnkey VM in Proxmox
- find `/dev/sd*` for the new disk inside the VM

```bash
pvcreate /dev/sd*
```

```bash
vgextend turnkey /dev/sd*
```

```bash
vgdisplay
```

```bash
lvextend -l+100%free /dev/turnkey/root
```

```bash
resize2fs /dev/turnkey/root
```
