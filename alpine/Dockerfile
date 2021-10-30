FROM library/alpine:3.14

LABEL maintainer="04n0"

ENV NEXUS_REPO_OSS_VERSION="3.36.0-01" \
    NEXUS_REPO_OSS_DATA="/opt/nexus-data" \
    NEXUS_REPO_OSS_HOME="/opt/nexus-latest" \
    JVM_HEAP_MIN=2703M \
    JVM_HEAP_MAX=2703M \
    MAX_DIRECT_MEMORY=2703M \
    JKS_SECRET="supersecret"

ARG NEXUS_REPO_OSS_FILE_HASH=3a1e0e75beabc1445beb03f744e922a47a90d167afc3979323f58ad2191c8e43
ARG NEXUS_REPO_OSS_FILE_NAME="nexus-${NEXUS_REPO_OSS_VERSION}-unix.tar.gz"
ARG NEXUS_REPO_OSS_FILE_URL="https://download.sonatype.com/nexus/3/${NEXUS_REPO_OSS_FILE_NAME}"

RUN \
    apk add --no-cache nspr nss openssl openjdk8-jre-base sqlite-libs

RUN \
    set -x && \
    apk add --no-cache curl && \
    mkdir -p /opt && \
    curl -sSLO "${NEXUS_REPO_OSS_FILE_URL}" && \
    echo "${NEXUS_REPO_OSS_FILE_HASH}  ${NEXUS_REPO_OSS_FILE_NAME}" | sha256sum -c - && \
    tar -zxf "${NEXUS_REPO_OSS_FILE_NAME}" -C "/opt" && \
    rm -f "${NEXUS_REPO_OSS_FILE_NAME}" && \
    addgroup -g 6000 -S nexus && \
    adduser -S -u 6000 -h "${NEXUS_REPO_OSS_DATA}" -G nexus nexus && \
    sed \
        -e "s|-XX:LogFile=../sonatype-work/nexus3/log/jvm.log|-XX:LogFile=${NEXUS_REPO_OSS_DATA}/log/jvm.log|g" \
        -e "s|karaf.home=.|karaf.home=/opt/nexus-${NEXUS_REPO_OSS_VERSION}|g" \
        -e "s|karaf.base=.|karaf.base=/opt/nexus-${NEXUS_REPO_OSS_VERSION}|g" \
        -e "s|karaf.etc=etc|karaf.etc=/opt/nexus-${NEXUS_REPO_OSS_VERSION}/etc|g" \
        -e "s|java.util.logging.config.file=etc|java.util.logging.config.file=/opt/nexus-${NEXUS_REPO_OSS_VERSION}/etc|g" \
        -e "s|karaf.data=../sonatype-work/nexus3|karaf.data=${NEXUS_REPO_OSS_DATA}|g" \
        -e "s|java.io.tmpdir=../sonatype-work/nexus3/tmp|java.io.tmpdir=${NEXUS_REPO_OSS_DATA}/tmp|g" \
        -i "/opt/nexus-${NEXUS_REPO_OSS_VERSION}/bin/nexus.vmoptions" &&\
    mkdir -p "${NEXUS_REPO_OSS_DATA}" && \
    chown -R nexus:nexus "/opt/nexus-${NEXUS_REPO_OSS_VERSION}" && \
    chown -R nexus:nexus "${NEXUS_REPO_OSS_DATA}" && \
    ln -s "/opt/nexus-${NEXUS_REPO_OSS_VERSION}" "${NEXUS_REPO_OSS_HOME}" && \
    apk del --no-cache curl libcurl nghttp2-libs

EXPOSE 8081 5000

USER nexus

WORKDIR /opt/nexus-latest

VOLUME ${NEXUS_REPO_OSS_DATA}

COPY assets/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

#CMD ["bin/nexus", "run"]
