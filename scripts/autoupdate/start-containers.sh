#!/bin/bash
(cd ../ansible && \
    ansible-playbook blimp-start-containers.yml --skip-tags=skip-physical-blimp)
