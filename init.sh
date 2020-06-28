#!/bin/bash

source /etc/profile

nohup ${WILDFLY_HOME}/bin/standalone.sh -Djboss.bind.address.management=0.0.0.0 &

tail -f /dev/null