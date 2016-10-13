#!/bin/bash
set -x
set -e


# ==========
# LIBVIRT NETWORK SETUP
# ==========
virsh net-destroy default
virsh net-undefine default

systemctl restart network

cat <<EOF > /etc/libvirt/qemu/networks/default.xml
<network>
  <name>default</name>
  <uuid>2837a98f-1fca-ef21-a908-103afce736af</uuid>
  <forward mode='nat' />
  <bridge name='virbr0' stp='on' delay='0' />
  <mac address='DE:AD:BE:EF:00:00' />
  <ip address='192.168.0.1' netmask='255.255.255.0'>
    <tftp root='/var/lib/tftpboot' />
    <dhcp>
      <range start='192.168.0.50' end='192.168.0.100' />
      <bootp file='pxelinux.0' />
    </dhcp>
  </ip>
</network>
EOF

virsh net-define /etc/libvirt/qemu/networks/default.xml
virsh net-start default
virsh net-autostart default

systemctl restart network
