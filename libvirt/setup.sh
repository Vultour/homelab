#!/bin/bash
set -x
set -e

DIR=$(dirname "$0")


# Init
/bin/bash $DIR/init.sh

# Storage
/bin/bash $DIR/storage.sh

# Network
/bin/bash $DIR/network.sh

# TLS Certificates
/bin/bash $DIR/certs.sh
