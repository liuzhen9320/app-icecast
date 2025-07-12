FROM alpine:3.22 AS builder

ARG ICECAST_VERSION="2.4.4"

RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache --virtual=build-dependencies \
        build-base \
        coreutils \
        curl-dev \
        libxslt-dev \
        libxml2-dev \
        libogg-dev \
        libvorbis-dev \
        libtheora-dev \
        speex-dev \
        openssl-dev

WORKDIR /build

RUN wget https://downloads.xiph.org/releases/icecast/icecast-$ICECAST_VERSION.tar.gz -O /build/icecast-$ICECAST_VERSION.tar.gz && \
    tar -xvf icecast-$ICECAST_VERSION.tar.gz -C .
    
WORKDIR /build/icecast-$ICECAST_VERSION

RUN ./configure \
	    --prefix=/usr \
		--localstatedir=/var \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--with-curl
    
RUN make check
RUN make install DESTDIR=/build/output

FROM alpine:latest
ARG DATE_CREATED

LABEL org.opencontainers.image.title="app-icecast" \
    org.opencontainers.image.description="Unofficial Icecast2 Docker Image" \
    org.opencontainers.image.url="https://github.com/liuzhen9320/app-icecast" \
    org.opencontainers.image.source="https://github.com/liuzhen9320/app-icecast" \
    org.opencontainers.image.vendor="liuzhen9320" \
    org.opencontainers.image.author="liuzhen9320" \
    org.opencontainers.image.created="$DATE_CREATED" \
    org.opencontainers.image.licenses="GPLv3"

RUN apk update \
    && apk add --no-cache \
        tzdata \
        curl \
        libxslt \
        libxml2 \
        libogg \
        libvorbis \
        libtheora \
        speex \
        openssl \
        mailcap \
    && rm -rf /var/cache/apk/*
RUN if ! getent group icecast > /dev/null ; then addgroup -g 1001 icecast ; fi && \
    if ! id -u icecast > /dev/null 2>&1; then adduser -D -u 1001 -G icecast -s /bin/sh icecast; fi

COPY --from=builder /build/output /
COPY rootfs /
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /etc/icecast2 \
             /var/log/icecast2 \
             /var/run/icecast2 \
             /usr/share/icecast2/web \
    && chown -R icecast:icecast /var/log/icecast2 \
                                /var/run/icecast2 \
                                /usr/share/icecast2 \
				/etc/icecast2 \
    && chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl --fail --silent --show-error --output /dev/null http://127.0.0.1:8000/status-json.xsl || exit 1

WORKDIR /etc/icecast2
USER icecast
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["icecast", "-c", "/etc/icecast2/icecast.xml"]