---
title: How to Run Glances as a Persistent Background Service for gethomepage.dev
date: 2025-05-04
description: A guide to installing `glances`, configuring it to run automatically on boot as a background daemon, and integrating it with your gethomepage.dev dashboard.
tags:
- metrics
- status
- glances
- cron
- home-server
---

### Introduction
If you are using [gethomepage.dev](https://gethomepage.dev) to monitor your home lab, you likely want a way to see real-time system vitals—like CPU usage, RAM consumption, and disk space—at a glance. 

`glances` is one of the most robust tools for this job. However, because it is primarily a CLI tool, it won't stay running after you close your terminal. To make it work with a dashboard, we need to turn it into a \"set and forget\" background service. This guide shows you how to do that efficiently, specifically optimized for low-resource environments like LXC containers.

### Step 1: Installation
We will use `pip` to install `glances`. Using `pip` over `apt` ensures you get the latest version, while the `--user` flag prevents permission conflicts with system-wide Python libraries.

First, ensure you have the Python package manager installed:
```bash
sudo apt update
sudo apt install python3-pip
```

Next, install `glances` with web support:
```bash
pip install --user 'glances[web]'
```

**Note:** To ensure your current shell recognizes the new executable, refresh your profile:
```bash
source ~/.profile
```

### Step 2: Making it Persistent (The \"Always-On\" Setup)
To provide data to your dashboard, `glances` must start automatically every time your server reboots. While many use `systemd`, a `cron` job is often simpler and lighter for containerized environments.

We will use a `@reboot` cron job. We also include the `--disable-webui` flag: this tells `glances` to keep the metrics engine running (which the dashboard needs) while skipping the heavy web interface, saving system resources.

1. Open your crontab editor:
   ```bash
   crontab -e
   ```
2. Add the following line to the bottom of the file (replace `ismael` with your actual username):
   ```bash
   @reboot /home/ismael/.local/bin/glances -w --disable-webui
   ```

*Tip: You can verify the path to your glances executable by running `which glances`.*

### Step 3: Integrating with gethomepage.dev
Now that `glances` is running in the background on port **61208**, you can pull those stats into your dashboard.

Edit your `services.yaml` to include the following entry. This example shows how to display the root filesystem usage:

> **Configuration Note**
> Some values in this YAML are specific to your environment. Refer to the [Glances Widget Documentation](https://gethomepage.dev/widgets/services/glances/) for customization options like specific metrics or version numbers.

```yaml
...
- Docker:
    - mini-docker:
        icon: docker.png
        widgets: 
            - type: glances
              url: http://<IP_OF_SERVER>:61208
              version: 4 # The version of glances currently installed
              metric: fs:/ # Displays root filesystem usage
...
```

### The Result
Once configured, your dashboard will now automatically poll your server's vitals, giving you a live, beautiful overview of your system's health without you having to manually start any services.

![mini-docker glances widget](mini-docker-glances-widget.png)
