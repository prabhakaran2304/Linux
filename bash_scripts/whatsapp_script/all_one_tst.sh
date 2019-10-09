#!/bin/bash
#SHELL=/bin/bash
#cd /home/infrausr/scripts
WhatsappPath="/home/yowsup/"                    # your Whatsapp install directory
WhatsappConfigFile=$WhatsappPath"config"
    #your Whatsapp recipients
WhatsappRecipient2=91
#awkd1=`awk -v d1="$(date --date="-300 min" "+%b %_d %H:%M")"`
#awkd2=`d2="$(date "+%b %_d %H:%M")"`
logpath=/home/infrausr/logsnagios/messages
grephost= $(grep -i "HOST ALERT:\|SERVICE ALERT:\|HOST NOTIFICATION:")
grephostcount= $(grep -ci "HOST ALERT:\|SERVICE ALERT:\|HOST NOTIFICATION:")

NEWCHECK=`awk -v d1="$(date --date="-2 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' $logpath | $grephost`

NEWCHECKCOUNT=`awk -v d1="$(date --date="-2 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' $logpath | $grephostcount`


#CHECK=`awk -v d1="$(date --date="-2 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/messages | grep -i "HOST ALERT:\|SERVICE ALERT:\|HOST NOTIFICATION:"`

#CHECKCOUNT=`awk -v d1="$(date --date="-2 min" "+%b %_d %H:%M")" -v d2="$(date "+%b %_d %H:%M")" '$0 > d1 && $0 < d2 || $0 ~ d2' /home/infrausr/logsnagios/messages | grep -ci "HOST ALERT:\|SERVICE ALERT:\|HOST NOTIFICATION:"`


if [ $NEWCHECKCOUNT -gt 0 ] ; then
/home/yowsup/yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient2 "$NEWCHECK" &> /dev/null 
   sleep 2s
   exit 0 
#elif [ $CHECKCOUNT -gt 0]; then
#/home/yowsup/yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient2 "$CHECK" &> /dev/null
else
   echo "Do nothing" > /dev/null
fi



#yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient1 "$CHECK"


