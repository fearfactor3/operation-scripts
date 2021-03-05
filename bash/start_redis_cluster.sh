#!/bin/sh
PORTS=($(seq 1000 1 1005)) # Change Ports numbers here

#set up individual redis
tmux new-session -s rc -d
for i in ${PORTS[@]}
do
    tmux send-keys "redis-server ./$i/redis.conf" Enter
    tmux split-window -h
    tmux select-layout tiled
done

# attach session
tmux -2 attach-session -d