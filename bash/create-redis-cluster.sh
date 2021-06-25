#!/bin/sh

PORTS=($(seq 1000 i 1005))

#set up servers
rm -f appendonly.aof
rm -f dump.rdb
for i in ${PORTS[@]}
do
    rm -rf $i
    mkdir $i
    touch $i/redis.conf
    touch $i/nodes.conf
    echo "
        port $i
        bind <ipaddress>
        cluster-enabled yes
        cluster-config-file $i/nodes.conf
        cluster-node-timeout 5000
        logfile /var/log/redis/$i.log
        appendonly yes
        protected-mode no
        daemonize yes
        requirepass <password>
        masterauth <password>
    " >> $i/redis.conf
done

#set up individual redis
tmux new-session -s rc -d
for i in ${PORTS[@]}
do 
    tmux send-keys "redis-server ./$i/redis.conf" Enter
    tmux split-window -h
    tmux select-layout tiled
done

#attach session
tmux -2 attach-session -d