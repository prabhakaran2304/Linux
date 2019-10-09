#!/bin/bash
SHELL=/bin/bash
#cd /home/infrausr/scripts
WhatsappPath="/home/yowsup/"                    # your Whatsapp install directory
WhatsappConfigFile=$WhatsappPath"config"
WhatsappRecipient1=91                       #your Whatsapp recipients
WhatsappRecipient2=91
#CHECK=`awk -v d1="$(date --date="-2 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/messages | grep -i "HOST ALERT:\|SERVICE ALERT:\|HOST NOTIFICATION:"`
#CHECKCOUNT=`awk -v d1="$(date --date="-2 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/messages | grep -ci "HOST ALERT:\|SERVICE ALERT:\|HOST NOTIFICATION:"`

cat /home/infrausr/logsnagios/icinga.log | perl -pe 's/(\d+)/localtime($1)/e'|sed 's/[][]//g'  > /home/infrausr/logsnagios/icinga_date_crt.log

#cut -f 1,6 -d ' ' --complement

sleep 5s

CHECK=`awk -v d1="$(date --date="-30 min" "+%a %b %-d %H:%M")" -v d2="$(date "+%a %b %-d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/icinga_date_crt.log | grep -i "HOST ALERT:"`
CHECKCOUNT=`awk -v d1="$(date --date="-30 min" "+%a %b %d %H:%M")" -v d2="$(date "+%a %b %d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/icinga_date_crt.log | grep -ci "HOST ALERT:"`

if [ $CHECKCOUNT -gt 0 ] ; then
/home/yowsup/yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient1 "$CHECK" &> /dev/null
   sleep 2s
   exit 0
else
   echo "Do nothing" > /dev/null
fi

#yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient1 "$CHECK"
