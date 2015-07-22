#!/bin/bash
if [ ! -f /data/db/.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

/configure_mongo.sh

OPLOG_SIZE=$(($MDB_SIZE * 256))

if [ -f /data/db/mongod.lock ]; then
  rm /data/db/mongod.lock
fi

exec /usr/bin/mongod -f /etc/mongod.conf --master --oplogSize=$OPLOG_SIZE
