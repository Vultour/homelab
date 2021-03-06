#!/bin/bash
set -e
set -x


# ==========
# KUBERNETES SETUP
# ==========
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0

yum install -y docker kubelet kubeadm kubectl kubernetes-cni

systemctl enable docker
systemctl start docker

systemctl enable kubelet
systemctl start kubelet


# Start
kubeadm init --api-advertise-addresses=192.168.0.1
kubectl taint nodes --all dedicated-

echo "===================="
echo "| RUN THE 'kubeadm --join' COMMAND AND PRESS CTRL+D"
echo "===================="
bash

kubectl apply -f https://git.io/weave-kube
kubectl get pods --all-namespaces
