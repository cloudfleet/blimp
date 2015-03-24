#!/bin/bash

# run as:
# ./scripts/build_docker_images.sh \
#    scripts/docker_images.txt \
#    [registry.marina.io:5000]

docker_images_file=$1
docker_registry=${2:-"registry.hub.docker.com"}

function pull_image(){
    # parse arguments
    repo_url=$1
    image_name=$2
    branch=$3
    dockerfile_path=$4

    # pull image
    image_name=`echo "$image_name" | sed 's/./\L&/g'` # lowercase
    echo "docker pull $docker_registry/$image_name"
    #docker pull $image_name
}

function pull_all_images(){
    echo "pulling images list $docker_images_file from $docker_registry"
    while read line; do
        pull_image $line
    done < $docker_images_file

    #clean_up
}

pull_all_images