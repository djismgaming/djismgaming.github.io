---
description: >-
  Bash shell command to add directory /home/<user>/.local/bin to the PATH so
  executables in that path can be executed directly (eg. ffmpeg-normalize
  installed via pip3 install ffmpeg-normalize
---

# add directory to PATH environment variable

`echo 'export PATH="$HOME/.local/bin:$PATH"' >> .bashrc`
