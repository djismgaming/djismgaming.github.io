---
title: How to Extend the Root Volume in a TurnKey Linux Nextcloud Appliance VM
date: 2026-08-18
description: 'Learn how to safely expand your storage capacity by extending the root volume group and filesystem of a TurnKey Linux Nextcloud appliance VM after adding a new disk in Proxmox.'
tags:
- containers
- proxmox
- nextcloud
- commands
---

### Introduction
When your Nextcloud instance begins to run out of storage, the most efficient solution is often to expand the existing volume rather than moving data to a new one. This guide walks you through the process of adding a new physical disk in Proxmox and extending the root volume group and filesystem of your TurnKey Linux Nextcloud appliance.

### The "Why": Why Expand Instead of Reinstall?
*   **Data Preservation:** Expanding an existing volume keeps your data, users, and configurations intact.
*   **Performance:** By growing the existing root volume, you maintain the optimized filesystem structure that the appliance was built with.
*   **Simplicity:** It avoids the complex process of migrating a live Nextcloud database and file system to a new VM.

### Prerequisites
1.  **Proxmox Disk Addition:** You must first add a new virtual disk to your VM in the Proxmox web interface.
2.  **Identify the Disk:** Once added, the disk will appear as a new device (e.g., `/dev/sdb`). 
    > **Note**
    > Change `/dev/sdb` in this post to the path of the disk you just added to the VM.

### Step-by-Step Instructions

#### Step 1: Prepare the Physical Volume
First, we need to tell the Logical Volume Manager (LVM) that the new disk is available for use.
```bash
pvcreate /dev/sdb
```

#### Step 2: Extend the Volume Group
Next, we add the new physical volume to your existing volume group (which is named `turnkey` in this appliance).
```bash
vgextend turnkey /dev/sdb
```

#### Step 3: Extend the Logical Volume
Now that the volume group has more "free" space, we can allocate it to the root logical volume. This command tells LVM to use 100% of the newly available free space.
```bash
lvextend -l +100%FREE /dev/turnkey/root
```

#### Step 4: Resize the Filesystem
Finally, the underlying filesystem needs to be told that the volume it sits on has grown. This command expands the filesystem to fill the new space.
```bash
resize2fs /dev/turnkey/root
```

> **Note**
> All these changes are performed while the system is running. No reboot is required for the changes to take effect.

### Summary of Changes
| Action | Command | Purpose |
| :--- | :--- | :--- |
| **Initialize Disk** | `pvcreate` | Makes the new disk visible to LVM. |
| **Add to Group** | `vgextend` | Adds the disk's capacity to the pool. |
| **Grow Volume** | `lvextend` | Allocates the new pool capacity to the root. |
| **Resize FS** | `resize2fs` | Makes the extra space usable by the OS. |
