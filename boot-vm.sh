#!/usr/bin/env bash

cmd=()

# Call qemu for the desired architecture.
cmd+=(qemu-system-x86_64)

# Specifies the disk image.
cmd+=(-drive file=disk.qcow2)

# Specifies th ISO file. Could also be /dev/cdrom.
cmd+=(-cdrom bootable.iso)

# Default is Megabytes, use G for gigabytes.
cmd+=(-m 4000)

# Number of cpus
cmd+=(-smp 4,cores=4)

# Intel AC'97 compatible sound card
cmd+=(-device AC97)

# Grapics cards, one of:
# cirrus - Simple graphics card. Every guest OS has a built-in driver.
# std - Support resolutions >= 1280x1024x16. Linux, Windows XP and newer guest have a built-in driver.
# vmware - VMware SVGA-II, more powerful graphics card. Install x11-drivers/xf86-video-vmware in Linux
#          guests, VMware Tools in Windows XP and newer guests.
# qxl - More powerful graphics card for use with SPICE.
cmd+=(-vga std)

# Bridged network
cmd+=(-net nic,model=virtio -net tap,ifname=tap1)

# A new device (vnet0) is created by QEMU on the host, the other end of the "cable" is at the VM.
# This is a virtual network between the host and guest.
# -device virtio-net,netdev=vmnic -netdev tap,id=vmnic,ifname=vnet0,script=no,downscript=no \

# Enables the USB bus on the emulated computer and attaches a USB tablet
# pointing device (absolute pointing devices usually allow for smoother/better
# user input than USB or PS/2 mice)
cmd+=(-usb -device usb-tablet)

# Enables KVM virtualization, to run as a normal user usermod -aG kvm username
cmd+=(-enable-kvm)

# c - Boot from the first hard drive
# d - Boot from the first cdrom
# n - Boot from the virtual network
cmd+=(-boot d)

"${cmd[@]}"

# References:
# Gentoo wiki - https://wiki.gentoo.org/wiki/QEMU/Options
# Qemu recipes: https://eaasi.gitlab.io/program_docs/qemu-qed/recipes/
