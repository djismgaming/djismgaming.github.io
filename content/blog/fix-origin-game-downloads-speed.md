---
title: Fix Your SLOW Origin Games Download Speeds – UPDATED
date: 2024-10-13
description: 'Work around slow Origin download speeds by enabling R&D mode with a custom EACore.ini file.'
tags:
- origin
- gaming
- archive
- performance
---

> **Deprecated** — Origin is deprecated at this point in time. This entry is kept for historical purposes only.

> **Update (2021-08-20)** — This is a non-issue anymore; EA Desktop with the Xbox Game Pass for PC replaced direct use of the Origin client.

## The Problem: Why are Origin speeds so slow?
Many users have reported frustratingly slow download speeds on the Origin client. Even with a high-speed gigabit connection, downloads often throttle to a fraction of the available bandwidth.

This is often caused by the way Origin handles Content Delivery Network (CDN) connections. Without specific configuration, the client may default to congested nodes or fail to maintain the optimal connection state, leading to sluggish performance during large game downloads.

## The Solution: Enabling R&D Mode
While there is no official \"fix\" button, a well-known workaround involves forcing the client into \"R&D Mode.\" This changes how the client interacts with the CDN and has been reported to significantly improve throughput.

### Prerequisites
*   **Note:** This guide is for users still maintaining older libraries or legacy installations. For new installs, use the EA Desktop app.
*   You will need to create a small configuration file on your desktop.

### Step-by-Step Instructions

#### Step 1: Create the Configuration File
1.  Exit the Origin client completely.
2.  Create a new empty text document on your desktop.
3.  Open the document and paste the following configuration:

```config
[connection]
EnvironmentName=production
 
[Feature]
CdnOverride=akamai
```

4.  Save the file exactly as `EACore.ini`.

#### Step 2: Import the Configuration
1.  Launch the Origin client.
2.  A prompt will appear asking if you want to import the `EACore.ini` file from your desktop.
3.  Click **Yes**. 
    *The client will automatically move this file to its internal configuration folder and delete the copy on your desktop.*

#### Step 3: Verify the Change
Once the client restarts, you should see **“R&D | PR”** appear in the upper right corner. This confirms that the R&D mode is active.

### Why does this work?
By setting `CdnOverride=akamai`, you are instructing the Origin client to prioritize the Akamai CDN. In many regions, Akamai provides more stable and higher-bandwidth routes for game data than the default paths, effectively bypassing the bottlenecks that cause sluggish downloads.

### Summary of Changes
| Configuration | Effect |
| :--- | :--- |
| `EnvironmentName=production` | Ensures the client operates in a stable production environment. |
| `CdnOverride=akamai` | Forces the use of the Akamai CDN for faster download paths. |
| **R&D Mode** | Changes the internal logic of the client to prioritize throughput. |
