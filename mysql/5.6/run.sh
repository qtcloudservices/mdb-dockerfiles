#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [ ! -f "/dev/stderr.err" ]; then
  ln -s /dev/stderr /dev/stderr.err
fi

if [[ ! -f $VOLUME_HOME/ibdata1 ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    if [ ! -f /usr/share/mysql/my-default.cnf ] ; then
        cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf
    fi
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    /create_mysql_admin_user.sh
else
    echo "=> Using an existing volume of MySQL"
fi

echo "=> Updating MySQL configuration based on instance size..."
/configure_mysql.sh
echo "=> Done!"

exec mysqld_safe
