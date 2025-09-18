# syntax=docker/dockerfile:1

ARG S6_OVERLAY_VERSION=3.2.1.0

FROM alpine:3 AS s6
ARG S6_OVERLAY_VERSION
ARG TARGETARCH=x86_64
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${TARGETARCH}.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-${TARGETARCH}.tar.xz

FROM alpine:3
COPY bin/ /usr/local/bin/
COPY --from=s6 / /
COPY etc/s6-overlay/s6-rc.d /etc/s6-overlay/s6-rc.d
RUN touch \
    /etc/s6-overlay/s6-rc.d/user/contents.d/init-provision-users \
    /etc/s6-overlay/s6-rc.d/user/contents.d/init-vsftpd-info \
    /etc/s6-overlay/s6-rc.d/user/contents.d/vsftpd \
    /etc/s6-overlay/s6-rc.d/user/contents.d/log-tail && \
    apk add \
    --no-cache \
    --update \
    inetutils-ftp \
    inetutils-telnet \
    iproute2 \
    vsftpd && \
    addgroup root ftp && \
    mkdir /var/lib/ftp/incoming && \
    chmod g+rwx /var/lib/ftp/incoming && \
    touch /var/log/vsftpd.log && \
    rm -rf /var/cache/apk/* /tmp/*
EXPOSE 21/tcp 50000-50019/tcp
WORKDIR /var/lib/ftp
ENTRYPOINT ["/init"]
