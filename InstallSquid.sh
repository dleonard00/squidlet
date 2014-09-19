# create file
# nano InstallSquid.sh
# change permissions
# chmod +x InstallSquid.sh
# run this bash script
# sudo sh InstallSquid.sh

#! /bin/bash

sudo echo 'deb     http://gce_debian_mirror.storage.googleapis.com/ wheezy         main' >> /etc/apt/sources.list
sudo echo 'deb-src http://gce_debian_mirror.storage.googleapis.com/ wheezy         main' >> /etc/apt/sources.list
sudo echo 'deb     http://http.debian.net/debian wheezy         main' >> /etc/apt/sources.list
sudo echo 'deb-src http://http.debian.net/debian wheezy         main' >> /etc/apt/sources.list


apt-get update -y && apt-get upgrade -y
apt-get install sudo build-essential dpkg-dev git-core openssl -y
apt-get source squid3
apt-get build-dep squid3 openssl openssh -y

# Set the number of file descriptors
ulimit -n 8192
cat username hard nofile 8192 >> /etc/security/limits.conf
cat username soft nofile 8192 >> /etc/security/limits.conf

# Pull down Squid Source
cd ~
wget http://www.squid-cache.org/Versions/v3/3.4/squid-3.4.7.tar.gz
tar -xzvf squid-3.4.7.tar.gz
cd squid-3.4.7

# Configure - make all - make install
# you may need to do a make clean
sudo make clean
./configure '--prefix=/usr' '--localstatedir=/var' '--libexecdir=${prefix}/lib/squid3' '--srcdir=.' '--datadir=/usr/share/squid3' '--sysconfdir=/etc/squid3' '--with-default-user=proxy' '--with-logdir=/var/log/squid3' '--with-pidfile=/var/run/squid3.pid' '--enable-ssl' '--enable-ssl-crtd' '--enable-icap-client' '--with-openssl' '--enable-linux-netfilter' '--enable-underscores' '--enable-follow-x-forwarded-for'  '--with-filedescriptors=8192' '--enable-icmp' '--enable-delay-pools' '--enable-useragent-log' '--enable-referer-log' '--enable-arp-acl' '--disable-hostname-checks' '--enable-stacktrace' '--with-large-files' '--disable-ipv6'

make all
make install

sudo mkdir -p /usr/libexec/
sudo cp src/ssl/ssl_crtd /usr/libexec/ssl_crtd
sudo /usr/libexec/ssl_crtd -c -s /var/lib/ssl_db
chown -R proxy:proxy /var/lib/ssl_db

sudo mkdir -p /var/log/squid3/mysql/
sudo chown -R proxy:proxy /var/log/squid3/mysql/

sudo mkdir -p /etc/squid3/ssl_cert/
sudo openssl genrsa 4096 > /etc/squid3/ssl_cert/squid.key

(echo -e "US\nUtah\n\nDevice Ninja\n\ndevice.ninja\nadmin@device.ninja\n" | openssl req -new -x509 -days 365 -key /etc/squid3/ssl_cert/squid.key -out /etc/squid3/ssl_cert/squid.pem)

sudo chown -R proxy:proxy /etc/squid3/ssl_cert
sudo chown -R proxy:proxy /var/log/squid3/
