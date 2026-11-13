---
title: How to Connect a Docker Container to Multiple Networks on unRAID
date: 2023-10-12
description: Learn how to "multi-home" your containers by creating custom Docker networks and using "Post Arguments" to connect existing containers to additional networks.
tags:
- containers
- unraid
- docker
- networking
- security
---

### Introduction

By default, the unRAID Docker UI allows you to assign a container to exactly one network. However, Docker supports "multi-homing"—connecting a single container to multiple networks simultaneously. This guide shows you how to bypass the UI limitations to have the container connect and accessible via multiple docker networks.

### Prerequisites
Before you begin, you must ensure two things are configured correctly:

1.  **Create the Custom Network:** You must manually create the network via the terminal first.
    ```bash
    docker network create <networkname>
    ```
    *(Example: `docker network create app-backend`)*

2.  **Enable Persistence:** In unRAID, go to **Settings > Docker** and ensure that **"Preserve user defined networks"** is set to **Yes**. If this is not enabled, your custom network will disappear every time you reboot your server.

### Step-by-Step Instructions

#### Step 1: Edit the Container
Go to the **Docker** tab in unRAID, find the container you wish to modify (e.g., your Database or App server), click on it, and select **Edit**.

#### Step 2: Access the Advanced View
Scroll to the bottom of the page and click the **Advanced View** toggle. This will reveal additional configuration fields.

#### Step 3: Add the Post Argument
Locate the **Post Arguments** field. This field allows you to run a command automatically every time the container starts. 

Append the following command to the end of the existing arguments (or as a new line if the field is empty):

```bash
&& docker network connect <networkname> <containername>
```

**Note:** 
*   Replace `<networkname>` with the name of the network you created in the prerequisites.
*   Replace `<containername>` with the name of the container as it appears in unRAID.

#### Step 4: Apply and Verify
Click **Apply**. The container will restart. Once it comes back online, the "Post Argument" will have executed, joining the container to your second network.

**How to verify:**
You can verify the connection by running this command in the unRAID terminal:
```bash
docker network inspect <networkname>
```
Look for your container's name in the `Containers` list within the output.

### Summary Table
| Goal | Method | Result |
| :--- | :--- | :--- |
| **Default Setup** | UI Network Selection | Container is on 1 network. |
| **Multi-homing** | Post Arguments | Container is on 2+ networks. |
