# Grow the boot volume of an oracle VM Ubuntu instance

Backup current partition table

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

Resize file system now:

``` sh
resize2fs /dev/sdb1
```

See the change now:

``` sh
df -h
```
