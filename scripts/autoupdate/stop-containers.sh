#!/bin/bash
CONTAINERS_TO_DELETE=$(docker ps -qa)
if [ -n "$CONTAINERS_TO_DELETE" ]; then
  docker stop $CONTAINERS_TO_DELETE
  docker rm $CONTAINERS_TO_DELETE
fi

IMAGES_TO_REMOVE=$(docker images | grep "^<none>" | awk '{print $3}')
if [ -n "$IMAGES_TO_DELETE" ]; then
  docker rmi -f $IMAGES_TO_DELETE
fi
