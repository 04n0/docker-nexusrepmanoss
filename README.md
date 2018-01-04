## Sonatype Nexus Repository Manager OSS 3.7

Alpine Linux 3.7 based image

*   https://www.sonatype.com/nexus-repository-oss
*   https://books.sonatype.com/nexus-book/reference3/

## Example usage

Data store persisted into `./data/` in current directory with repository
manager (port 8081) and Docker registry (port 5000) available :

```bash
docker run -d --name nexus-repository-oss \
              --volume $(pwd)/data:/opt/nexus-data \
              --publish 8081:8081 --publish 5000:5000 \
              --ulimit nofile=65536 \
              04n0/nexusrepmanoss:3.7-alpine
```

If you need to override the default configuration of JVM heap memory size, you
can do so by passing environment variables `JVM_HEAP_MIN` and/or `JVM_HEAP_MAX`
to the container:

```bash
docker run -d --name nexus-repository-oss \
          --volume $(pwd)/data:/opt/nexus-data \
          --publish 8081:8081 --publish 5000:5000 \
          -e JVM_HEAP_MIN=2048M -e JVM_HEAP_MAX=2048M \
          -e MAX_DIRECT_MEMORY=2048M \
          --ulimit nofile=65536 \
          04n0/nexusrepmanoss:3.7-alpine
```

The default configuration is:
*   JVM_HEAP_MIN=1024M
*   JVM_HEAP_MAX=1280M
*   MAX_DIRECT_MEMORY=1792M
