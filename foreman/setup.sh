#!/bin/bash
set -x
set -e

DIR=$(dirname "$0")


# Init
/bin/bash $DIR/init.sh

# Provisioning
/bin/bash $DIR/provisioning.sh

# Config
/bin/bash $DIR/config.sh

# Smart proxy
/bin/bash $DIR/proxy.sh

# Finalize
/bin/bash $DIR/finalize.sh
