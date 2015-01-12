blimp
=======

The setup scripts for a cloudfleet blimp

## Start

To run the blimp on an ARM device, install the dependencies:

    ./scripts/install.sh

And start the services:

    ./scripts/start-docker.sh


## Development

To run the it on a desktop in a single Docker container run:

    ./run_blimp.sh username

## TODO

Create a postgres replacement:

https://github.com/docker-library/postgres.git library/postgres /9.4/