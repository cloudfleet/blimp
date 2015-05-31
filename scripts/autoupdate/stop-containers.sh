#!/bin/bash
CONTAINERS_TO_DELETE=$(docker ps -qa)
if [ -n "$CONTAINERS_TO_DELETE" ]; then
  docker stop $CONTAINERS_TO_DELETE
  docker rm $CONTAINERS_TO_DELETE
fi
