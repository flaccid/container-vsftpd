#!/bin/sh -e

# automatic user provisioning
if [ ! -z /tmp/vsftpd-passwd ]; then
	echo 'provisioning users from /tmp/vsftpd-passwd'
    while IFS= read -r line; do
        user=${line%:*}
        echo "adding system user, ${user}"
        adduser -D "$user"
        echo $line | chpasswd
    done < /tmp/vsftpd-passwd
    # empty the file after use (if possible) for security reasons
    (> /tmp/vsftpd-passwd || true) > /dev/null 2>&1
fi

tail -f /var/log/vsftpd.log &

echo "> $@"
vsftpd -v
exec "$@"
