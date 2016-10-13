#!/bin/bash
set -e
set -x


# ==========
# FOREMAN PROVISIONING SETUP
# ==========
mkdir -p /opt/virt/os/mnt

yum install -y vsftpd

cat <<EOF > /etc/vsftpd/vsftpd.conf
anonymous_enable=YES
local_enable=NO
write_enable=NO
anon_upload_enable=NO
anon_mkdir_write_enable=NO
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
xferlog_file=/var/log/vsftpd-xferlog
anon_root=/opt/virt/os/mnt
EOF

systemctl enable vsftpd
systemctl restart vsftpd


# CentOS 7 OS
mkdir -p /opt/virt/os/mnt/centos-7
wget -O /opt/virt/os/centos7.iso http://mirror.ox.ac.uk/sites/mirror.centos.org/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
echo "/opt/virt/os/centos7.iso /opt/virt/os/mnt/centos-7 iso9660 ro,fscontext=unconfined_u:object_r:usr_t:s0,relatime 0 0" >> /etc/fstab


# Mount all
mount -a
