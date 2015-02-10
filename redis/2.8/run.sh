#!/bin/bash
echo "=> Configuring redis as a LRU cache (volatile-ttl)"
REDIS_CONFIG=/etc/redis/redis.conf
MDB_SIZE=${MDB_SIZE:-1}
export REDIS_MAXMEMORY=$((MDB_SIZE * 256))
erb /etc/redis/redis.conf.erb > $REDIS_CONFIG

if [ ! -f /.redis_password_set ]; then
        /set_redis_password.sh
fi

exec /usr/bin/redis-server $REDIS_CONFIG
