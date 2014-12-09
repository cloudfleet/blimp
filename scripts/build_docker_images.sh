#!/bin/bash

while read line; do
    git clone --depth=1 https://github.com/cloudfleet/$line /tmp/docker_images/$line
    cd /tmp/docker_images/$line
    sudo docker build -t $line .
done < docker_images.txt

rm -rf /tmp/docker_images
