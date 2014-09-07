#!/bin/bash

service nginx restart

domain=${BLIMP_DOMAIN}
secret=${BLIMP_SECRET}

echo "Connecting pagekite.";

account_rc="kitename = ${BLIMP_DOMAIN}\nkitesecret = ${BLIMP_SECRET}"
echo -e $account_rc > /etc/pagekite.d/10_account.rc

frontend_rc="frontend = ${BLIMP_PROXY:-blimpyard.cloudfleet.io:60666}"
echo $frontend_rc > /etc/pagekite.d/20_frontends.rc

httpd_rc="service_on = http:@kitename : localhost:3000 : @kitesecret"
echo $httpd_rc > /etc/pagekite.d/80_httpd.rc

sudo service pagekite restart


