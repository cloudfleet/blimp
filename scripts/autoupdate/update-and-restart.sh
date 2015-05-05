#!/bin/bash
(cd `dirname $0` && ./update-images.sh && ./stop-containers.sh && ./start-containers.sh)
