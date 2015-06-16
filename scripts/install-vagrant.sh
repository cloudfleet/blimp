#! /bin/bash
export CLOUDFLEET_DOMAIN=$1
export CLOUDFLEET_SECRET=$2

apt-get -y update && apt-get install python-pip wget
wget -qO- https://get.docker.com/ | sh

pip install meta-compose

echo <<EOF

CLOUDFLEET_DOMAIN=$CLOUDFLEET_DOMAIN
CLOUDFLEET_SECRET=$CLOUDFLEET_SECRET
CLOUDFLEET_REGISTRY=docker.io

EOF > /tmp/blimp-vars.sh

UPDATE_CRONTAB="0 4 * * * /opt/cloudfleet/engineroom/upgrade-blimp.sh >> /opt/cloudfleet/data/logs/upgrade.log 2>&1"

{ crontab -l -u root; echo '$UPDATE_CRONTAB'; } | crontab -u root -

mkdir -p /opt/cloudfleet
cd /opt/cloudfleet
git clone https://github.com/cloudfleet/blimp-engineroom.git engineroom

bin/initialize-blimp.sh

bin/upgrade-blimp.sh
