Blimp
=====

The setup scripts for a [CloudFleet](https://cloudfleet.io/) Blimp.

This process deploys an instance of
[blimp-engineroom](https://github.com/cloudfleet/blimp-engineroom) to
some box (possibly remotely).  Upon reboot, this image will control
and auto-update a set of [Docker](www.docker.com) containers which
make up the Blimp's functionality.

Follow these steps.  Instructions that are specific to a RPI2 install
are marked *[RPI2]*, those via Cubox are *[CUBOX]*

## Debian arm32 setup

The first step is to install Debian on your device. Current hardware tested
includes arm32 Cubox or Raspberry Pi 2 Model B devices.
We recommend using the Raspberry Pi 2.

### Cubox Image
*[CUBOX]*

Version 2.6 of the unofficial Cubox Debian images is known to work.
Download the image from [here](http://www.armbian.com/cubox-i/).

TODO: explain the luks drivers
[patch](http://blog.soutade.fr/post/2015/08/luks-on-cubox-imx6-platform.html)
(or include this in our scripts).

### Raspberry Pi 2 image
*[RPi2]* For the Raspberry Pi 2, supported Debian images are documented
[here](http://sjoerd.luon.net/posts/2015/02/debian-jessie-on-rpi2/).

Download one of
[these images](https://images.collabora.co.uk/rpi2/).

## Find out the IP address

One option is to look at your router's web interface. If that's not possible,
from a UNIX host if you know the interface name (something like 'en0'),
one can use:

    sudo tcpdump -i en0

to watch the initial ethernet traffic.

## Log in

Log in to the unit for the first time via SSH as *root* and set a new root
password.

*[Cubox]* You'll be prompted to reset the password automatically.

*[RPI2]* The default password is 'debian'. Call `passwd` afterwards.

## Software prerequirements
*[RPI2]*

Install the minimal packages on the blimp:

        apt-get install python


## Resizing the SD image
*[RPi2]*

The Debian RPi2 image is initially much smaller (~2.2Gib) than what is
available on the 16Gib SD cards we are using, small enough that one can't
currently run the Ansible process below successfully.

One must manually resize and grow the partition according to the following
instructions:

<http://elinux.org/RPi_Resize_Flash_Partitions#Manually_resizing_the_SD_card_on_Raspberry_Pi>

Ignore the bit in the instructions about deleting swap space, as our
current DPi2 does not have a swap partition. In short:

    sudo fdisk /dev/mmcblk0
    p # to see the current start of the main partition
    d
    2 # to delete the main partition
    n
    p
    2 # to create a new primary partition, double-enter to fill start to end
    w # write the new partition table

A more sensible process would be to use the rest of the SD as btrfs,
moving what is needed over to that. Unknown how btrfs does with SD
cards, perhaps better with the copy on write (CoW) semantics?

## Run the Ansible scripts

Copy the *hosts-remote*
(i.e. <file:blimp/scripts/ansible/hosts-remote.example>) file to
<file:blimp/scripts/ansible/hosts-remote> and fill out the the
desired values

    cd scripts/ansible
    cp hosts-remote.example hosts-remote # now edit hosts-remote
    # update the env variables below to match your case

Run Ansible to populate the base image with all the tools necessary to run
(blimp-engineroom)[https://github.com/cloudfleet/blimp-engineroom]:

    BLIMP_HOSTNAME=myblimp \
    ansible-playbook -k -i hosts-remote blimp-first-time.yml

You'll be prompted for the root password.

Your ssh key is authorized after the first run, so you should be able to ssh
without a password and can omit `-k`. This should be skipped for production
deployments with `--skip-tags=dev`. To speed things up on subsequent runs,
you can do `--skip-tags=packages`.


# Reboot the blimp

  After Ansible completes, reboot the blimp, so that it upgrades
  itself and starts all the Docker containers

        reboot

## [VirtualBox] Installing a Blimp in Virtualbox

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


# Deprecated

## Deprecated: this manual workflow is not current any more, while we're transitioning to keeping all the scripts in blimp-engineroom.**

To run the blimp on an ARM device, install the dependencies:

    ./scripts/install.sh

Edit `/etc/environment` and add:

    CLOUDFLEET_DOMAIN=subdomain.bonniecloud.com
    CLOUDFLEET_SECRET=password
    CLOUDFLEET_HOST=blimpyard.cloudfleet.io:443

And start the services:

    ./scripts/start.sh


# Development

To run the it on a desktop in a single Docker container run:

    ./run_blimp.sh username

# TODO

Create a postgres replacement:

https://github.com/docker-library/postgres.git library/postgres /9.4/
