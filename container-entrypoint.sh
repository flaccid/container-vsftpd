#!/bin/sh -e

. /etc/os-release
export OS_DISTRO="$ID"
echo "detected linux distro: $OS_DISTRO"

# automatic user provisioning
if [ -e /mnt/vsftpd/vsftpd-passwd ] && [ ! -z /mnt/vsftpd/vsftpd-passwd ]; then
	echo 'provisioning users from /mnt/vsftpd/vsftpd-passwd'
    while IFS= read -r line; do
        user=${line%:*}
        echo "adding system user, ${user}"
        case "$OS_DISTRO" in
            alpine)
                adduser -D "$user"
            ;;
            *)
                useradd -m -N "$user"
        esac
        echo $line | chpasswd
    done < /mnt/vsftpd/vsftpd-passwd
    # empty the file after use (if possible) for security reasons
    (> /mnt/vsftpd/vsftpd-passwd || true) > /dev/null 2>&1
fi

tail -f /var/log/vsftpd.log &

echo "> $@"
vsftpd -v
exec "$@"
