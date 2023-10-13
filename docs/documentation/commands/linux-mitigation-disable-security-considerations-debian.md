# linux mitigation disable (debian)

Edit `/etc/default/grub`

Line should say `GRUB_CMDLINE_LINUX_DEFAULT="mitigations=off"`

Then run command `update-grub`
