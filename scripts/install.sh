#!/bin/bash

sudo apt-get update
sudo apt-get install -y ansible python-apt python-pycurl apt-transport-https python-pip iptables ca-certificates lxc
sudo pip install ansible --upgrade

(cd scripts/ansible && ansible-playbook blimp-install.yml)

