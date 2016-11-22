# Build from alipine
FROM alpine:3.4
MAINTAINER vi.nt <vi.nt@geekup.vn>

# Install gosu to use custom UID 
ENV GOSU_VERSION 1.9
RUN set -x \
    && apk add --no-cache --virtual .gosu-deps \
        dpkg \
        gnupg \
        openssl \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apk del .gosu-deps

# Install doctrine-migation
RUN apk --update add curl php5 php5-mysql php5-json php5-zlib php5-phar php5-pdo_mysql && \
    curl -sS -0L https://github.com/doctrine/migrations/releases/download/1.4.1/doctrine-migrations.phar -o /usr/bin/doctrine-migrations && \
    chmod +x /usr/bin/doctrine-migrations && \
    apk del curl && \
    rm -rf /var/cache/apk/*

# Create /data directory and set it as volume then set work dir to /data
RUN mkdir /data
VOLUME ["/data"]
WORKDIR /data

# Setup entrypoint with guso 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
