#!/bin/bash
scripts/wrapdocker.sh
# TODO for ARM:
# scripts/build_docker_images.sh scripts/docker_images.txt /root/docker_images
# ansible-playbook blimp-start.yml --skip-tags=docker-pull
(cd scripts/ansible && ansible-playbook blimp-start.yml)
/bin/bash
