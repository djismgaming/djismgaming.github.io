---
description: >-
  This will make it possible for the current user (the user executing the
  command will be added to it via the environment variable $USER in the command)
  to execute all sudo commands without a prompt for
---

# no sudo password prompt for current user



`echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-$USER-for-sudo-password`
