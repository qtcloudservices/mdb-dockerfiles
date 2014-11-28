#!/bin/bash

erb /etc/postgresql/9.3/main/postgresql.conf.erb > /etc/postgresql/9.3/main/postgresql.conf

#change the password
service postgresql start >/dev/null 2>&1
if [ ! -f /var/lib/postgresql/.postgres_pass_modified ]; then
	/modify_postgres_pass.sh
fi
service postgresql stop >/dev/null 2>&1

#start PostgreSQL
/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf
