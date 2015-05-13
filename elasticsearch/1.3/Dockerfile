FROM ubuntu:trusty
MAINTAINER Jari Kolehmainen <jari.kolehmainen@digia.com>

RUN apt-get update && \
    apt-get install -y curl

RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
    echo 'deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y elasticsearch openjdk-7-jre-headless && \
    apt-get install -y nginx supervisor apache2-utils pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/share/elasticsearch/bin/plugin --install jdbc --url http://xbib.org/repository/org/xbib/elasticsearch/plugin/elasticsearch-river-jdbc/1.3.4.7/elasticsearch-river-jdbc-1.3.4.7-plugin.zip

ADD mysql-connector-java-5.1.28-bin.jar /usr/share/elasticsearch/plugins/jdbc/
ADD postgresql-9.3-1102.jdbc41.jar /usr/share/elasticsearch/plugins/jdbc/

ENV ELASTICSEARCH_USER admin

ADD elasticsearch.sh /elasticsearch.sh
ADD logging.yml /etc/elasticsearch/logging.yml
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run.sh /run.sh
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx_default /etc/nginx/sites-enabled/default
RUN chmod +x /*.sh

EXPOSE 9200
CMD ["/run.sh"]
