#!/bin/bash

[ -f /root/cron/patrol.log ] && rm /root/cron/patrol.log

/usr/sbin/squid -k check > /root/cron/patrol.log

lineCount=$(wc -l /root/cron/patrol.log | cut -d' ' -f1)

if [[ $lineCount -gt 0 ]]
then
    echo "Squid is down - Sound the alarm!"
else
    echo "Squid is fine"
fi
