## Sonatype Nexus Repository Manager OSS 3.2

Alpine Linux 3.5 based image

*   https://www.sonatype.com/nexus-repository-oss
*   https://books.sonatype.com/nexus-book/reference3/

## Example usage

Data store persisted into ```./data/``` in current directory with repository manager (port 8081) and Docker registry (port 5000) available :

```bash
docker run -d --name nexus-repository-oss --volume $(pwd)/data:/opt/nexus-data \
--publish 8081:8081 --publish 5000:5000 04n0/nexusrepmanoss:3.2-alpine
```
