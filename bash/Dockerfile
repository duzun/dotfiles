FROM alpine:latest

MAINTAINER Dumitru Uzun <contact@duzun.me>

LABEL vendor="duzun.me" \
      application="bash" \
      version="1.0.0"

RUN set -x \
    `# && echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories` \
    && apk upgrade --no-cache \
    && apk add --update --no-cache --virtual .bash \
        bash \
        git \
    && echo '[ -x /opt/dotfiles/~/source ] && . /opt/dotfiles/~/source' > /root/.bashrc \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT /bin/bash
