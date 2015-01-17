#!/bin/bash

start_arm(){
    echo "start on ARM"
    scripts/build_docker_images.sh scripts/docker_images.txt /root/docker_images
    (cd scripts/ansible && \
        ansible-playbook blimp-start.yml --skip-tags=docker-pull)
}

start_not_arm(){
    # TODO: do only for docker within docker (not for Vagrant)
    scripts/wrapdocker.sh
    echo "start on non-ARM"
    (cd scripts/ansible && ansible-playbook blimp-start.yml)
}


# check for ARM
if hash dpkg 2>/dev/null; then # if dpkg available
    if [ "`dpkg --print-installation-architecture`" = "arm" ]; then
        start_arm
    else
        start_not_arm
    fi
else
    start_not_arm
fi

/bin/bash
