#!/bin/bash
set -e
set -x


# ==========
# INITIAL SETUP
# ==========
echo "127.0.0.1   labrt.local puppet" >> /etc/hosts

yum update -y
yum install -y vim

systemctl stop NetworkManager
systemctl disable NetworkManager

systemctl start network
systemctl enable network

yum remove -y NetworkManager
