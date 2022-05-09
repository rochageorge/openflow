#!/bin/bash

sudo snap install microk8s --classic --channel=1.21/stable
microk8s status
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube
