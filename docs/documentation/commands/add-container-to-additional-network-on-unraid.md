---
tags:
  - containers
  - unraid
---

# add container to additional network on unRAID

The custom docker network needs to be created first with `docker network create <networkname>` and unRAID docker options set to "Preserve user defined networks" as enabled.

Edit the container on advanced view.
Under "Post Arguments" enter/add the following command:

`&& docker network connect <networkname> <containername>`
