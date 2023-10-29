---
draft: false
date: 2023-10-28
categories:
  # - Gaming
  # - unRAID
  # - Proxmox
tags:
  - linux
  - proxmox
  # - autohotkey
  # - windows
  # - gaming
  # - origin
  # - EA Desktop
authors:
  - ismael
---

# backup and restore a MariaDB or mySQL database with mysqldump

create a `.my.cnf` file in your `home` directory containing this data:

``` bash
[mysqldump]
user=mysqluser
password=secret
```

This will make it possible to script these backup operations in the future.

``` bash
mysqldump -h 127.0.0.1 -P 3306 wordpress_mmm > wordpress_mmm.sql
```

``` bash
mysqldump -h 127.0.0.1 -P 3306 wordpress_mmm > wordpress_mmm_$(date +%Y%m%d_%I_%M_%S_%p).sql
```
