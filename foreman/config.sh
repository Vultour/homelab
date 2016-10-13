#!/bin/bash
set -e
set -x


# ==========
# FOREMAN CONFIGURATION
# ==========
hammer settings set \
    --name unattended_url \
    --value "http://$(ip a | grep -E 'inet\s' | awk 'NR==2' | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]+' | grep -oE '^[^/]*')"

hammer subnet create \
    --boot-mode Static \
    --dns-primary 192.168.0.2 \
    --dns-secondary 8.8.8.8 \
    --gateway 192.168.0.1 \
    --mask 255.255.255.0 \
    --name labroot \
    --network 192.168.0.0 \
    --domains local

hammer compute-resource create \
    --description "LABRT-Libvirt"\
    --display-type VNC \
    --name LABRT-libvirt \
    --provider Libvirt \
    --set-console-password "" \
    --url "qemu://labrt.local/system"

hammer medium create \
    --name 'centos-7-local' \
    --os-family Redhat \
    --path ftp://$(ip a | grep -E 'inet\s' | awk 'NR==2' | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]+' | grep -oE '^[^/]*')/mnt/centos-7

hammer os create \
    --name centos-7 \
    --description "centos-7" \
    --major 7 \
    --family Redhat \
    --media "centos-7-local,CentOS mirror" \
    --partition-tables "Kickstart default" \
    --architectures x86_64 \
    --provisioning-templates "Kickstart default,Kickstart default finish,Kickstart default iPXE,Kickstart default PXELinux"

hammer hostgroup create \
    --architecture x86_64 \
    --ask-root-pass no \
    --domain local \
    --environment production \
    --medium "centos-7-local" \
    --name "LABRT-default-prod" \
    --operatingsystem "centos-7" \
    --partition-table "Kickstart default" \
    --puppet-ca-proxy labrt.local \
    --puppet-proxy labrt.local \
    --root-pass password \
    --subnet labroot
