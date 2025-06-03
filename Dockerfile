FROM alpine:3
RUN apk add \
    --no-cache \
    --update \
        vsftpd
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
