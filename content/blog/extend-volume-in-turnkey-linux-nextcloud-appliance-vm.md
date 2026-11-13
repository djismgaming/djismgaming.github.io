---
title: Extend the root volume in TurnKey Linux Nextcloud appliance VM
date: 2026-08-18
description: 'Extend the root volume group and filesystem of a TurnKey Linux Nextcloud appliance VM after adding a new disk in Proxmox.'
tags:
- containers
- proxmox
- nextcloud
- commands
---

After adding an additional drive to the VM in Proxmox:

> **Note**
>
> Change `/dev/sdb` in this post to the path of the disk you just added to the VM

```
pvcreate /dev/sdb
```

Extending the turnkey volume group by adding the physical volume `/dev/sdb`:

```
vgextend turnkey /dev/sdb
```

Extending the root logical volume on the turnkey volume group:

```
lvextend -l +100%FREE /dev/turnkey/root
```

Resizing the root filesystem:

```
resize2fs /dev/turnkey/root
```

> **Note**
>
> All these changes are done while the system is running. No need to reboot.
