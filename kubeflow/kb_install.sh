#!/bin/bash

sudo snap install microk8s --classic --channel=1.21/stable
sudo usermod -a -G microk8s $USER
newgrp microk8s
sudo chown -f -R $USER ~/.kube
microk8s enable dns storage ingress metallb:10.64.140.43-10.64.140.49
microk8s status --wait-ready
sudo snap install juju --classic
juju bootstrap microk8s
juju deploy kubeflow-lite --trust
juju config dex-auth public-url=http://10.64.140.43.nip.io
juju config oidc-gatekeeper public-url=http://10.64.140.43.nip.io
juju config dex-auth static-username=admin
juju config dex-auth static-password=admin

