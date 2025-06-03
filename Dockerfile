FROM alpine:3
RUN apk add \
    --no-cache \
    --update \
        vsftpd
USER vsftp
CMD ["vsftpd", \
     "-oseccomp_sandbox=NO", \
     "-obackground=NO", \
     "/etc/vsftpd/vsftpd.conf"]
