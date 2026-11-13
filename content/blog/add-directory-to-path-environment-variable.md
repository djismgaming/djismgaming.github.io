---
title: add directory to PATH environment variable
date: 2023-10-12
description: 'Bash command to add the directory /home/<user>/.local/bin to PATH so executables installed there, such as ffmpeg-normalize from pip3, can be executed directly.'
tags:
- commands
---

``` bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> .bashrc
```
