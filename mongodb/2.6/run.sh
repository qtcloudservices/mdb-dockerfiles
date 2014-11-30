#!/bin/bash
if [ ! -f /data/db/.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

/configure_mongo.sh

OPLOG_SIZE=$(($MDB_SIZE * 256))

if [ ! -f /data/db/mongod.lock ]; then
  exec /usr/bin/mongod --auth --journal --master --oplogSize=$OPLOG_SIZE
else
  rm /data/db/mongod.lock
  mongod --dbpath /data/db --repair && exec /usr/bin/mongod --auth --journal --master --oplogSize=$OPLOG_SIZE
fi
