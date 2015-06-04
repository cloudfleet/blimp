#!/bin/bash
echo "========================================"
echo " Upgrading blimp ..."
echo "========================================"

T="$(date +%s)"
(cd `dirname $0` && ./update-images.sh && ./stop-containers.sh && ./start-containers.sh)
T="$(($(date +%s)-T))"

echo "========================================"
echo " Upgrade and restart took ${T} seconds."
echo "========================================"

