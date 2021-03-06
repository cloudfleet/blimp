#!/bin/bash

start_arm(){
    echo "start on ARM"
    #scripts/build_docker_images.sh scripts/docker_images.txt /root/docker_images
    # when marina starts working instead do:
    scripts/autoupdate/update-images.sh

    (cd scripts/ansible && \
        ansible-playbook blimp-start.yml --skip-tags=skip-physical-blimp)
}

start_not_arm(){
    echo "start on non-ARM"
    (cd scripts/ansible && ansible-playbook blimp-start.yml)
    /bin/bash
}


# check for ARM
if hash dpkg 2>/dev/null; then # if dpkg available
    if [ "`dpkg --print-architecture`" = "armhf" ]; then
        start_arm
    else
        start_not_arm
    fi
else
    start_not_arm
fi
