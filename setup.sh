#!/bin/bash
set -x
set -e

DIR=$(dirname "$0")


# INIT
/bin/bash $DIR/init.sh

# LIBVIRT
/bin/bash $DIR/libvirt/setup.sh

# FOREMAN
/bin/bash $DIR/foreman/setup.sh

# DOCKER
/bin/bash $DIR/docker/setup.sh
