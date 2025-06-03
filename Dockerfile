FROM alpine:3
COPY container-entrypoint.sh /usr/local/bin/container-entrypoint.sh
RUN apk add \
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
    rm -rf /var/cache/apk/*        
EXPOSE 21/tcp
EXPOSE 15393-15394/tcp
WORKDIR /var/lib/ftp
ENTRYPOINT ["/usr/local/bin/container-entrypoint.sh"]
CMD ["vsftpd", \
            "-oseccomp_sandbox=NO", \
            "-obackground=NO", \
            "/etc/vsftpd/vsftpd.conf"]
