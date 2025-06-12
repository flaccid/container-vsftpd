#!/bin/sh -ex

vsftpd \
    -oseccomp_sandbox=NO \
    -obackground=NO \
    -opasv_min_port=50000 \
    -opasv_max_port=50019 \
        /etc/vsftpd/vsftpd.conf
