# Delete the local-lvm directory from proxmox and resize the local to get the complete disk space

!!! note

    You'll need to move all disks, isos, etc. from this local-lvm storage to the local before performing these steps.

1. Delete local-lvm from CLI:

``` bash
lvremove /dev/pve/data
```

1. Reallocate the space

``` bash
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root
```
