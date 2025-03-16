---
title: iGPU GVT-g Split Passthrough
description: Proxmox iGPU GVT-g split passthrough to VM configuration for hardware acceleration.
template: comments.html
tags: [proxmox, igpu, passthrough]
---

# iGPU GVT-g Split Passthrough (Intel Integrated Graphics)

Original post: https://3os.org/infrastructure/proxmox/gpu-passthrough/igpu-split-passthrough/

## Introduction

Intel Integrated Graphics (iGPU) is a GPU that is integrated into the CPU. The GPU is a part of the CPU and is used to render graphics. Proxmox may be configured to use iGPU split passthrough to VM to allow the VM to use the iGPU for hardware acceleration for example using video encoding/decoding and Transcoding for series like [Plex][plex-url], [Emby][emby-url] and [Jellyfin][jellyfin-url].  
This guide will show you how to configure Proxmox to use iGPU passthrough to VM.

!!! Warning ""

    **Your mileage may vary depending on your hardware. The following guide was tested with Intel Gen8 CPU.**

!!! Failure "Supported CPUs"

    `iGPU GVT-g Split Passthrough` is supported only on Intel's **5th generation to 10th generation** CPUs!

    Known supported CPU families:

    - **Broadwell**

    - **Skylake**

    - **Kaby Lake**

    - **Coffee Lake**

    - **Comet Lake**

There are two ways to use iGPU passthrough to VM. The first way is to use the `Full iGPU Passthrough` to VM. The second way is to use the `iGPU GVT-g` technology which allows as to split the iGPU into two parts. We will be covering the `Split iGPU Passthrough`. If you want to use the split `Full iGPU Passthrough` you can find the guide [here][igpu-full-passthrough-url].

## Proxmox Configuration for GVT-g Split Passthrough

The following examples uses `SSH` connection to the Proxmox server. The editor is `nano` but feel free to use any other editor.
We will be editing the `grub` configuration file.

Edit the `grub` configuration file.

```shell
nano /etc/default/grub
```

Find the line that starts with `GRUB_CMDLINE_LINUX_DEFAULT` by default they should look like this:

```shell
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
```

We want to allow `passthrough` and `Blacklists` known graphics drivers to prevent proxmox from utilizing the iGPU.

Your `GRUB_CMDLINE_LINUX_DEFAULT` should look like this:

```shell
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on i915.enable_gvt=1 iommu=pt pcie_acs_override=downstream,multifunction video=efifb:off video=vesa:off vfio_iommu_type1.allow_unsafe_interrupts=1 kvm.ignore_msrs=1 modprobe.blacklist=radeon,nouveau,nvidia,nvidiafb,nvidia-gpu"
```

!!! Note

    This will blacklist most of the graphics drivers from proxmox. If you have a specific driver you need to use for Proxmox Host you need to remove it from `modprobe.blacklist`

Save and exit the editor.

Update the grub configuration to apply the changes the next time the system boots.

```shell
update-grub
```

Next we need to add `vfio` modules to allow PCI passthrough.

Edit the `/etc/modules` file.

```shell
nano /etc/modules
```

Add the following line to the end of the file:

```shell
# Modules required for PCI passthrough
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd

# Modules required for Intel GVT-g Split
kvmgt
```

Save and exit the editor.

Update configuration changes made in your /etc filesystem

```shell
update-initramfs -u -k all
```

**Reboot Proxmox to apply the changes**

Verify that IOMMU is enabled

```shell
dmesg | grep -e DMAR -e IOMMU
```

There should be a line that looks like `DMAR: IOMMU enabled`. If there is no output, something is wrong.

```shell hl_lines="2"
[0.000000] Warning: PCIe ACS overrides enabled; This may allow non-IOMMU protected peer-to-peer DMA
[0.067203] DMAR: IOMMU enabled
[2.573920] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[2.580393] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[2.581776] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
```

## Windows Virtual Machine iGPU Passthrough Configuration

For better results its recommend to use this [Windows 10/11 Virtual Machine configuration for proxmox][windows-vm-configuration-url].

