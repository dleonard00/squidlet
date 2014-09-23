#!/bin/bash

today="$(date +'%Y-%m-%d')"
now="$(date +'%H-%M-%S')"
todaynow="$(date +'%Y-%m-%d')""$now"

#rotate logs and wait for 5 seconds just for good measure.
sudo /usr/sbin/squid3 -k rotate
sleep 5

#mkdir /var/logs/squid3/"$today"
#touch "$today"/"$today"
#gsutil cp -R "$today" gs://ninja-logs/
#rm -Rf "$today"

#mkdir -p "$today"/"$now"
#touch "$today"/"$now"/"$now"
#gsutil cp -R "$today"/"$now" gs://ninja-logs/"$today"
#rm -Rf "$today"

# gsutil is having some issues copying ... not sure what to do inorder to create a reliable backup to the cloud.
#gsutil -m cp -Rc /var/log/squid3/** gs://ninja-logs/"$today"/"$now"

[ ! -d /var/log/squid3/backup/"$today" ] && mkdir -p /var/log/squid3/backup/"$today"

# write to the file so I can be sure it exists - only if log rotate has executed and create a new log file
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat top.txt >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.0 ] && rm ninja.py
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat top.txt >> ninja.py

# add any logs - system may rotate so account for that
[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat /var/log/squid3/mysql/mysql.log.0 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.1 ] && cat /var/log/squid3/mysql/mysql.log.1 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.2 ] && cat /var/log/squid3/mysql/mysql.log.2 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.3 ] && cat /var/log/squid3/mysql/mysql.log.3 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.4 ] && cat /var/log/squid3/mysql/mysql.log.4 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.5 ] && cat /var/log/squid3/mysql/mysql.log.5 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.6 ] && cat /var/log/squid3/mysql/mysql.log.6 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.7 ] && cat /var/log/squid3/mysql/mysql.log.7 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.8 ] && cat /var/log/squid3/mysql/mysql.log.8 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.9 ] && cat /var/log/squid3/mysql/mysql.log.9 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.10 ] && cat /var/log/squid3/mysql/mysql.log.10 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.11 ] && cat /var/log/squid3/mysql/mysql.log.11 >> ninja.py
[ -f /var/log/squid3/mysql/mysql.log.12 ] && cat /var/log/squid3/mysql/mysql.log.12 >> ninja.py

[ -f /var/log/squid3/mysql/mysql.log.0 ] && cat bottom.txt >> ninja.py

# handle case where port number is absent - db expects an int.
[ -f /var/log/squid3/mysql/mysql.log.0 ] && sed -i 's/(-,/(0,/g' ninja.py

[ -f /var/log/squid3/mysql/mysql.log.0 ] && python ninja.py

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
[ -f /var/log/squid3/mysql/mysql.log.11 ] && mv /var/log/squid3/mysql/mysql.log.11 /var/log/squid3/backup/"$today"/mysql.log.11."$todaynow"
[ -f /var/log/squid3/mysql/mysql.log.12 ] && mv /var/log/squid3/mysql/mysql.log.12 /var/log/squid3/backup/"$today"/mysql.log.12."$todaynow"

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
[ -f /var/log/squid3/backup/"$today"/mysql.log.11."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.11."$todaynow"
[ -f /var/log/squid3/backup/"$today"/mysql.log.12."$todaynow" ] && gzip -9 /var/log/squid3/backup/"$today"/mysql.log.12."$todaynow"