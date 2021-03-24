#!/bin/bash
#
# About: Add sftp users
# Author: liberodark
# Thanks : 
# License: GNU GPLv3

usage ()
{
     echo "usage: -add or -del"
     echo "options:"
     echo "-add: Add users"
     echo "-del: Delelete users"
     echo "-h: Show help"
}

add_user(){
echo "Who is the user to create ?"
read -r username

useradd -g sftpusers -d /"${username}" -s /sbin/nologin "${username}"
passwd "${username}"
mkdir -p /sftp/"${username}"
mkdir -p /sftp/"${username}"/"${username}"
chown "${username}":sftpusers /sftp/"${username}"/"${username}"
systemctl restart sshd
}

del_user(){
echo "Who is the user to remove ?"
read -r username

userdel -r -f "${username}"
rm -rf /sftp/"${username}"
systemctl restart sshd
}

parse_args ()
{
    while [ $# -ne 0 ]
    do
        case "${1}" in
            -add)
                shift
                add_user >&2
                ;;
            -del)
                shift
                del_user >&2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo "Invalid argument : ${1}" >&2
                usage >&2
                exit 1
                ;;
        esac
        shift
    done

}

parse_args "$@"
