#!/bin/bash
set -e
set -x


# ==========
# LIBVIRT TLS CERTIFICATE SETUP
# ==========
TLS_HOSTNAME='labrt.local'
CA_KEY='/root/tls-ca-privatekey.pem'
CA_CERT='/etc/pki/CA/cacert.pem'
CA_TEMPLATE='/tmp/ca.info'
SERVER_TEMPLATE='/tmp/server.info'
CLIENT_TEMPLATE='/tmp/client.info'
LIBVIRT_SERVERKEY='/etc/pki/libvirt/private/serverkey.pem'
LIBVIRT_SERVERCERT='/etc/pki/libvirt/servercert.pem'
LIBVIRT_CLIENTKEY='/etc/pki/libvirt/private/clientkey.pem'
LIBVIRT_CLIENTCERT='/etc/pki/libvirt/clientcert.pem'

mkdir -p $(dirname "$CA_CERT")
mkdir -p $(dirname "$LIBVIRT_SERVERKEY")


# Certificate authority
certtool --generate-privkey > $CA_KEY

cat <<EOF > $CA_TEMPLATE
cn = $TLS_HOSTNAME
ca
cert_signing_key
EOF

certtool \
    --generate-self-signed \
    --load-privkey $CA_KEY \
    --template $CA_TEMPLATE\
    --outfile $CA_CERT


# Server certificate
certtool --generate-privkey > $LIBVIRT_SERVERKEY

cat <<EOF > $SERVER_TEMPLATE
organization = Lab Inc
cn = $TLS_HOSTNAME
tls_www_server
encryption_key
signing_key
EOF

certtool \
    --generate-certificate \
    --load-privkey $LIBVIRT_SERVERKEY \
    --load-ca-certificate $CA_CERT \
    --load-ca-privkey $CA_KEY \
    --template $SERVER_TEMPLATE \
    --outfile $LIBVIRT_SERVERCERT


# Client certificate
certtool --generate-privkey > $LIBVIRT_CLIENTKEY

cat <<EOF > $CLIENT_TEMPLATE
country = GB
state = London
locality = London
organization = Red Hat
cn = $HOSTNAME
tls_www_client
encryption_key
signing_key
EOF

certtool \
    --generate-certificate \
    --load-privkey $LIBVIRT_CLIENTKEY \
    --load-ca-certificate $CA_CERT \
    --load-ca-privkey $CA_KEY \
    --template $CLIENT_TEMPLATE \
    --outfile $LIBVIRT_CLIENTCERT


# Cleanup
shred -zun 25 $CA_TEMPLATE
shred -zun 25 $SERVER_TEMPLATE
shred -zun 25 $CLIENT_TEMPLATE


# Enable TLS connections in libvirt
echo "" >> /etc/sysconfig/libvirt
echo "LIBVIRTD_ARGS='--listen'" >> /etc/sysconfig/libvirtd

systemctl restart libvirtd
