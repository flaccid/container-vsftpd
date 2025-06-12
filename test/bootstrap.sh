#!/bin/sh -e

apk add --no-cache --update vsftpd
cp -v etc/vsftpd/vsftpd.conf /etc/vsftpd/
cp -v tmp/vsftpd-passwd > /tmp/vsftpd-passwd
