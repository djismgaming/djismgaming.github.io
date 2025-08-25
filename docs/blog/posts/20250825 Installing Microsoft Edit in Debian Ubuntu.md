---
title: Installing Microsoft Edit in Debian or Ubuntu based distros
draft: false
date: 2025-08-25
weight:
tags:
  - development
  - git
  - linux
showToc: true
---

???+ note
	The current version of Edit (1,2,0) is not available via the package manager `apt` yet. This could change at some point in the future, making for an easier deployment.

## Install Pre-requisites

zstd - to decompress the downloaded file

```bash
sudo apt install zstd
```

## Install the latest Edit version from GitHub for x86_64

```bash
EDIT_VERSION=$(curl -s "https://api.github.com/repos/microsoft/edit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
wget -qO edit.tar.zst https://github.com/microsoft/edit/releases/latest/download/edit-$EDIT_VERSION-x86_64-linux-gnu.tar.zst
sudo tar xf edit.tar.zst -C /usr/local/bin edit
edit --version
rm -rf edit.tar.zst
```

This can easily be made into a script for multiple installations.
