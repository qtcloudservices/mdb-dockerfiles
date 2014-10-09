#!/bin/bash
if [ ! -f /data/db/.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

/configure_mongo.sh

if [ ! -f /data/db/mongod.lock ]; then
  exec /usr/bin/mongod --auth --journal
else
  rm /data/db/mongod.lock
  mongod --dbpath /data/db --repair && exec /usr/bin/mongod --auth --journal
fi
