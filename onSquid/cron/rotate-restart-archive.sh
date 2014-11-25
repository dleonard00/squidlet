#!/bin/bash

today="$(date +'%Y-%m-%d')"
now="$(date +'%H-%M-%S')"
todaynow="$(date +'%Y-%m-%d')""$now"

echo "starting rotate - Date is:" >> /root/cron/rotate-uploadtodb-archive.log
date >> /root/cron/rotate-uploadtodb-archive.log
#rotate logs and wait for 5 seconds just for good measure.
time /usr/sbin/squid -k rotate >> /root/cron/rotate-uploadtodb-archive.log 2>&1
#sudo squid -k rotate >> /root/cron/rotate-uploadtodb-archive.log

sleep 15

# gsutil is having some issues copying ... not sure what to do inorder to create a reliable backup to the cloud.
#gsutil -m cp -Rc /var/log/squid3/** gs://ninja-logs/"$today"/"$now"

[ ! -d /var/log/squid3/backup/"$today" ] && mkdir -p /var/log/squid3/backup/"$today"

# write to the file so I can be sure it exists - only if log rotate has executed and create a new log file
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /root/cron/top.txt >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.0 ] && rm /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /root/cron/top.txt >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.0 ] && whoami >> /root/cron/rotate-uploadtodb-archive.log

# add any logs - system may rotate so account for that
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /var/log/squid3/mysql/mysql.log.0 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.1 ] && cat /var/log/squid3/mysql/mysql.log.1 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.2 ] && cat /var/log/squid3/mysql/mysql.log.2 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.3 ] && cat /var/log/squid3/mysql/mysql.log.3 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.4 ] && cat /var/log/squid3/mysql/mysql.log.4 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.5 ] && cat /var/log/squid3/mysql/mysql.log.5 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.6 ] && cat /var/log/squid3/mysql/mysql.log.6 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.7 ] && cat /var/log/squid3/mysql/mysql.log.7 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.8 ] && cat /var/log/squid3/mysql/mysql.log.8 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.9 ] && cat /var/log/squid3/mysql/mysql.log.9 >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.10 ] && cat /var/log/squid3/mysql/mysql.log.10 >> /root/cron/ninja.py

[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /root/cron/bottom.txt >> /root/cron/ninja.py
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /root/cron/ninja.py >> /root/cron/ninja.py.1 2>&1

# handle case where port number is absent - db expects an int.
[ -f /var/log/squid3/mysql/mysql.log.0 ] && sed -i 's/(-,/(0,/g' /root/cron/ninja.py

[ -f /var/log/squid3/mysql/mysql.log.0 ] && echo "tester" >> /root/cron/rotate-uploadtodb-archive.log
[ -f /var/log/squid3/mysql/mysql.log.0 ] && date >> /root/cron/rotate-uploadtodb-archive.log
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /root/cron/ninja.py >> /root/cron/ninja.py.2 2>&1
[ -f /var/log/squid3/mysql/mysql.log.0 ] && chmod +x /root/cron/ninja.py >> /root/cron/rotate-uploadtodb-archive.log 2>&1
[ -f /var/log/squid3/mysql/mysql.log.0 ] && python /root/cron/ninja.py >> /root/cron/rotate-uploadtodb-archive.log 2>&1

# copy to backup location
[ -f /var/log/squid3/mysql/mysql.log.0 ] && mv /var/log/squid3/mysql/mysql.log.0 /var/log/squid3/backup/"$today"/mysql.log.0."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.1 ] && mv /var/log/squid3/mysql/mysql.log.1 /var/log/squid3/backup/"$today"/mysql.log.1."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.2 ] && mv /var/log/squid3/mysql/mysql.log.2 /var/log/squid3/backup/"$today"/mysql.log.2."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.3 ] && mv /var/log/squid3/mysql/mysql.log.3 /var/log/squid3/backup/"$today"/mysql.log.3."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.4 ] && mv /var/log/squid3/mysql/mysql.log.4 /var/log/squid3/backup/"$today"/mysql.log.4."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.5 ] && mv /var/log/squid3/mysql/mysql.log.5 /var/log/squid3/backup/"$today"/mysql.log.5."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.6 ] && mv /var/log/squid3/mysql/mysql.log.6 /var/log/squid3/backup/"$today"/mysql.log.6."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.7 ] && mv /var/log/squid3/mysql/mysql.log.7 /var/log/squid3/backup/"$today"/mysql.log.7."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.8 ] && mv /var/log/squid3/mysql/mysql.log.8 /var/log/squid3/backup/"$today"/mysql.log.8."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.9 ] && mv /var/log/squid3/mysql/mysql.log.9 /var/log/squid3/backup/"$today"/mysql.log.9."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.10 ] && mv /var/log/squid3/mysql/mysql.log.10 /var/log/squid3/backup/"$today"/mysql.log.10."$todaynow"

# compress files
[ -f /var/log/squid3/backup/"$today"/mysql.log.0."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.0."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.1."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.1."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.2."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.2."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.3."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.3."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.4."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.4."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.5."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.5."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.6."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.6."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.7."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.7."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.8."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.8."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.9."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.9."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.10."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.10."$todaynow"


nightlyRestartLog="/root/cron/nightlyRestart.log"
lineCountVariableFile="/root/cron/lineCountVariableFile.txt"

echo " --- Nightly Restart Initiate --- Date is:" >> $nightlyRestartLog
date >> $nightlyRestartLog

time /usr/sbin/squid -k kill >> $nightlyRestartLog
time /usr/sbin/squid >> $nightlyRestartLog

echo "-1" > $lineCountVariableFile

echo " --- Nightly Restart Complete --- Date is:" >> $nightlyRestartLog
date >> $nightlyRestartLog

