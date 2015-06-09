#!/bin/bash
echo "=================================="
echo " Fetching new image versions ..."
echo "=================================="
DOCKER_REGISTRY=registry.marina.io
APPS="cockpit mailbox musterroll mailpile wellknown radicale nginx conduit pagekite"
for app in $APPS; do
  docker pull $DOCKER_REGISTRY/cloudfleet/blimp-$app | grep Status
done
echo "=================================="
echo " Fetched new image versions."
echo "=================================="
