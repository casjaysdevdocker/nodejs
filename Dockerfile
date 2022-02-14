FROM casjaysdev/alpine:latest as build

ENV \
  TZ=${TZ:-America/New_York}; \
  SHELL=/bin/bash; \
  TERM=xterm-256color; \
  FNM_INTERACTIVE_CLI=false; \
  NODE_GYP_FORCE_PYTHON=/usr/bin/python3

RUN apk -U upgrade && \
  apk add --no-cache \
  git \
  nodejs \
  yarn \
  npm \
  screen \
  make \
  gcc \
  g++ \
  python2 \
  python3 \
  py3-pip \
  libgcc \
  libstdc++ && \
  npm i -g nodemon && \
  rm -rf /var/cache/apk/* && \
  mkdir -p /app

RUN npm install -g node-gyp

# Add fnm to support .node_version 
RUN \
  export SHELL=/bin/bash TERM=xterm-256color; \
  curl -q -LSsf "https://fnm.vercel.app/install" | \
  bash -s -- --install-dir "/usr/local/bin" --force-install

COPY ./bin/. /usr/local/bin/

FROM scratch
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')" 

LABEL \
  org.label-schema.name="nodejs" \
  org.label-schema.description="Node Development" \
  org.label-schema.url="https://github.com/casjaysdev/nodejs" \
  org.label-schema.vcs-url="https://github.com/casjaysdev/nodejs" \
  org.opencontainers.image.source=https://github.com/dockerize-it/nodejs \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="MIT" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vendor="CasjaysDev" \
  com.casjaysdev.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>" 

COPY --from=build / /
WORKDIR /app
VOLUME /app
EXPOSE 1-65535

HEALTHCHECK CMD ["/usr/local/bin/docker-entrypoint.sh", "healthcheck"]
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh"]
