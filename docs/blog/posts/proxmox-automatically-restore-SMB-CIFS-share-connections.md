---
draft: false
date: 2024-01-10
categories:
  # - Gaming
  # - 
  - Proxmox
tags:
  - linux
  - proxmox
  # - autohotkey
  # - windows
  # - gaming
  # - origin
  # - EA Desktop
  - smb
  - nas
authors:
  - ismael
---

# Proxmox | automatically restore SMB/CIFS share connections

If at some point Proxmox loses connectivity with an SMB/CIFS share, it will not restore the connection by itself until a restart of the Proxmox node is performed.

With this tip, you’ll make the Proxmox node restore the connection automatically.
<!-- more -->
In your node’s shell, create a bash script that looks for mount points in `/mnt/pve/` and unmounts them if they become stale:

``` bash
nano remount.sh
```

Put this content into the file:

``` bash
#!/bin/bash
list=$(ls /mnt/pve)

for i in $list
do
        status=$(ls /mnt/pve/$i 2>&1)

        if [[ $status =~ .*Stale.* ]]
                then
                umount /mnt/pve/$i
        fi
done
```

Remember to make the script executable by the user creating it:

chmod 766 /root/remount.sh
Add a cron job for this script to run automatically:

``` bash
* * * * * /root/remount.sh >/dev/null 2>&1
```

With that, any SMB/CIFS connections should be restored automatically. That is because the service `pvestatd` tries to remount every SMB share every 10 seconds.

This approach could work for NFS shares too. I have not tested that possibility.
