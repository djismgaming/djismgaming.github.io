---
title: Set up your SSH key-based authentication from Windows in a single line
date: '2023-10-18'
tags:
- linux
- windows
- ssh
---

Linux-to-Linux SSH setups are straightforward, but the Windows OpenSSH client needs a different approach to copy a generated key for password-less logins.

## Generate your private and public keys in your Windows PowerShell shell

Execute the command below in Windows Terminal or any other terminal in Windows:

``` bash
ssh-keygen
```

This generates the keys in the local host's Windows profile directory under the `.ssh/` sub-directory.

You can access it in this location on Windows by using the key combination `Win + R` and then entering this text in the Run window:

```bash
%userprofile%/.ssh/
```

That directory will include:
- your generated private key `id_rsa`
- your generated public key `id_rsa.pub`

The public key is the one we'll copy into any remote host we want to connect without using a password.

## Copy the public key with a single line

The command below performs the equivalent of `ssh-copy-id` using the OpenSSH client on Windows. Edit `user@host.address` with the remote user and host IP/hostname.

``` bash
type .ssh\id_rsa.pub | ssh user@host.address "mkdir -p .ssh && cat >> .ssh/authorized_keys"
```

This makes it possible to login directly to your remote host by simply using:

``` bash
ssh user@host
```

Password-less login is now available:
