#!/bin/bash
set -e
set -x


# ==========
# FOREMAN SETUP
# ==========
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install epel-release https://yum.theforeman.org/releases/1.12/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer

foreman-installer \
  --foreman-admin-password password \
  --foreman-unattended true \
  --foreman-cli-password password

yum -y install foreman-libvirt

/opt/puppetlabs/bin/puppet agent --test
