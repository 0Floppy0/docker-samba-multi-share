#!/bin/bash
for i in $(seq 1 "${user_count}")
do
eval user=\$user$i
eval password=\$password$i
adduser --disabled-password "$user"
(echo $password; echo $password) | smbpasswd -a $user
done
smbd
