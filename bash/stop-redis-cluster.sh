#!/bin/sh
PORTS=($(seq 1000 1 1005))

for i in ${PORTS[@]}
do
    echo "Shutting down redis on port" "$i"
    /bin/redis-cli -h <ipaddress> -a <password> -p $i shutdown
done