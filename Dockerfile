FROM alpine:3
COPY container-entrypoint.sh /usr/local/bin/container-entrypoint.sh
RUN apk add \
    --no-cache \
    --update \
    inetutils-ftp \
    inetutils-telnet \
    iproute2 \
    vsftpd && \
    touch /var/log/vsftpd.log && \
    rm -rf /var/cache/apk/*        
EXPOSE 21/tcp
EXPOSE 15393-15394/tcp
ENTRYPOINT ["/usr/local/bin/container-entrypoint.sh"]
CMD ["vsftpd", \
            "-oseccomp_sandbox=NO", \
            "-obackground=NO", \
            "/etc/vsftpd/vsftpd.conf"]
