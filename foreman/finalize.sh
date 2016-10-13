#!/bin/bash
set -e
set -x


# ==========
# FOREMAN FINALIZATION
# ==========
systemctl restart foreman
systemctl restart foreman-proxy
systemctl restart httpd
