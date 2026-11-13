---
title: Add storage to a Turnkey VM like Nextcloud
date: 2025-04-30
description: 'Extend the LVM volume of a Turnkey VM in Proxmox with an additional disk.'
tags:
- vm
- turnkey
- lvm
- proxmox
- commands
---

- Add an additional disk to the Turnkey VM in Proxmox.
- Find `/dev/sd*` for the new disk inside the VM.

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
