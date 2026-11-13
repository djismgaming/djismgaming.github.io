---
title: iGPU GVT-g Split Passthrough
date: 2025-03-16
description: Configure Proxmox iGPU GVT-g split passthrough so a VM can use the host's integrated GPU for hardware acceleration.
tags:
- proxmox
- igpu
- passthrough
---

# iGPU GVT-g Split Passthrough (Intel Integrated Graphics)

Original guide: https://3os.org/infrastructure/proxmox/gpu-passthrough/igpu-split-passthrough/

## Introduction

Intel Integrated Graphics (iGPU) is the graphics engine built into the CPU, and it renders everything on screen. You can configure Proxmox to pass that iGPU through to a VM so the VM can use it for hardware acceleration — for example, for video encoding/decoding and transcoding in media servers such as [Plex][plex-url], [Emby][emby-url], and [Jellyfin][jellyfin-url]. This guide shows how to configure Proxmox for split iGPU passthrough to a VM.

> **Warning**
>
> **Your mileage may vary depending on your hardware. The following guide was tested with an Intel Gen8 CPU.**

> **Supported CPUs**
>
> `iGPU GVT-g Split Passthrough` is supported only on Intel's **5th generation to 10th generation** CPUs!
>
> Known supported CPU families:
>
> - **Broadwell**
>
> - **Skylake**
>
> - **Kaby Lake**
>
> - **Coffee Lake**
>
> - **Comet Lake**

There are two ways to pass an iGPU through to a VM. The first is full iGPU passthrough, which hands the whole iGPU to the VM. The second uses the iGPU GVT-g technology, which lets us split the iGPU into two parts so the host and the VM can share it. This guide covers the split iGPU passthrough. If you want full iGPU passthrough instead, you can find that guide [here][igpu-full-passthrough-url].

## Proxmox Configuration for GVT-g Split Passthrough

The following examples use an SSH connection to the Proxmox server and the `nano` editor, but feel free to use any other editor.

First, edit the `grub` configuration file:

```shell
nano /etc/default/grub
```

Find the line that starts with `GRUB_CMDLINE_LINUX_DEFAULT`. By default, it should look like this:

```shell
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
```

This enables passthrough and blacklists the known graphics drivers to stop Proxmox from using the iGPU itself.

Your `GRUB_CMDLINE_LINUX_DEFAULT` should look like this:

```shell
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on i915.enable_gvt=1 iommu=pt pcie_acs_override=downstream,multifunction video=efifb:off video=vesa:off vfio_iommu_type1.allow_unsafe_interrupts=1 kvm.ignore_msrs=1 modprobe.blacklist=radeon,nouveau,nvidia,nvidiafb,nvidia-gpu"
```

> **Note**
>
> This blacklists most graphics drivers for the Proxmox host. If you need a specific driver on the Proxmox host, remove it from `modprobe.blacklist`.

Save and exit the editor.

Update the GRUB configuration so the changes apply on the next boot:

```shell
update-grub
```

Next, add the `vfio` modules that enable PCI passthrough.

Edit the `/etc/modules` file.

```shell
nano /etc/modules
```

Add the following lines to the end of the file:

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

Rebuild the initramfs so the changes in `/etc` take effect on boot:

```shell
update-initramfs -u -k all
```

**Reboot Proxmox to apply the changes**

Verify that IOMMU is enabled:

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

For better results, we recommend using the [Windows 10/11 virtual machine configuration for Proxmox][windows-vm-configuration-url].

Find the PCI address of the iGPU:

```shell
lspci -nnv | grep VGA
```

The output should look similar to this:

```shell
00:02.0 VGA compatible controller [0300]: Intel Corporation CometLake-S GT2 [UHD Graphics 630] [8086:3e92] (prog-if 00 [VGA controller])
```

If you see several VGA entries, look for the one with `Intel` in its name.

Here, the PCI address of the iGPU is `00:02.0`.

For best performance, set the VM's `Machine` type to ==q35==. This lets the VM use PCI-Express passthrough.

Open the web GUI and navigate to the `Hardware` tab of the VM you want to add the vGPU to, then click `Add` above the device list and choose `PCI Device`:

Open the `Device` dropdown and select the iGPU, which you can find by its PCI address. This list uses a different format for PCI addresses: `00:02.0` is listed as `0000:00:02.0`.

Click `Mdev Type`. You should be presented with a list of the available split-passthrough devices — choose the best-performing one for the VM.

Select `ROM-Bar` and `PCI-Express`, then click `Add`.

The Windows VM's Proxmox settings should look like this:

Power on the Windows VM, then open its console and install the latest version of [Intel's graphics driver][intel-gpu-drivers-url]{target=\_blank}, or use the [Intel Driver & Support Assistant][intel-driver-and-support-assistant-url]{target=\_blank} installer.

If all goes well, you should see the output below in `Device Manager` and [GPU-Z][gpu-z-url]{target=\_blank}:

That's it! The VM can now use the iGPU for hardware acceleration, and Proxmox still outputs to the screen.

## Linux Virtual Machine iGPU Passthrough Configuration

We will be using Ubuntu Server 20.04 LTS for this guide.

From the Proxmox terminal, find the PCI address of the iGPU:

```shell
lspci -nnv | grep VGA
```

The output should look similar to this:

```shell
00:02.0 VGA compatible controller [0300]: Intel Corporation CometLake-S GT2 [UHD Graphics 630] [8086:3e92] (prog-if 00 [VGA controller])
```

If you see several VGA entries, look for the one with `Intel` in its name.

<!-- missing image (pre-existing): Proxmox lspci vga [proxmox-lspci-vga-img] -->

Here, the PCI address of the iGPU is `00:02.0`.

Configure the VM's `Machine` type as ==i440fx==.

Open the web GUI and navigate to the `Hardware` tab of the VM you want to add the vGPU to, then click `Add` above the device list and choose `PCI Device`:

<!-- missing image (pre-existing): Ubuntu VM Add PCI Device [ubuntu-vm-add-pci-device-img] -->

Open the `Device` dropdown and select the iGPU, which you can find by its PCI address. This list uses a different format for PCI addresses: `00:02.0` is listed as `0000:00:02.0`.

<!-- missing image (pre-existing): Add iGPU MDev to VM [general-add-igpu-mdev-to-vm-img] -->

Click `Mdev Type`. You should be presented with a list of the available split-passthrough devices — choose the best-performing one for the VM.

Select `ROM-Bar`, then click `Add`.

The Ubuntu VM's Proxmox settings should look like this:

Boot the VM, then check whether iGPU passthrough worked with the following command:

```shell
sudo lspci -nnv | grep VGA
```

The output should include the Intel iGPU:

```shell
00:10.0 VGA compatible controller [0300]: Intel Corporation UHD Graphics 630 (Desktop) [8086:3e92] (prog-if 00 [VGA controller])
```

Next, check that the GPU driver initialized correctly:

```shell
cd /dev/dri && ls -la
```

The output should include `renderD128`.

That's it! The VM can now use the iGPU for hardware acceleration, and Proxmox still outputs to the screen.

## Debug

Debug messages — show hardware initialization and errors

```shell
dmesg -w
```

Display PCI device information

```shell
lspci
```

Display the driver in use for PCI devices

```shell
lspci -k
```

Display the IOMMU groups the PCI devices are assigned to

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
