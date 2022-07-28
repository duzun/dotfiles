FROM alpine:latest

LABEL vendor="duzun.me" \
      author="Dumitru Uzun <contact@duzun.me>" \
      application="bash" \
      version="1.0.1"

RUN set -x \
    `# && echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories` \
    && apk upgrade --no-cache \
    && apk add --update --no-cache --virtual .bash \
        bash \
        curl \
        git \
    && echo '[ -x /opt/dotfiles/~/source ] && . /opt/dotfiles/~/source' > /root/.bashrc \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT exec /bin/bash
