---
tags:
  - containers
  - proxmox
  - nextcloud
---

# Extend the root volume in TurnKey Linux Nextcloud appliance VM

After adding an additional drive to the VM in Proxmox:

!!! note

    Change `/dev/sdb` on this post with the path to the disk you just added to the VM

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

!!! note
	All these changes are done while the system is running. No need to reboot.