Find the PCI address of the iGPU.

```shell
lspci -nnv | grep VGA
```

This should result in output similar to this:

```shell
00:02.0 VGA compatible controller [0300]: Intel Corporation CometLake-S GT2 [UHD Graphics 630] [8086:3e92] (prog-if 00 [VGA controller])
```

If you have multiple VGA, look for the one that has the `Intel` in the name.

Here, the PCI address of the iGPU is `00:02.0`.

For best performance the VM should be configured the `Machine` type to ==q35==.  
This will allow the VM to utilize PCI-Express passthrough.

Open the web gui and navigate to the `Hardware` tab of the VM you want to add a vGPU.  
Click `Add` above the device list and then choose `PCI Device`

Open the `Device` dropdown and select the iGPU, which you can find using it’s PCI address. This list uses a different format for the PCI addresses id, `00:02.0` is listed as `0000:00:02.0`.

Click `Mdev Type`, You should be presented with a list of the available split passthrough devices choose the better performing one for the vm.

Select `ROM-Bar`, `PCI-Express` and then click `Add`.

The Windows Virtual Machine Proxmox Setting should look like this:

Power on the Windows Virtual Machine.

Open the VM's Console.
Install the latest version of [Intel's Graphics Driver][intel-gpu-drivers-url]{target=\_blank} or use the [Intel Driver & Support Assistant][intel-driver-and-support-assistant-url]{target=\_blank} installer.

If all when well you should see the following output in `Device Manager` and [GPU-Z][gpu-z-url]{target=\_blank}:

That's it! You should now be able to use the iGPU for hardware acceleration inside the VM and still have proxmox's output on the screen.

## Linux Virtual Machine iGPU Passthrough Configuration

We will be using Ubuntu Server 20.04 LTS for this guide.

From Proxmox Terminal find the PCI address of the iGPU.

```shell
lspci -nnv | grep VGA
```

This should result in output similar to this:

```shell
00:02.0 VGA compatible controller [0300]: Intel Corporation CometLake-S GT2 [UHD Graphics 630] [8086:3e92] (prog-if 00 [VGA controller])
```

If you have multiple VGA, look for the one that has the `Intel` in the name.

![Proxmox lspci vga][proxmox-lspci-vga-img]

Here, the PCI address of the iGPU is `00:02.0`.

VM should be configured the `Machine` type to ==i440fx==.  
Open the web gui and navigate to the `Hardware` tab of the VM you want to add a vGPU to.  
Click `Add` above the device list and then choose `PCI Device`

![Ubuntu VM Add PCI Device][ubuntu-vm-add-pci-device-img]

Open the `Device` dropdown and select the iGPU, which you can find using it’s PCI address. This list uses a different format for the PCI addresses id, `00:02.0` is listed as `0000:00:02.0`.

![Add iGPU MDev to VM][general-add-igpu-mdev-to-vm-img]

Click `Mdev Type`, You should be presented with a list of the available split passthrough devices choose the better performing one for the vm.

Select `ROM-Bar`, and then click `Add`.

The Ubuntu Virtual Machine Proxmox Setting should look like this:

Boot the VM. To test the iGPU passthrough was successful, you can use the following command:

```shell
 sudo lspci -nnv | grep VGA
```

The output should incliude the Intel iGPU:

```shell
00:10.0 VGA compatible controller [0300]: Intel Corporation UHD Graphics 630 (Desktop) [8086:3e92] (prog-if 00 [VGA controller])
```

Now we need to check if the GPU's Driver initalization is working.

```shell
cd /dev/dri && ls -la
```

The output should incliude the `renderD128`

That's it! You should now be able to use the iGPU for hardware acceleration inside the VM and still have proxmox's output on the screen.

## Debug

Dbug Messages - Shows Hardware initialization and errors

```shell
dmesg -w
```

Display PCI devices information

```shell
lspci
```

Display Driver in use for PCI devices

```shell
lspci -k
```

Display IOMMU Groups the PCI devices are assigned to

```shell
#!/bin/bash
shopt -s nullglob
for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;
```
