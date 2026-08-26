---
title: Mount an SMB share and use iGPU on an unprivileged Debian 12 LXC container
  in Proxmox
date: 2024-02-08
tags:
- linux
- proxmox
- smb
- nas
---

## Procedure

Prerequisites:

Create an unprivileged Debian 12 LXC container.

Inside the LXC container, use the `root` user to create a non-root user. In this example the user is added to the `sudo` and `docker` groups after installing Docker inside the LXC container.
``` bash
useradd -s /bin/bash -m -G sudo,docker ismael
```

Change the user password as needed.

``` bash
su ismael
passwd
```

This user's default `UID:GID` will be `1000:1000`. If not, create it with:

``` bash
useradd ismael -u 1000 -g 1000 -m -s /bin/bash -G sudo,docker
```

Take note of this `UID:GID` as it will be used to map the share in Proxmox. The share itself can live on another system; here an unRAID VM on the same host is used.

### SMB share

#### On the Proxmox host

Create a user that can be mapped from the host to the LXC container. Without this step, the share ends up read-only inside the LXC container.

Proxmox maps the users and groups from the host to the LXC containers starting at `UID:GID`=`100000:100000`.

The created `ismael` user then:

- Inside the LXC container UID: _1000_
- Inside the host UID: _101000_

Create a group on the host with GID=101000 that will own the directory created for the SMB share

``` bash
groupadd -g 101000 ismael
```

Create the same user that will be used inside the LXC container but with the right `UID:GID` combination

``` bash
useradd ismael -u 101000 -g 101000 -m -s /bin/bash
```

Make a directory for the share

``` bash
mkdir /mnt/media
```

Change the directory's owner to the previously created user

``` bash
chown ismael:ismael /mnt/media
```

Modify the `/etc/fstab` file to mount the SMB share on the directory we created

``` bash
nano /etc/fstab
```

Copy this line inside the nano editor for `/etc/fstab` (note the `guest` part, as this SMB share has no password set)

``` bash
//192.168.0.10/media /mnt/media cifs guest,rw,uid=1000,gid=1000,file_mode=0777,dir_mode=0777 0 0
```

For shares that require a password:

``` bash
//192.168.0.10/media /mnt/media cifs username=<username>,password=<password>,rw,uid=1000,gid=1000,file_mode=0777,dir_mode=0777 0 0
```

Reload the changes to /etc/fstab before mounting

``` bash
systemctl daemon-reload
mount -a
```

Create a mountpoint in your LXC container pointing to the created share directory

``` bash
pct set 104 -mp0 /mnt/media,mp=/mnt/user/media
```

Start the LXC container and the share is mounted in `/mnt/user/media`, writable by the mapped user.

### iGPU

Coming soon...
