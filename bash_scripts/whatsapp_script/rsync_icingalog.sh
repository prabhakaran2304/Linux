#/bin/bash
# rsync using variables

SOURCEDIR=/var/log/icinga2/compat/icinga.log
DESTDIR=/home/infrausr/logsnagios/

rsync -avh infrausr@10.61.2.182:$SOURCEDIR $DESTDIR
#rsync -a infrausr@172.25.5.101 :/var/log/messages  /home/infrausr/logsnagios/*
