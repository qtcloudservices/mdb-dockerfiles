FROM ubuntu:trusty
MAINTAINER Jari Kolehmainen <jari.kolehmainen@digia.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r redis && useradd -r -g redis redis

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates curl pwgen ruby \
	&& rm -rf /var/lib/apt/lists/*

ENV REDIS_VERSION 2.8.21
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-2.8.21.tar.gz
ENV REDIS_DOWNLOAD_SHA1 52f619d3d301fc7ae498a1d4cb4d44ecebc5b0f9

# for redis-sentinel see: http://redis.io/topics/sentinel
RUN buildDeps='gcc libc6-dev make' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/redis \
	&& curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& rm -r /usr/src/redis \
	&& apt-get purge -y --auto-remove $buildDeps

# Add config template
ADD redis.conf.erb /etc/redis/redis.conf.erb

# Add scripts
ADD run.sh /run.sh
ADD set_redis_password.sh /set_redis_password.sh
RUN chmod +x /*.sh
RUN chown redis:redis -R /etc/redis
RUN mkdir /var/lib/redis && chown redis:redis -R /var/lib/redis

VOLUME ["/var/lib/redis"]

USER redis
EXPOSE 6379
CMD ["/run.sh"]
