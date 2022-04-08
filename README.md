# sftp_user


##### Download sftp_user :

```
wget https://raw.githubusercontent.com/liberodark/sftp_user/main/sftp_users.sh -O /usr/bin/sftp_user
chmod +x /usr/bin/sftp_user
```

##### Create sftp group & folder :

```
groupadd sftpusers
mkdir /sftp
```

##### Edit sshd_config :

`nano /etc/ssh/sshd_config`

```
# override default of no subsystems
#Subsystem      sftp    /usr/libexec/openssh/sftp-server
Subsystem       sftp    internal-sftp

Match Group sftpusers
        ChrootDirectory /sftp/%u
        PermitTTY no
        AllowTcpForwarding no
        X11Forwarding no
        ForceCommand internal-sftp
```

##### Restart server ssh :

`systemctl restart sshd`
