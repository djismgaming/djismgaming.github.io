# create sudo user with access to docker in ubuntu lxc container

``` bash
useradd -s /bin/bash -m -G sudo,docker username
```

or alternatively

``` bash
adduser username
adduser username sudo
adduser username docker
```
