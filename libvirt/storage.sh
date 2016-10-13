#!/bin/bash
set -e
set -x


# ==========
# LIBVIRT STORAGE SETUP
# ==========
mkdir -p /opt/virt/machines

cat <<EOF > /root/default-storage-pool.xml
<pool type='dir'>
  <name>machines</name>
  <target>
    <path>/opt/virt/machines</path>
  </target>
</pool>
EOF

virsh pool-define /root/default-storage-pool.xml
virsh pool-autostart machines
virsh pool-start machines
