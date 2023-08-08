# Container image that runs your code
FROM alpine:3.18.3

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY run-scan.sh /run-scan.sh
COPY docker_test.sh /docker_test.sh

RUN apk update && apk add --upgrade --no-cache ca-certificates curl jq && \
  curl -s https://downloads.accurics.com/cli/github-action/accurics -o /usr/bin/accurics && \
  chmod 755 /run-scan.sh /docker_test.sh /usr/bin/accurics

ENTRYPOINT ["run-scan.sh"]
