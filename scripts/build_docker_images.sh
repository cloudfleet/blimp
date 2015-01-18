#!/bin/bash

# run as:
# ./scripts/build_docker_images.sh \
#    scripts/docker_images.txt
#    [/build/location]

#TODO: https://github.com/docker-library/node.git /0.10/slim

docker_images_file=$1
build_location=${2:-/tmp/docker_images}

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

function patch_dockerfile(){
    sed -i 's/FROM\ ubuntu:14.04/FROM\ hominidae\/armhf-ubuntu/g' Dockerfile
    sed -i 's/FROM\ buildpack-deps/FROM\ mazzolino\/armhf-debian/g' Dockerfile
    sed -i 's/FROM\ debian/FROM\ mazzolino\/armhf-debian/g' Dockerfile
    sed -i 's/FROM\ node:slim/FROM\ library\/node-armhf/g' Dockerfile
}

function tag_images(){
    # provide additional tags that are necessary
    docker tag library/node-armhf node
    docker tag library/nginx-armhf nginx
    docker tag mazzolino/armhf-debian debian
    docker tag hominidae/armhf-ubuntu ubuntu
}

function build_image(){
    repo_url=$1
    image_name=$2
    dockerfile_path=$3
    repo_dir=$build_location/$image_name
    echo "fetching $repo_url to $repo_dir"
    fetch_code $repo_url $repo_dir
    cd $repo_dir/$dockerfile_path
    patch_dockerfile
    tag_images
    image_name=`echo "$image_name" | sed 's/./\L&/g'` # lowercase
    echo "building Docker image as $image_name"
    docker build -t $image_name .
}

function clean_up(){
    rm -rf $build_location
}

function build_all_images(){
    echo "building images from $docker_images_file in $build_location"
    while read line; do
        build_image $line
    done < $docker_images_file

    #clean_up
}

build_all_images
