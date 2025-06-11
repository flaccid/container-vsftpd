# container-vsftpd

A container image and helm chart for vsftpd.

## Usage

TBA.

## Notes

### Virtual Users Unsupported

Alpine Linux denied the package request for `pam-pwdfile`, see https://gitlab.alpinelinux.org/alpine/aports/-/issues/12190.
Project source unmaintained for over 12 years:
- https://github.com/tiwe-de/libpam-pwdfile
- https://git.tiwe.de/libpam-pwdfile.git

Alternative container solutions such as https://github.com/prapdm/vsftpd-pam/tree/master compile and install `pam-pwdfile` from source.

## Upstream Documentation
- https://security.appspot.com/vsftpd.html
- https://security.appspot.com/vsftpd/vsftpd_conf.html
- https://wiki.alpinelinux.org/wiki/FTP
- https://wiki.archlinux.org/title/Very_Secure_FTP_Daemon
- https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/5/html/deployment_guide/s4-ftp-vsftpd-conf-opt-log
- https://resetenv.com/2018/03/01/nlb/ (an interesting implementation)
