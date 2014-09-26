FROM ubuntu:trusty
MAINTAINER Jari Kolehmainen <jari.kolehmainen@digia.com>

# Install packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server-5.6 pwgen

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL configurations
ADD my-1.cnf /etc/mysql/my-1.cnf
ADD my-2.cnf /etc/mysql/my-2.cnf
ADD my-4.cnf /etc/mysql/my-4.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Add MySQL scripts
ADD configure_mysql.sh /configure_mysql.sh
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Exposed ENV
ENV MYSQL_PASS **Random**

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

EXPOSE 3306
CMD ["/run.sh"]
