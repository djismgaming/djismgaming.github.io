---
title: Sending ntfy Notifications from unRAID via curl
date: 2024-10-28
description: Learn how to get real-time mobile alerts for your unRAID maintenance tasks by piping Docker outputs to ntfy using simple curl commands.
tags:
- ntfy
- unRAID
- Docker
- bash
- automation
---

### Overview
When managing an unRAID server, many maintenance tasks—like cleaning up dangling Docker images, clearing caches, or running backups—happen in the background. The problem is that unless you are sitting in front of a monitor watching a terminal, you have no way of knowing if these tasks succeeded, failed, or how long they took.

By combining `ntfy` (a simple, open-source notification service) with `curl`, you can turn your NAS into a proactive system that "pings" your phone or desktop the moment a task is complete.

### Why use ntfy and curl?
You might wonder why you shouldn't just use a more complex bot. The beauty of this specific stack lies in its simplicity:
1.  **No Setup:** `ntfy` doesn't require you to create an account or manage complex API tokens (unless you want a private topic).
2.  **Ubiquity:** `curl` is already on your unRAID system. You don't need to install new packages or manage Python/Node environments.
3.  **Simplicity:** You are essentially just "posting" a message to a URL.

### The Solution
Below is a production-ready script designed to prune dangling Docker images and send the final summary line to your notification topic.

```bash
#!/bin/bash

# --- Configuration ---
# Replace with your actual ntfy topic URL
# For a private topic, use: https://ntfy.example.com/your_topic
topicurl="https://ntfy.example.com/docker_alerts"

# --- Execution ---
# We capture the output of the prune command.
# 'tail -1' ensures we only send the summary line (e.g., "X images removed")
# rather than the entire list of IDs.
OUTPUT=$(docker image prune -af | tail -1)

# Send the notification
# --insecure is used if your ntfy instance uses a self-signed certificate
curl --insecure \
  -H "Title: Dangling images cleaned on $(hostname)" \
  -H "Tags: warning,docker" \
  -d "$OUTPUT" \
  "$topicurl"
```

### Breakdown of the Command
*   `docker image prune -af`: The `-a` flag removes all unused images, and `-f` forces the action without a confirmation prompt (essential for scripts).
*   `-H "Title: ..."`: This sets the bold header in your notification. Using `$(hostname)` ensures that if you have multiple servers, you know which one sent the alert.
*   `-H "Tags: ..."`: (Optional) `ntfy` supports tags which can be used to trigger specific notification sounds or icons on your phone.
*   `--insecure`: If you are hosting your own `ntfy` instance and haven't configured a valid CA certificate on unRAID, this prevents `curl` from failing due to SSL errors.

### Automation in unRAID
To make this truly useful, you shouldn't run this manually. 
1.  Install the **User Scripts** plugin from the Community Applications store.
2.  Create a new script and paste the code above.
3.  Set a **Cron Job** (e.g., `0 3 * * *` to run every night at 3 AM).

Now, you can sleep soundly knowing your server is maintaining itself, and you'll only be notified if something noteworthy happens.
