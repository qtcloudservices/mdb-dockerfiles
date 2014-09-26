#!/bin/bash

CONFIG_FILE=/etc/mongod.conf
MDB_SIZE=${MDB_INSTANCE_SIZE:-1}

cp /etc/mongod-default.conf $CONFIG_FILE

echo "maxConns=$((MDB_SIZE*128))" >> $CONFIG_FILE
if [ "$MDB_SIZE" -lt "4" ]; then
  echo "smallFiles=true" >> $CONFIG_FILE
  echo "quota=true" >> $CONFIG_FILE
  echo "quotaFiles=$((MDB_SIZE*4))" >> $CONFIG_FILE
fi

echo "========================================================================"
echo ""
echo "Using following configuration options:"
cat $CONFIG_FILE
echo ""
echo "========================================================================"
