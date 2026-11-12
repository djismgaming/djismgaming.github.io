---
title: Extend the root volume in TurnKey Linux Nextcloud appliance VM
date: 2026-08-18
description: 'After adding an additional drive to the VM in Proxmox:'
tags:
- containers
- proxmox
- nextcloud
- commands
---

# Extend the root volume in TurnKey Linux Nextcloud appliance VM

After adding an additional drive to the VM in Proxmox:

> **Note**
>
> Change `/dev/sdb` on this post with the path to the disk you just added to the VM

```
pvcreate /dev/sdb
```

Extending the turnkey volume group by adding the physical volume `/dev/sdb`

```
vgextend turnkey /dev/sdb
```

Extending the root logical volume on the turnkey volume group

```
lvextend -l +100%FREE /dev/turnkey/root
```

Resizing the root filesystem

```
resize2fs /dev/turnkey/root
```

> **Note**
>
> All these changes are done while the system is running. No need to reboot.
