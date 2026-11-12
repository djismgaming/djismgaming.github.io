---
title: linux mitigation disable (debian)
date: gitLastModified
description: Add mitigations=off to the GRUB kernel command line on a Debian system, which disables all optional CPU vulnerability mitigations. Needs root and a reboot.
tags:
- commands
---

# linux mitigation disable (debian)

Adds `mitigations=off` to the kernel command line, which disables **all** optional CPU
mitigations (Spectre, Meltdown, and the other grouped fixes). Do this only on machines that
never run code you don't control — on a daily driver or shared system, leave them on.

1. Edit `/etc/default/grub` as root:

   ``` bash
   sudo nano /etc/default/grub
   ```

2. Append `mitigations=off` to the existing `GRUB_CMDLINE_LINUX_DEFAULT` value — don't
   replace the line, or you lose the distro's other defaults such as `quiet splash`:

   ``` bash
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mitigations=off"
   ```

   If your setup puts the options in `GRUB_CMDLINE_LINUX` instead, edit that one.

3. Regenerate the GRUB config, then reboot — the change does nothing until the next boot:

   ``` bash
   sudo update-grub
   sudo reboot
   ```

After rebooting, confirm the parameter is live:

``` bash
grep -o mitigations=off /proc/cmdline
```

If it is missing, the edit landed on the wrong variable, or something other than GRUB boots
this system (`update-grub` is a Debian wrapper; Arch and friends use `grub-mkconfig -o
/boot/grub/grub.cfg` instead).
