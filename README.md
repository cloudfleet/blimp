Blimp
=====

The setup scripts for a [CloudFleet](https://cloudfleet.io/) Blimp.
They basically deploy a
[blimp-engineroom](https://github.com/cloudfleet/blimp-engineroom) to some box
(possibly remotely) and get it to control
and auto-update a set of [Docker](www.docker.com) containers which make up
the Blimp's functionality.

## First time box setup

Follow these steps:

- set up the
[Debian image](http://www.igorpecovnik.com/2014/08/19/cubox-i-hummingboard-debian-sd-image/).
Version 2.6 is known to work
- find out the IP address
- log in for the first time and set your root password (you'll be prompted)
- copy the hosts-remote file and fill out the the desired values

        cd scripts/ansible
        cp hosts-remote.example hosts-remote # now edit hosts-remote
        # update the env variables below to match your case
        BLIMP_HOSTNAME=myblimp CLOUDFLEET_DOMAIN=example.com \
        CLOUDFLEET_SECRET=mypassword \
        CLOUDFLEET_HOST=blimpyard.cloudfleet.io:443 \
        ansible-playbook -k -i hosts-remote blimp-first-time.yml

- you'll be prompted for the password

Your ssh key is authorized after the first run, so you should be able to ssh
without a password and can omit `-k`. This should be skipped for production
deployments with `--skip-tags=dev`. To speed things up on subsequent runs,
you can do `--skip-tags=packages`.

- After Ansible completes, run `upgrade-blimp.sh`

After logging into the blimp host via ssh, execute the upgrade script:

    /opt/cloudfleet/engineroom/bin/upgrade-blimp.sh

*This workflow is still under construction*


## Start

**Deprecated: this manual workflow is not current any more, while we're
transitioning to keeping all the scripts in blimp-engineroom.**

To run the blimp on an ARM device, install the dependencies:

    ./scripts/install.sh

Edit `/etc/environment` and add:

    CLOUDFLEET_DOMAIN=subdomain.bonniecloud.com
    CLOUDFLEET_SECRET=password
    CLOUDFLEET_HOST=blimpyard.cloudfleet.io:443

And start the services:

    ./scripts/start.sh


## Development

To run the it on a desktop in a single Docker container run:

    ./run_blimp.sh username

## TODO

Create a postgres replacement:

https://github.com/docker-library/postgres.git library/postgres /9.4/
