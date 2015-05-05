#!/bin/bash
(`dirname $0` && ./update-images.sh && ./stop-containers.sh && ./start-containers.sh)
