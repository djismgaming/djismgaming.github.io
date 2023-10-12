# add container to additional network on unRAID

Edit the container on advanced view.

Under "Post Arguments" enter/add the following command:

`&& docker network connect <networkname> <containername>`

The custom docker network needs to be created first with `docker network create <networkname>` and unRAID docker options set to "Preserve user defined networks" as enabled.
