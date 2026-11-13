---
title: Fixing the GOG Galaxy 2.0 Ubisoft Connect Plugin Connection
date: 2024-12-13
description: 'Fix the GOG Galaxy 2.0 Ubisoft Connect plugin dropping back to a disconnected state seconds after you sign in to your Ubisoft Connect account.'
tags:
- gaming
- development
- python
- connectivity
- troubleshooting
---

## The Issue: The \"Ghost\" Disconnection
When you connect the GOG Galaxy client to Ubisoft Connect, it often drops back into a disconnected state just seconds after you sign in. This is incredibly frustrating, as it prevents you from syncing your library or launching games seamlessly.

This issue typically occurs because the plugin is attempting to authenticate using outdated or incorrect credentials in its internal configuration files, causing the connection to fail as soon as the handshake is completed.

## The Solution: Manual Credential Sync
Since this is currently an open issue in the official repository, we have to manually \"force\" the plugin to recognize your account by updating its internal constants.

> **Warning**
>
> This method involves modifying a local configuration file. Because Ubisoft frequently updates their backend, this fix may need to be re-applied if they change their internal `appId` or `genomeId`.

### Step-by-Step Fix

#### Step 1: Capture the Session IDs
1.  Click the **Connect** button in the Ubisoft Connect integration settings in GOG Galaxy.
2.  When the Ubisoft login screen appears, look at the URL in your browser.
3.  Identify and copy the following two values from the URL:
    *   `appId` (Example: `f35adcb5-...`)
    *   `genomeId` (Example: `5b36b900-...`)

![Ubisoft login screen](ubisoft-connect-login.png)
/// caption
Image showing the necessary values to copy from the login URL

#### Step 2: Modify the Plugin Constants
We need to update the `consts.py` file within the GOG Galaxy plugin folder.

1.  Navigate to the following path (Replace `uplay_afb5a69c-b2ee-4d58-b916-f4cd75d4999a` with your specific plugin folder ID if it differs):
    `%localappdata%\GOG.com\Galaxy\plugins\installed\uplay_afb5a69c-b2ee-4d58-b916-f4cd75d4999a\consts.py`

2.  **Pro Tip:** You can open this file directly from a PowerShell shell using VS Code with this command:
    ```powershell
    code %localappdata%\GOG.com\Galaxy\plugins\installed\uplay_afb5a69c-b2ee-4d58-b916-f4cd75d4999a\consts.py
    ```

3.  Find these lines in the file:
    ```python
    CLUB_APPID = "f35adcb5-1911-440c-b1c9-48fdc1701c68"
    CLUB_GENOME_ID = "5b36b900-65d8-47f3-93c8-86bdaa48ab50"
    ```
4.  Replace the values inside the quotes with the `appId` and `genomeId` you copied in Step 1.

5.  Save the file.

#### Step 3: Finalize Connection
Restart the GOG Galaxy client and attempt to log in again. The client should now remain connected successfully.

![GOG Galaxy Integration Settings](gog-galaxy-integrations-settings.png)
/// caption
Image showing a working connection to Ubisoft Connect after a successful file modification

### Why does this work?
The GOG Galaxy plugin acts as a bridge. By manually updating the `consts.py` file, you are providing the plugin with the correct \"handshake\" keys required by Ubisoft's current API. This bypasses the plugin's inability to dynamically update these credentials during the login flow.

## Summary of Changes
| Change | Purpose |
| :--- | :--- |
| **URL Inspection** | Captures the live session keys from Ubisoft. |
| **consts.py Modification** | Injects those keys directly into the plugin's core logic. |
| **Result** | Bypasses the automatic disconnection loop. |
