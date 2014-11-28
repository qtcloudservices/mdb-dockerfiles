FROM ubuntu:trusty
MAINTAINER Jari Kolehmainen <jari.kolehmainen@digia.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12 && \
    echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu quantal main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y redis-server pwgen ruby && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add config template
ADD redis.conf.erb /etc/redis/redis.conf.erb

# Add scripts
ADD run.sh /run.sh
ADD set_redis_password.sh /set_redis_password.sh
RUN chmod +x /*.sh
RUN chown redis:redis -R /etc/redis

VOLUME ["/var/lib/redis"]
RUN chown redis:redis -R /etc/redis

USER redis
EXPOSE 6379
CMD ["/run.sh"]
