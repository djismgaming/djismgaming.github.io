---
title: Grow the boot volume of an oracle VM Ubuntu instance
date: 2024-01-10
description: Grow the boot volume of an Oracle Cloud Ubuntu instance by expanding the partition and resizing the filesystem.
tags:
- commands
---

Back up the current partition table:

``` sh
sfdisk -d /dev/sdb > sdb_partition_bak.dmp
```

Execute a dry-run to see the changes that will apply. Install with `apt-get install cloud-utils` if you don't have it already.

``` sh
growpart -N /dev/sdb 1
```

If all looks good:

``` sh
growpart /dev/sdb 1
```

Resize the filesystem:

``` sh
resize2fs /dev/sdb1
```

Check the result:

``` sh
df -h
```
