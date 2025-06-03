FROM alpine:3
RUN apk add \
    --no-cache \
    --update \
        vsftpd
CMD ["vsftpd", \
     "-oseccomp_sandbox=NO", \
     "-obackground=NO", \
     "/etc/vsftpd/vsftpd.conf"]
