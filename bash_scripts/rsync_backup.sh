#!/bin/sh
echo ""
now=$(date)
echo "###########################################################################"
echo "#  Backup script v1 Prabhakaran2304 $now                                  #"
echo "###########################################################################"
echo "Backup Started...."
rsync -ahv  ~/somefiles backupserver@192.168.0.3:/home/backupserver/backup/
echo "Backup Completed!"
echo "**********************************END*************************************"
echo ""
echo ""