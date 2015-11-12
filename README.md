Blimp
=====

The setup scripts for a [CloudFleet](https://cloudfleet.io/) Blimp.
They basically deploy a
[blimp-engineroom](https://github.com/cloudfleet/blimp-engineroom) to some box
(possibly remotely) and get it to control
and auto-update a set of [Docker](www.docker.com) containers which make up
the Blimp's functionality.

## First time box setup

Follow these steps.  Instructions that are specific to a RPI2 install
are marked [RPI2], those via Cubox are [CUBOX]

- [CUBOX] set up the Cubox
[Debian image](http://www.igorpecovnik.com/2014/08/19/cubox-i-hummingboard-debian-sd-image/).
 Version 2.6 is known to work.
- [RPi2]  On Raspberry Pi 2, use one of
  [these images](https://images.collabora.co.uk/rpi2/).
- find out the IP address (e.g. through the router web interface)
From a UNIX host if you know the interface name (something like 'en0') one can use

    sudo tcpdump -i en0

to watch the initial ethernet traffic.
- Log in to the unit for the first time via SSH and set your root password (you'll be prompted)
[RPI2] Default password is '1234'
- [RPI2] Install the minimal packages on the blimp:
        apt-get install python
- [RPi2] 
The Debian RPi2 image is initially much smaller (~2.2Gib) than what is
available on the 16Gib SD cards we are using, small enough that one can't currently run
the Ansible process below successfully.

One must manually resize and grow the partition according to the following instructions:

<http://elinux.org/RPi_Resize_Flash_Partitions#Manually_resizing_the_SD_card_on_Raspberry_Pi>

Ignore the bit in the instructions about deleting swap space, as our
current DPi2 does not have a swap partition.

- copy the *hosts-remote* file and fill out the the desired values

        cd scripts/ansible
        cp hosts-remote.example hosts-remote # now edit hosts-remote
        # update the env variables below to match your case
        BLIMP_HOSTNAME=myblimp \
        ansible-playbook -k -i hosts-remote blimp-first-time.yml

- you'll be prompted for the root password

Your ssh key is authorized after the first run, so you should be able to ssh
without a password and can omit `-k`. This should be skipped for production
deployments with `--skip-tags=dev`. To speed things up on subsequent runs,
you can do `--skip-tags=packages`.

- After Ansible completes, reboot the blimp, so that it upgrades itself and
  starts all the Docker containers

        reboot

*This workflow is still under construction*

## Installing a Blimp in Virtualbox

### Use Debian Jessie

#### enable root login via password

Edit <file:/etc/ssh/sshd_config> to change the 'PermitRootLogin' line
to read:

    PermitRootLogin yes

Restart sshd

    /etc/init.d/ssh restart


### Setup port forwarding for SSH to localhost:2222
### Copy hosts-remote.example to hosts-remote

Copy <file:scripts/ansible/hosts-remote.example> to <file:scripts/ansible/hosts-remote>

    blimpie ansible_ssh_port=2222 ansible_ssh_user=root ansible_ssh_host=127.0.0.1




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
