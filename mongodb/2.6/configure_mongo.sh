#!/bin/bash

export MDB_SIZE=${MDB_SIZE:-1}
erb "/etc/mongod.conf.erb" > /etc/mongod.conf
