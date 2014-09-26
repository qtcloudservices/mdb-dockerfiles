#!/bin/bash

if [ -f "/etc/mysql/conf.d/mysqld_safe_syslog.cnf" ]; then
  rm "/etc/mysql/conf.d/mysqld_safe_syslog.cnf"
fi

if [ -f "/etc/mysql/my-$MDB_INSTANCE_SIZE.cnf" ]; then
  cp "/etc/mysql/my-$MDB_INSTANCE_SIZE.cnf" /etc/mysql/conf.d/mdb.cnf
else
  cp "/etc/mysql/my-1.cnf" /etc/mysql/conf.d/mdb.cnf
fi
