FROM library/alpine:3.7

MAINTAINER 04n0

ENV NEXUS_REPO_OSS_VERSION="3.6.2-01" \
    NEXUS_REPO_OSS_DATA="/opt/nexus-data" \
    JVM_HEAP="1G" \
    JVM_HEAP_MAX="1280M" \
    JKS_SECRET="supersecret"

RUN \
    set -x && \
    apk add --no-cache curl su-exec openssl openjdk8-jre-base && \
    mkdir -p /opt && \
    curl -sL "https://download.sonatype.com/nexus/3/nexus-${NEXUS_REPO_OSS_VERSION}-unix.tar.gz" \
    | tar -zxC "/opt" && \
    addgroup -g 6000 -S nexus && \
    adduser -S -u 6000 -h ${NEXUS_REPO_OSS_DATA} -G nexus nexus && \
    sed \
        -e "s|-Xms1200M|-Xms${JVM_HEAP}|g" \
        -e "s|-Xmx1200M|-Xmx${JVM_HEAP_MAX}|g" \
        -e "s|-XX:MaxDirectMemorySize=2G|-XX:MaxDirectMemorySize=1792M|g" \
        -e "s|-XX:LogFile=../sonatype-work/nexus3/log/jvm.log|-XX:LogFile=${NEXUS_REPO_OSS_DATA}/log/jvm.log|g" \
        -e "s|karaf.home=.|karaf.home=/opt/nexus-${NEXUS_REPO_OSS_VERSION}|g" \
        -e "s|karaf.base=.|karaf.base=/opt/nexus-${NEXUS_REPO_OSS_VERSION}|g" \
        -e "s|karaf.etc=etc|karaf.etc=/opt/nexus-${NEXUS_REPO_OSS_VERSION}/etc|g" \
        -e "s|java.util.logging.config.file=etc|java.util.logging.config.file=/opt/nexus-${NEXUS_REPO_OSS_VERSION}/etc|g" \
        -e "s|karaf.data=../sonatype-work/nexus3|karaf.data=${NEXUS_REPO_OSS_DATA}|g" \
        -e "s|java.io.tmpdir=../sonatype-work/nexus3/tmp|java.io.tmpdir=${NEXUS_REPO_OSS_DATA}/tmp|g" \
        -i "/opt/nexus-${NEXUS_REPO_OSS_VERSION}/bin/nexus.vmoptions" &&\
    mkdir -p "${NEXUS_REPO_OSS_DATA}" && \
    chown -R nexus "${NEXUS_REPO_OSS_DATA}" && \
    ln -s "/opt/nexus-${NEXUS_REPO_OSS_VERSION}" "/opt/nexus-latest" && \
    apk del --no-cache curl libcurl

EXPOSE 8081 5000

WORKDIR /opt/nexus-latest

VOLUME ${NEXUS_REPO_OSS_DATA}

CMD ["su-exec", "nexus", "bin/nexus", "run"]
