#!/bin/bash
scripts/wrapdocker.sh
(cd scripts/ansible && ansible-playbook blimp-start.yml)
/bin/bash

