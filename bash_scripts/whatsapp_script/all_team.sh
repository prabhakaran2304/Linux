#!/bin/bash
SHELL=/bin/bash
WhatsappPath="/home/yowsup/"                    # your Whatsapp install directory
WhatsappConfigFile=$WhatsappPath"config"
mondcsys=91                   #your Whatsapp recipients
portalalert=91    
netalert=91


######## icinga date format change ####################
cat /home/infrausr/logsnagios/icinga.log | perl -pe 's/(\d+)/localtime($1)/e'|sed 's/[][]//g'  > /home/infrausr/logsnagios/icinga_date_crt.log

sleep 5s

######## icinga_net_alert ############################
NETCHECK=`awk -v d1="$(date --date="-60 min" "+%a %b  %-d %H:%M")" -v d2="$(date "+%a %b  %-d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/icinga_date_crt.log | grep -i "HOST ALERT:\|CURRENT HOST STATE"`
NETCHECKCOUNT=`awk -v d1="$(date --date="-60 min" "+%a %b  %-d %H:%M")" -v d2="$(date "+%a %b  %-d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/icinga_date_crt.log | grep -ci "HOST ALERT:\|CURRENT HOST STATE"`

############ nagios_alert ####################################
NAGCHECK=`awk -v d1="$(date --date="-1000 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/messages | grep -i "SERVICE ALERT:\|HOST NOTIFICATION:"`
NAGCHECKCOUNT=`awk -v d1="$(date --date="-1000 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/messages | grep -ci "SERVICE ALERT:\|HOST NOTIFICATION:"`


################## script loop ###########

if [ $NAGCHECKCOUNT -gt 0 ] ; then
/home/yowsup/yowsup-cli demos -c $WhatsappConfigFile -s $portalalert "$NAGCHECK" &> /dev/null
   sleep 1s
else
   echo "Do nothing" > /dev/null 

if [ $NETCHECKCOUNT -gt 0 ] ; then
/home/yowsup/yowsup-cli demos -c $WhatsappConfigFile -s $netalert "$NETCHECK" &> /dev/null
sleep 1s
exit 0
else
   echo "Do nothing" > /dev/null
fi
fi




#yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient1 "$CHECK"
