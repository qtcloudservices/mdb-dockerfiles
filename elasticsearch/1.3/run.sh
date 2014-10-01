#!/bin/bash

set -e

PASSWD=${ELASTICSEARCH_PASS:-$(pwgen -s 12 1)}

echo "=> Starting Elasticsearch with basic auth ..."
echo ${PASSWD} | htpasswd -i -c /htpasswd ${ELASTICSEARCH_USER}
echo "========================================================================"
echo "You can now connect to this Elasticsearch Server using:"
echo ""
echo "    curl ${ELASTICSEARCH_USER}:${PASSWD}@localhost:9200"
echo ""
echo "========================================================================"

exec supervisord -n
