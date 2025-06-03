FROM alpine:3
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
ENTRYPOINT ["vsftpd", \
            "-oseccomp_sandbox=NO", \
            "-obackground=NO", \
            "/etc/vsftpd/vsftpd.conf"]
