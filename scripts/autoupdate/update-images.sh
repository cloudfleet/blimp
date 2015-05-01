#!/bin/bash
DOCKER_REGISTRY=registry.marina.io
docker pull $DOCKER_REGISTRY/cloudfleet/blimp-cockpit
docker pull $DOCKER_REGISTRY/cloudfleet/blimp-mailbox
docker pull $DOCKER_REGISTRY/cloudfleet/blimp-musterroll
docker pull $DOCKER_REGISTRY/cloudfleet/blimp-mailpile
docker pull $DOCKER_REGISTRY/cloudfleet/blimp-wellknown
docker pull $DOCKER_REGISTRY/cloudfleet/blimp-radicale
