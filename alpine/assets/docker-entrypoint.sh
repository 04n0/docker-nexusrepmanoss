#!/bin/sh

set -ex

if [ ! -z "$JVM_HEAP_MIN" ]; then
  sed \
    -e "s|-Xms.*|-Xms${JVM_HEAP_MIN}|g" \
    -i "${NEXUS_REPO_OSS_HOME}/bin/nexus.vmoptions"
fi

if [ ! -z "${JVM_HEAP_MAX}" ]; then
  sed \
    -e "s|-Xmx.*|-Xmx${JVM_HEAP_MAX}|g" \
    -i "${NEXUS_REPO_OSS_HOME}/bin/nexus.vmoptions"
fi

if [ ! -z "${MAX_DIRECT_MEMORY}" ]; then
  sed \
    -e "s|-XX:MaxDirectMemorySize.*|-XX:MaxDirectMemorySize=${MAX_DIRECT_MEMORY}|g" \
    -i "${NEXUS_REPO_OSS_HOME}/bin/nexus.vmoptions"
fi

exec /opt/nexus-latest/bin/nexus run
