FROM ubuntu:trusty
MAINTAINER Jari Kolehmainen <jari.kolehmainen@digia.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

RUN apt-get update && \
    apt-get install -y mongodb-org pwgen ruby && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data/db

ADD mongod.conf.erb /etc/mongod.conf.erb

# Add run scripts
ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
ADD configure_mongo.sh /configure_mongo.sh
RUN chmod 755 ./*.sh

EXPOSE 27017

CMD ["/run.sh"]
