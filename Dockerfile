## for local testing purposes

FROM node:lts-bookworm
ARG HUGO=hugo_extended

# renovate: datasource=github-releases depName=gohugoio/hugo
ARG HUGO_VERSION=0.123.7

RUN apt-get update && \
    apt-get -y install wget ca-certificates openssl tzdata git

# install hugo_extended from https://github.com/gohugoio/hugo/releases
RUN wget -nv -O ${HUGO_VERSION}.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO}_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar xf ${HUGO_VERSION}.tar.gz && mv hugo* /usr/bin/hugo && \
    hugo version

VOLUME /srv/hugo

EXPOSE 1313

# switch to hugo dir
WORKDIR /srv/hugo

# auto-refreshing hugo server as entry point
ENTRYPOINT ["hugo", "server", "--bind", "0.0.0.0", "--environment", "staging"]
