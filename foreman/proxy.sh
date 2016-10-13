#!/bin.bash
set -e
set -x


# ==========
# FOREMAN SMART PROXY
# ==========
cat <<EOF >> /etc/foreman-proxy/settings.yml
:tftp: true
:tftproot: /var/tftpboot
:tftp_servername: 192.168.0.1
:dns: true
:dns_provider: virsh
:dhcp: true
:dhcp_vendor: virsh
:virsh_network: default
EOF
