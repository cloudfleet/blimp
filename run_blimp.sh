#! /bin/bash

sudo docker run --privileged -it \
  -e "CLOUDFLEET_DOMAIN=${1}.test.blimpyard.cloudfleet.io" \
  -e "CLOUDFLEET_SECRET=password" \
  -e "CLOUDFLEET_HOST=blimpyard.cloudfleet.io:443" \
  --name "blimp_${1}" \
  --hostname "blimp" \
  --rm=true \
  cloudfleet/blimp

