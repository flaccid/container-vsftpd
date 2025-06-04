#!/bin/sh -e

tail -f /var/log/vsftpd.log &

echo "> $@"
vsftpd -v
exec "$@"
