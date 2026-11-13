---
title: ubuntu kernel upgrade
date: 2023-10-12
description: 'Bash script for Ubuntu and derivatives such as Linux Mint that makes it easy to install or uninstall kernels from the Ubuntu Kernel PPA (http://kernel.ubuntu.com/~kernel-ppa/mainline/).'
tags:
- commands
---

### Install

``` bash
apt install wget
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
chmod +x ubuntu-mainline-kernel.sh
sudo mv ubuntu-mainline-kernel.sh /usr/local/bin/
```

If you want to automatically check for a new kernel version when you log in:

``` bash
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/UbuntuMainlineKernel.desktop
mv UbuntuMainlineKernel.desktop ~/.config/autostart/
```
