---
tags:
  - metrics
  - status
  - glances
  - cron
draft: false
---

# install glances and keep it running for showing gethomepage.dev system stats

Install pip:

```bash
sudo apt install python3-pip
```

Install glances with pip for this user:

```bash
pip install --user 'glances[web]'
```

Re source your `.profile` for the new executable for `glances` to be in your current environment:

```bash
source ~/.profile
```

Update the crontab to run glances at startup without web UI but able to share system metrics (no web UI to make it more efficient):

``` bash
# this goes on crontab
@reboot /home/ismael/.local/bin/glances -w --disable-webui
```

Reboot the server and glances should be running after this automatically on every reboot. Works great in an LXC container.

Create the `services.yaml` entry for gethomepage.dev to show server root usage stats:

???+ note
	There are a bunch of strings on this YAML that are customized to your liking. See https://gethomepage.dev/widgets/services/glances/ for the specifics on the Glances widget.

```yaml
...
- Docker:
    - mini-docker:
        icon: docker.png
        widgets: 
            - type: glances
              url: http://<IP of server>:61208
              version: 4 # main version of glances used
              metric: fs:/ # showing root usage
...
```

At the end it should look something like this:

![[Pasted image 20250504131242.png]]