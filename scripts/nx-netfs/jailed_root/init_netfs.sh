#!/bin/sh

# create user
mkdir -p /home
(echo nxuser; echo nxuser) | adduser nxuser

# setup samba server
cat <<'EOF' > /etc/samba/smb.conf
[global]
  workgroup = MYGROUP
  server string = NX Camera
  security = user
  load printers = no

[DCIM]
  comment = Photos & Videos
  path = /sdcard/DCIM
  valid users = nxuser
  browseable = yes
  writable = no
EOF
#(echo nxuser; echo nxuser) | smbpasswd -a nxuser

# setup sshd
sed 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config > /tmp/sshd_config
mv -f /tmp/sshd_config /etc/ssh/sshd_config

# setup smbnetfs
mkdir -p /root/.smb
cat <<'EOF' > /root/.smb/smbnetfs.conf
include "smbnetfs.auth"
EOF
chmod 600 /root/.smb/smbnetfs.conf
mkdir -p /sdcard /mnt/sdcard /mnt/smb
