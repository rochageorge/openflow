#!/bin/bash

sudo su
snap install microk8s --classic --channel=1.21/stable
microk8s status
usermod -a -G microk8s ubuntu
chown -f -R ubuntu ~/.kube

microk8s enable dns storage ingress metallb:10.64.140.43-10.64.140.49
alias kubectl='microk8s kubectl'
snap install juju --classic  --channel=2.9/stable
microk8s config > ~/.kube/config
juju add-k8s myk8s
juju bootstrap myk8s myctlr
juju add-model kubeflow
juju deploy kubeflow --trust

juju config dex-auth static-username=admin
juju config dex-auth static-password=mypassword

juju config dex-auth public-url=http://10.64.140.43.nip.io
juju config oidc-gatekeeper public-url=http://10.64.140.43.nip.io
