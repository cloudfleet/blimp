#!/bin/bash
echo "=================================="
echo "  Stopping containers ... "
echo "=================================="

CONTAINERS_TO_DELETE=$(docker ps -qa)
if [ -n "$CONTAINERS_TO_DELETE" ]; then
  docker stop $CONTAINERS_TO_DELETE

  echo "=================================="
  echo "  Deleting containers ... "
  echo "=================================="
  docker rm $CONTAINERS_TO_DELETE
fi

echo "=================================="
echo "  Stopped and deleted containers. "
echo "=================================="

echo "=================================="
echo "  Removing obsolete images ... "
echo "=================================="


IMAGES_TO_REMOVE=$(docker images | grep "^<none>" | awk '{print $3}')
if [ -n "$IMAGES_TO_DELETE" ]; then
  docker rmi -f $IMAGES_TO_DELETE
fi

echo "=================================="
echo "  Removed obsolete images. "
echo "=================================="
