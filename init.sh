#!/bin/bash

source /etc/profile

nohup ${WILDFLY_HOME}/bin/standalone.sh -Djboss.bind.address.management=0.0.0.0 &

cp -rf ${WILDFLY_HOME}/bin /host
tail -f /dev/null