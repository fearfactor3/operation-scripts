#!/bin/sh

# Clean docker images older than 7 days in docker build vm.
docker image prune -a -f --filter "until=$(date +'%Y-%m-%dT%H:%M:%S' --date='-15 days')"