#!/usr/bin/env bash

# A bridge is a piece of software used to unite two or more network segments. A bridge behaves
# like a virtual network switch, working transparently (the other machines do not need to know
# about its existence). Any real devices (e.g. eth0) and virtual devices (e.g. tap0) can be
# connected to it. 

# br0 stands for qemu recipes bridge 0
ip link add br0 type bridge
ip address add dev br0 192.168.100.1/24

# eth0 is the internet connected device
# Adding the interface into the bridge is done by setting its master to bridge_name.
ip link set eth0 master br0

# Tap interfaces are just virtual interfaces we will connect to our virtual switch (br0).
# Our virtual machines will see them as real interfaces.
ip tuntap add dev tap1 mode tap
ip link set tap1 master br0

ip tuntap add dev tap2 mode tap
ip link set tap2 master br0

# Bring it up
ip link set tap1 up
ip link set tap2 up
ip link set br0 up

# Enable routing on the firewall
echo 1 > /proc/sys/net/ipv4/ip_forward

# UFW
# Edit /etc/defaults/ufw and change DEFAULT_FORWARD_POLICY="ACCEPT"
#ufw route allow in on br0 out on anywhere
#ufw route allow in on anywhere out on br0

# iptables
#iptables -t nat -A POSTROUTING -o br0 -j MASQUERADE

# firewalld
#firewall-cmd --add-masquerade --permanent

# To undo the network setup
#ip link set eth0 nomaster
#ip link delete br0 type bridge
#ip link delete tap1
#ip link delete tap2

# Then undo any firewall configuration

# References:
# RedHat docs https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#bridge
# ArchWiki https://wiki.archlinux.org/title/Network_bridge
# What are Tap devices: https://cloudbuilder.in/blogs/2013/12/08/tap-interfaces-linux-bridge/
# UFW Nat https://askubuntu.com/questions/161346/how-to-configure-ufw-to-allow-ip-forwarding
# Firewalld and iptables: https://ahelpme.com/linux/howto-do-qemu-full-virtualization-with-bridged-networking/
