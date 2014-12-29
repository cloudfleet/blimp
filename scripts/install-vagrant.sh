#! /bin/bash
export CLOUDFLEET_DOMAIN=$1
export CLOUDFLEET_SECRET=$2
export CLOUDFLEET_HOST=$3
set
(cd /vagrant && scripts/install.sh && scripts/start.sh)
