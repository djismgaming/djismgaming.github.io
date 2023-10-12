# specifying a static container IP on the same subnet of an UNRAID host



```yaml
// version: '3.3'
services:
    testcontainer:
        container_name: testcontainer
        environment:
            - TZ=America/Puerto_Rico
            - HOST_OS=Unraid
            - HOST_CONTAINERNAME=testcontainer
            - PUID=99
            - PGID=100
            - UMASK=022
        volumes:
            - '/mnt/user/appdata/nginx:/config:rw'
        image: lscr.io/linuxserver/nginx
        networks:
            dockernat:
                ipv4_address: 192.168.0.250

networks:
    dockernat:
        external: true
        name: br0
```
