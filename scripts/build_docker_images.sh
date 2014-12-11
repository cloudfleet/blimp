#!/bin/bash

# run as:
# ./scripts/build_docker_images.sh scripts/docker_images.txt

docker_images_file=$1
base_repo_url=https://github.com/cloudfleet
build_location=/tmp/docker_images

function build_image(){
    image=$1
    echo building $image
    git clone --depth=1 \
        $base_repo_url/$image \
        $build_location/$line
        cd /tmp/docker_images/$line
        # sed -i 's/ubuntu:14.04/hominidae\/armhf-ubuntu/g' Dockerfile
        # sed -i 's/debian/armbuild\/debian/g' Dockerfile
        sudo docker build -t $line .
}

function clean_up(){
    rm -rf /tmp/docker_images
}

function build_all_images(){
    while read line; do
        build_image $line
    done < $docker_images_file

    #clean_up
}

build_all_images
