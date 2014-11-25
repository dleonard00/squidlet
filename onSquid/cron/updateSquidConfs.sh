#!/bin/bash

gsutil -m rsync -d -r gs://squidward/ /root/confs/

sudo rsync -a -d --delete -m -r --force --exclude 'cron' /root/confs/ /etc/squid3/userACLs/
#sudo rsync -d /root/userWhiteLists/* /etc/squid3/userACLs/userWhiteLists

#/usr/sbin/squid -k parse
/usr/sbin/squid -k reconfigure
#/usr/sbin/squid -k check


#parse_output=$( /usr/sbin/squid -k parse )
#if [[ $? != 0 ]]
#then
#    date >> updateSquidConfs.log
#    echo "FAILED sudo squid -k parse" >> updateSquidConfs.log
#elif [[ -n $(parse_output | grep FATAL) ]]
#then
#    date >> updateSquidConfs.log
#    echo "FATAL Exception sudo squid -k parse" >> updateSquidConfs.log
#else
#    date >> updateSquidConfs.log
#    echo "SUCCESS sudo squid -k parse" >> updateSquidConfs.log
#fi

# check for errors in parse output
# reconfigure
# check for issues using check command
# roll back if neccisary
# send email if there is an issue
# update temp folder of last valid config if check was successful this becomes
# the new rollback point in case of failure in the future

# search for:
# FATAL
# Terminated abnormally





#keep log size for cronjobs trimmed to less than 100mb
#sudo truncate /var/mail/root --size 100000000

