#!/bin/bash

# FIXME to be removed ASAP
# Deprecated env vars
[[ ${KAFKA_BOOTSTRAP_SERVERS:-"unset"} == "unset" && ${KAFKA_BOOTSTRAP_SERVER:-"unset"} != "unset" ]] && echo "WARN: Replace KAFKA_BOOTSTRAP_SERVER by KAFKA_BOOTSTRAP_SERVERS" && export KAFKA_BOOTSTRAP_SERVERS=${KAFKA_BOOTSTRAP_SERVER}
[[ ${KAFKA_USERNAME:-"unset"} == "unset" && ${KAFKA_USER} != "" ]] && echo "WARN: Replace KAFKA_USER by KAFKA_USERNAME" && export KAFKA_USERNAME=${KAFKA_USER}

java -cp kapoeira.jar:/conf -Dconfig.resource=${CONFIG_FILE:-application.conf} ${JAVA_SYSTEM_PROPERTIES} io.cucumber.core.cli.Main \
  --threads ${THREADS:-8} \
  --glue com.lectra.kapoeira.glue \
  -p pretty \
  -p json:/reports/kapoeira-report.json \
  -p junit:/reports/kapoeira-report.xml \
  -p html:/reports/kapoeira-report.html "$1"
