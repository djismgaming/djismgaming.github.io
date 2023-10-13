---
description: >-
  Bash script for Ubuntu (and derivatives as LinuxMint) to easily (un)install
  kernels from the Ubuntu Kernel PPA
  (http://kernel.ubuntu.com/~kernel-ppa/mainline/)
---

# ubuntu kernel upgrade

### Install

```
apt install wget
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
chmod +x ubuntu-mainline-kernel.sh
sudo mv ubuntu-mainline-kernel.sh /usr/local/bin/
```

If you want to automatically check for a new kernel version when you login:

```
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/UbuntuMainlineKernel.desktop
mv UbuntuMainlineKernel.desktop ~/.config/autostart/
```

###

\
