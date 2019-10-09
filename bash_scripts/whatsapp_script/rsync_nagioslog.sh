#/bin/bash
# rsync using variables

SOURCEDIR=/var/log/messages
DESTDIR=/home/infrausr/logsnagios/

rsync -avh infrausr@172.25.5.101:$SOURCEDIR $DESTDIR
#rsync -a infrausr@172.25.5.101 :/var/log/messages  /home/infrausr/logsnagios/*
