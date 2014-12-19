FROM ubuntu:trusty
MAINTAINER Jari Kolehmainen <jari.kolehmainen@digia.com>

#Install PostgreSQL-9.3
RUN apt-get update && \
    apt-get install -y postgresql-9.3 pwgen ruby && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Adjust PostgreSQL configuration so that remote connections to the database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf.erb
ADD modify_postgres_pass.sh ./modify_postgres_pass.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

ENV MDB_SIZE 1

VOLUME ["/var/lib/postgresql", "/var/log/postgresql"]

EXPOSE 5432
USER postgres
CMD ["/run.sh"]
