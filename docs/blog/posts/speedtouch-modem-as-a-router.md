---
title: speedtouch modem as a router
draft: false
date: 2023-10-13
tags:
  - linux
  - networking
  - hardware
  - hardware
  - hacking
  - routers
authors:
  - djismgaming
categories:
  - Linux
---


A speedtouch modem, like a 2007 model Thompson Speedtouch 585V6, is a DSL modem. But with a little tweak, it can be used as a router for your network.
<!-- more -->
Run these commands towards the SpeedTouch modem using `telnet`:

```bash
telnet <modem ip address>
```

Commands to set up a SpeedTouch DSL modem as a router:

For firmware versions 5.3 and lower:

```bash
ppp relay flush
ppp flush
eth flush
atm flush
atm phonebook flush
eth bridge ifdelete intf=ethport4
eth ifadd intf=ethport4
eth ifconfig intf=ethport4 dest=ethif4 retry=10 group=default
eth ifattach intf=ethport4
ip ifadd intf=WAN_Port dest=ethport4
ip ifconfig intf=WAN_Port hwaddr=00:11:42:0c:65:1d # This line is needed if MAC address cloning is required, otherwise it's not necessary
dhcp client ifadd intf=WAN_Port
dhcp client ifattach intf=WAN_Port
nat ifconfig intf=WAN_Port translation=enabled
nat ifattach intf=WAN_Port
saveall
```

For firmware versions 6.1 and higher:

``` bash
ppp relay flush
ppp flush
eth flush
atm flush
atm phonebook flush
eth bridge ifdelete intf=ethport4
eth ifadd intf=eth_wan
eth ifconfig intf=eth_wan dest=ethif4
eth ifattach intf=eth_wan
ip ifadd intf=ip_wan_eth dest=eth_wan
ip ifconfig intf=ip_wan_eth status=up
ip ifconfig intf=ip_wan_eth hwaddr=00:11:42:0c:65:1d # This line is needed if MAC address cloning is required, otherwise it's not necessary
ip ifattach intf=ip_wan_eth
nat ifconfig intf=ip_wan_eth translation=enabled
dhcp client ifadd intf=ip_wan_eth
dhcp client ifconfig intf=ip_wan_eth metric=5 dnsmetric=5
dhcp client rqoptions and intf=ip_wan_eth option=dhcp-lease-time
dhcp client rqoptions and intf=ip_wan_eth option=dhcp-renewal-time
dhcp client rqoptions and intf=ip_wan_eth option=dhcp-rebinding-time
dhcp client rqoptions and intf=ip_wan_eth option=subnet-mask
dhcp client rqoptions and intf=ip_wan_eth option=classless-static-routes
dhcp client rqoptions and intf=ip_wan_eth option=default-routers
dhcp client rqoptions and intf=ip_wan_eth option=classfull-static-routes
dhcp client rqoptions and intf=ip_wan_eth option=domain-name-servers
dhcp client ifattach intf=ip_wan_eth
saveall
```
