## Sonatype Nexus Repository OSS 3.19.0

Alpine Linux 3.10 based image

*   https://www.sonatype.com/nexus-repository-oss
*   https://books.sonatype.com/nexus-book/reference3/
*   https://help.sonatype.com/display/NXRM3/2019+Release+Notes

## Example usage

Data store persisted into `./data/` in current directory with repository
manager (port 8081) and Docker registry (port 5000) available :

```bash
docker run -d -v $(pwd)/data:/opt/nexus-data \
          -p 8081:8081 -p 5000:5000 \
          --ulimit nofile=65536 \
          --name nexus-repository-oss \
          04n0/nexusrepmanoss:3.19-alpine
```

If you need to override the default configuration of JVM heap memory size, you
can do so by passing environment variables `JVM_HEAP_MIN` and/or `JVM_HEAP_MAX`
to the container:

```bash
docker run -d -v $(pwd)/data:/opt/nexus-data \
          -p 8081:8081 -p 5000:5000 \
          -e JVM_HEAP_MIN=2703M -e JVM_HEAP_MAX=2703M -e MAX_DIRECT_MEMORY=2703M \
          --ulimit nofile=65536 \
          --name nexus-repository-oss \
          04n0/nexusrepmanoss:3.19-alpine
```

The default configuration is:
*   JVM_HEAP_MIN=1280M
*   JVM_HEAP_MAX=1280M
*   MAX_DIRECT_MEMORY=2G
