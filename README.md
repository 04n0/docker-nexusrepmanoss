## Sonatype Nexus Repository OSS 3.28.1

Alpine Linux 3.12 based image

*   https://www.sonatype.com/nexus-repository-oss
*   https://help.sonatype.com/repomanager3
*   https://help.sonatype.com/repomanager3/release-notes
*   https://help.sonatype.com/repomanager3/installation/system-requirements

## Example usage

Data store persisted into `./data/` in current directory with repository
manager (port 8081) and Docker registry (port 5000) available :

```bash
docker run -d -v $(pwd)/data:/opt/nexus-data \
          -p 8081:8081 -p 5000:5000 \
          --ulimit nofile=65536 \
          --name nexus-repository-oss \
          04n0/nexusrepmanoss:3.28-alpine
```

If you need to override the default configuration of JVM memory, you can do so
passing environment variables `JVM_HEAP_MIN` and/or `JVM_HEAP_MAX` to the
container:

```bash
docker run -d -v $(pwd)/data:/opt/nexus-data \
          -p 8081:8081 -p 5000:5000 \
          -e JVM_HEAP_MIN=4G -e JVM_HEAP_MAX=4G -e MAX_DIRECT_MEMORY=6717M \
          --ulimit nofile=65536 \
          --name nexus-repository-oss \
          04n0/nexusrepmanoss:3.28-alpine
```

The default configuration is:
*   JVM_HEAP_MIN=2703m
*   JVM_HEAP_MAX=2703m
*   MAX_DIRECT_MEMORY=2703m

You can find more information in [System Requirements](https://help.sonatype.com/repomanager3/installation/system-requirements#SystemRequirements-Memory) page.
