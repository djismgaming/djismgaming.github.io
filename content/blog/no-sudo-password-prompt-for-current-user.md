---
title: no sudo password prompt for current user
date: 2023-10-12
description: Grant the current user passwordless sudo by writing a drop-in sudoers file named after the $USER environment variable.
tags:
- commands
---

This makes it possible for the current user to execute all sudo commands without a password prompt. The user is added to the sudoers file via the $USER environment variable in the command.

``` bash
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-$USER-for-sudo-password
```
