# cloudfleet blimp
#
# VERSION 0.1

FROM ubuntu:14.04

ADD . /opt/cloudfleet/setup
WORKDIR /opt/cloudfleet/setup
RUN scripts/install.sh

CMD scripts/start.sh

