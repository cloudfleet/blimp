#! /bin/bash
export CLOUDFLEET_DOMAIN=$1
export CLOUDFLEET_SECRET=$2

echo "deb https://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

apt-get -y update && apt-get -y install python-pip lxc-docker


pip install meta-compose requests==2.5.2

cat > /tmp/blimp-vars.sh <<EOF

CLOUDFLEET_DOMAIN=$CLOUDFLEET_DOMAIN
CLOUDFLEET_SECRET=$CLOUDFLEET_SECRET
CLOUDFLEET_REGISTRY=registry.hub.docker.com

EOF

UPDATE_CRONTAB='0 4 * * * /opt/cloudfleet/engineroom/bin/upgrade-blimp.sh >> /opt/cloudfleet/data/logs/vagrant-upgrade.log 2>&1'

echo $UPDATE_CRONTAB
echo "$UPDATE_CRONTAB" | crontab -u root -

mkdir -p /opt/cloudfleet/data/logs
cd /opt/cloudfleet

if [ ! -d /opt/cloudfleet/engineroom ]; then
  git clone https://github.com/cloudfleet/blimp-engineroom.git engineroom
else
  (cd engineroom && git pull)
fi

cd engineroom

bin/initialize-blimp.sh

bin/upgrade-blimp.sh
