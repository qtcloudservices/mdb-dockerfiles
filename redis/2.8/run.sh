#!/bin/bash
echo "=> Configuring redis as a LRU cache (volatile-ttl)"
REDIS_CONFIG=/etc/redis/redis_default.conf
MDB_SIZE=${MDB_INSTANCE_SIZE:-1}
REDIS_MAXMEMORY=$((MDB_SIZE * 256))
touch /etc/redis/redis_default.conf
echo "maxmemory ${REDIS_MAXMEMORY}mb" >> $REDIS_CONFIG
echo "maxmemory-policy volatile-ttl" >> $REDIS_CONFIG

echo "=> Setting timeout to ${REDIS_TIMEOUT}"
echo timeout ${REDIS_TIMEOUT} >> $REDIS_CONFIG

if [ ! -f /.redis_password_set ]; then
        /set_redis_password.sh
fi

exec /usr/bin/redis-server $REDIS_CONFIG
