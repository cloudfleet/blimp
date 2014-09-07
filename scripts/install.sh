#!/bin/bash

sudo apt-get update
sudo apt-get install -y ansible python-apt

(cd scripts/ansible && ansible-playbook blimp.yml)

