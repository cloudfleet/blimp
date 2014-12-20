#!/bin/bash

# run as:
# ./scripts/build_docker_images.sh scripts/docker_images.txt

#TODO: https://github.com/docker-library/node.git /0.10/slim

docker_images_file=$1
base_repo_url=https://github.com/cloudfleet
build_location=/tmp/docker_images

function fetch_code(){
    repo_url=$1
    repo_dir=$2
    if [ -d $repo_dir ]; then
        # if true this block of code will execute
        echo "folder exists, not cloning" # pull changes?
    else
        echo "cloning https://github.com/cloudfleet/$line"
        git clone --depth=1 $repo_url $repo_dir
    fi
}

function build_image(){
    image=$1
    echo building $image
    repo_dir=$build_location/$line
    fetch_code $base_repo_url/$image $repo_dir
    cd $repo_dir
    sed -i 's/ubuntu:14.04/hominidae\/armhf-ubuntu/g' Dockerfile
    sed -i 's/debian/mazzolino\/armhf-debian/g' Dockerfile
    image_name=`echo "cloudfleet/$image" | sed 's/./\L&/g'` # lowercase
    echo "building Docker image as $image_name"
    sudo docker build -t $image_name .
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
