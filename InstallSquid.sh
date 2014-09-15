# create file
# nano InstallSquid.sh
# change permissions
# chmod +x InstallSquid.sh
# run this bash script
# sudo sh InstallSquid.sh

#! /bin/bash
apt-get update -y && apt-get upgrade -y
apt-get install sudo build-essential dpkg-dev git-core -y
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
./configure '--prefix=/usr' '--localstatedir=/var' '--libexecdir=${prefix}/lib/squid3' '--srcdir=.' '--datadir=/usr/share/squid3' '--sysconfdir=/etc/squid3' '--with-default-user=proxy' '--with-logdir=/var/log/squid3' '--with-pidfile=/var/run/squid3.pid' '--enable-ssl' '--enable-ssl-crtd' '--enable-icap-client' '--with-openssl' '--enable-linux-netfilter' '--enable-underscores' '--enable-follow-x-forwarded-for'  '--with-filedescriptors=8192' '--enable-icmp' '--enable-delay-pools' '--enable-useragent-log' '--enable-referer-log' '--enable-arp-acl' '--disable-hostname-checks' '--enable-stacktrace' '--with-large-files'

make all
make install