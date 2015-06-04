#!/bin/bash
echo "=============================="
echo "  Starting containers ... "
echo "=============================="
(cd ../ansible && ansible-playbook blimp-start-containers.yml --skip-tags=skip-physical-blimp | grep -A 3 "PLAY RECAP")
echo "=============================="
echo "  Started containers. "
echo "=============================="
