#!/bin/bash
set -e
set -x


# Install git
yum install -y git

# Pull repo
git clone https://github.com/Vultour/homelab.git /tmp/homelab-install
cd /tmp/homelab-install

# Start installation
bash ./setup.sh
