#!/bin/bash

if [ -f "/etc/mysql/conf.d/mysqld_safe_syslog.cnf" ]; then
  rm "/etc/mysql/conf.d/mysqld_safe_syslog.cnf"
fi
export MDB_SIZE=${MDB_SIZE:-1}
erb "/etc/mysql/my.cnf.erb" > /etc/mysql/conf.d/mdb.cnf
