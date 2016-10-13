#!/bin/bash
set -e
set -x

# ==========
# LIBVIRT INIT
# ==========
yum install -y libvirt qemu-kvm qemu-kvm-tools qemu-kvm-common virt-install

systemctl enable libvirtd
systemctl start libvirtd

mkdir -p /var/lib/tftpboot
