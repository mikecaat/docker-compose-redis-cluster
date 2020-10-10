#!/bin/sh

if [ "$1" = 'redis-cluster' ]; then
    sleep 3
    echo "yes" | redis-cli --cluster create --cluster-replicas 0 173.17.0.2:7000 173.17.0.3:7001 173.17.0.4:7002
    redis-cli -h 173.17.0.2 -p 7000 CLUSTER NODES
    echo "DONE"
elif [ "$1" = 'redis-scale-out' ]; then
    sleep 3
    redis-cli -p 7000 --cluster add-node 173.17.0.5:7003 173.17.0.2:7000
    sleep 3
    redis-cli -p 7000 --cluster rebalance --cluster-use-empty-masters 173.17.0.5:7003
    sleep 3
    redis-cli -p 7000 --cluster info 173.17.0.2:7000
else
  exec "$@"
fi
