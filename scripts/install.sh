#!/bin/bash

sudo apt-get update
sudo apt-get install -y ansible python-apt python-pycurl apt-transport-https python-pip iptables ca-certificates lxc git
sudo pip install ansible --upgrade
sudo pip install docker-py==1.1

install_arm(){
    echo "install on ARM"
    cd scripts/ansible
    ansible-playbook blimp-install.yml --skip-tags=skip-physical-blimp
}

install_not_arm(){
    echo "install on non-ARM"
    (cd scripts/ansible && ansible-playbook blimp-install.yml)
}

# check for ARM
if hash dpkg 2>/dev/null; then # if dpkg available
    if [ "`dpkg --print-architecture`" = "armhf" ]; then
        install_arm
    else
        install_not_arm
    fi
else
    install_not_arm
fi
