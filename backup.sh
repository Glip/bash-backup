#!/bin/bash
file="users.txt"
stime="`date +%Y%m%d.%H%M%S`"
UNAME="yndexusername"
PWORD="Yandexpassword"
USERDB="root"
PASSDB="pass"
for var in $(cat $file)
do
##### START BACKUP DB #####
sudo mysqldump -u $USERDB -p$PASSDB $var | gzip > /home/taz/$var.sql.$stime.gz
curl -T $var.sql.$stime.gz -u $UNAME:$PWORD https://webdav.yandex.ru/backups/
sudo rm /home/taz/$var.sql.$stime.gz
##### START BACKUP FILES #####
sudo zip -r /home/taz/$var.zip /web/$var/htdocs/
curl -T $var.zip -u $UNAME:$PWORD https://webdav.yandex.ru/backups/
sudo rm /home/taz/$var.zip
done
