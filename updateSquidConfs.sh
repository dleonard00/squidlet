#!/bin/bash

scp root@shuriken.device.ninja:/sites/prod/shuriken/shuriken/super_pac/www-data/conf/userACLs/*.conf /home/doug/confs/
sudo gsutil -m cp gs://squidward/*.conf /home/doug/confs/

scp root@shuriken.device.ninja:/sites/prod/shuriken/shuriken/super_pac/www-data/conf/userACLs/userWhiteLists/* /home/doug/userWhiteLists/
sudo gsutil -m cp gs://squidward/*WhiteList /home/doug/userWhiteLists/

sudo cp /home/doug/confs/* /etc/squid3/userACLs/
sudo cp /home/doug/userWhiteLists/* /etc/squid3/userACLs/userWhiteLists

sudo squid3 -k parse
sudo squid3 -k reconfigure

#keep log size for cronjobs trimmed to less than 100mb
#sudo truncate /var/mail/doug --size 100000000
