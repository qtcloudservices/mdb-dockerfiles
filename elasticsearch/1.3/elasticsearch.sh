#!/bin/bash
MDB_SIZE=${MDB_SIZE:-1}
NAME=elasticsearch
DEFAULT=/etc/default/$NAME

# The following variables can be overwritten in $DEFAULT

# Run Elasticsearch as this user ID and group ID
ES_USER=elasticsearch
ES_GROUP=elasticsearch

# The first existing directory is used for JAVA_HOME (if JAVA_HOME is not defined in $DEFAULT)
JDK_DIRS="/usr/lib/jvm/java-7-oracle /usr/lib/jvm/java-7-openjdk /usr/lib/jvm/java-7-openjdk-amd64/ /usr/lib/jvm/java-7-openjdk-armhf /usr/lib/jvm/java-7-openjdk-i386/ /usr/lib/jvm/default-java"

# Look for the right JVM to use
for jdir in $JDK_DIRS; do
    if [ -r "$jdir/bin/java" -a -z "${JAVA_HOME}" ]; then
        JAVA_HOME="$jdir"
    fi
done
export JAVA_HOME

# Directory where the Elasticsearch binary distribution resides
ES_HOME=/usr/share/$NAME

# Heap Size (defaults to 256m min, 1g max)
ES_HEAP_SIZE=$(($MDB_SIZE * 256 / 2))m

echo "ES_HEAP_SIZE=$ES_HEAP_SIZE"

# Heap new generation
#ES_HEAP_NEWSIZE=

# max direct memory
#ES_DIRECT_SIZE=

# Additional Java OPTS
#ES_JAVA_OPTS=

# Maximum number of open files
MAX_OPEN_FILES=65535

# Maximum amount of locked memory
#MAX_LOCKED_MEMORY=

# Elasticsearch log directory
LOG_DIR=/var/log/$NAME

# Elasticsearch data directory
DATA_DIR=/var/lib/$NAME

# Elasticsearch work directory
WORK_DIR=/tmp/$NAME

# Elasticsearch configuration directory
CONF_DIR=/etc/$NAME

# Elasticsearch configuration file (elasticsearch.yml)
CONF_FILE=$CONF_DIR/elasticsearch.yml

# Maximum number of VMA (Virtual Memory Areas) a process can own
MAX_MAP_COUNT=262144

# End of variables that can be overwritten in $DEFAULT

# overwrite settings from default file
if [ -f "$DEFAULT" ]; then
	. "$DEFAULT"
fi

# Define other required variables
PID_FILE=/var/run/$NAME.pid
DAEMON=$ES_HOME/bin/elasticsearch
DAEMON_OPTS="-Des.http.port=9201 -Des.default.config=$CONF_FILE -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR"

export ES_HEAP_SIZE
export ES_HEAP_NEWSIZE
export ES_DIRECT_SIZE
export ES_JAVA_OPTS

$ES_HOME/bin/elasticsearch $DAEMON_OPTS
