blimp
=======

The setup scripts for a cloudfleet blimp

## First time box setup

Follow these steps:

 - set up the [Debian image](http://www.igorpecovnik.com/2014/08/19/cubox-i-hummingboard-debian-sd-image/).
 - find out the IP address
 - log in for the first time and set your root password (you'll be prompted)
 - copy the hosts-remote file and fill out the the desired values

        cd scripts/ansible
        cp hosts-remote.example hosts-remote # now edit hosts-remote
        ansible-playbook -k -i hosts-remote blimp-first-time.yml

- you'll be prompted for the password

Your ssh key is authorized after the first run, so you should be able to ssh
without a password and can omit `-k`. This should be skipped for production
deployments with `--skip-tags=dev`.

*This workflow is still under construction*

TODO:

- add docker (Debian experimental)
- fill out /etc/environment
- call the start script

## Start

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
