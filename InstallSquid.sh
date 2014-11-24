#! /bin/bash
# create file
# nano InstallSquid.sh
# change permissions
# chmod +x InstallSquid.sh
# run this bash script
# sudo sh InstallSquid.sh

# Uncomment the lines below if builiding on a local VM.
#sudo echo 'deb     http://gce_debian_mirror.storage.googleapis.com/ wheezy main' >> /etc/apt/sources.list
#sudo echo 'deb-src http://gce_debian_mirror.storage.googleapis.com/ wheezy main' >> /etc/apt/sources.list
#sudo echo 'deb     http://http.debian.net/debian wheezy main' >> /etc/apt/sources.list
#sudo echo 'deb-src http://http.debian.net/debian wheezy main' >> /etc/apt/sources.list

# Uncomment if building in a docker container
#sudo echo 'deb-src http://gce_debian_mirror.storage.googleapis.com/ wheezy main' >> /etc/apt/sources.list
#sudo echo 'deb-src http://http.debian.net/debian wheezy main' >> /etc/apt/sources.list



apt-get update -y && apt-get upgrade -y
apt-get install sudo build-essential python-mysqldb dpkg-dev git-core openssl -y
# apt-get source squid3
apt-get build-dep squid3 openssl openssh -y

# Set the number of file descriptors
ulimit -n 8192
echo 'proxy hard nofile 8192' >> /etc/security/limits.conf
echo 'proxy soft nofile 8192' >> /etc/security/limits.conf

# Pull down Squid Source

wget http://www.squid-cache.org/Versions/v3/3.4/squid-3.4.9.tar.gz
tar -xzvf squid-3.4.9.tar.gz
cd squid-3.4.9

# Configure - make all - make install
# you may need to do a make clean
# sudo make clean
#./configure '--prefix=/usr' '--localstatedir=/var' '--libexecdir=${prefix}/lib/squid3' '--srcdir=.' '--datadir=/usr/share/squid3' '--sysconfdir=/etc/squid3' '--with-default-user=proxy' '--with-logdir=/var/log/squid3' '--with-pidfile=/var/run/squid3.pid' '--enable-ssl' '--enable-ssl-crtd' '--enable-icap-client' '--with-openssl' '--enable-linux-netfilter' '--enable-underscores' '--enable-follow-x-forwarded-for'  '--with-filedescriptors=8192' '--enable-icmp' '--enable-delay-pools' '--enable-useragent-log' '--enable-referer-log' '--enable-arp-acl' '--disable-hostname-checks' '--enable-stacktrace' '--with-large-files' '--disable-ipv6'

./configure '--build=x86_64-linux-gnu' '--prefix=/usr' '--includedir=${prefix}/include' '--mandir=${prefix}/share/man' '--infodir=${prefix}/share/info' '--sysconfdir=/etc' '--localstatedir=/var' '--libexecdir=${prefix}/lib/squid3' '--srcdir=.' '--disable-maintainer-mode' '--disable-dependency-tracking' '--disable-silent-rules' '--datadir=/usr/share/squid3' '--with-swapdir=/var/cache/squid' '--sysconfdir=/etc/squid3' '--mandir=/usr/share/man' '--with-cppunit-basedir=/usr' '--enable-inline' '--enable-async-io=8' '--enable-storeio=ufs,aufs,diskd' '--enable-removal-policies=lru,heap' '--enable-delay-pools' '--enable-cache-digests' '--enable-underscores' '--enable-icap-client' '--enable-follow-x-forwarded-for' '--enable-auth' '--enable-auth-basic' '--enable-auth-ntlm' '--enable-auth-digest' '--enable-auth-negotiate' '--enable-external-acl-helpers=session,unix_group,wbinfo_group' '--enable-eui' '--enable-esi' '--enable-zph-qos' '--enable-wccpv2' '--disable-translation' '--with-logdir=/var/log/squid3' '--with-pidfile=/var/run/squid3.pid' '--with-filedescriptors=65536' '--enable-ssl' '--enable-ssl-crtd' '--with-openssl' '--disable-hostname-checks' '--enable-stacktrace' '--quiet' '--with-large-files' '--with-default-user=proxy' '--enable-linux-netfilter' 'build_alias=x86_64-linux-gnu' 'CFLAGS=-g -O2 -fPIE -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wall' 'LDFLAGS=-fPIE -pie -Wl,-z,relro -Wl,-z,now' 'CPPFLAGS=-D_FORTIFY_SOURCE=2' 'CXXFLAGS=-g -O2 -fPIE -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security'


make all
make install

sudo mkdir -p /usr/libexec/
sudo cp src/ssl/ssl_crtd /usr/libexec/ssl_crtd
sudo /usr/libexec/ssl_crtd -c -s /var/lib/ssl_db
chown -R proxy:proxy /var/lib/ssl_db

sudo mkdir -p /var/log/squid3/mysql/
sudo chown -R proxy:proxy /var/log/squid3/mysql/

# Most likely we want to use only one SSL CA CERT - but potentially we dont... 
# TODO: @dleonard00 Make a decision and either provide cert in github or uncomment what is below.
# sudo mkdir -p /etc/squid3/ssl_cert/
# sudo openssl genrsa 4096 > /etc/squid3/ssl_cert/DeviceNinja-CA-private.pem
# sudo openssl req -x509 -new -key /etc/squid3/ssl_cert/DeviceNinja-CA-private.pem -out /etc/squid3/ssl_cert/DeviceNinja-CA-pub.pem -days 730 -subj /CN=Device_Ninja_Certificate 

#(echo -e "US\nUtah\n\nDevice Ninja\n\ndevice.ninja\nadmin@device.ninja\n" | openssl req -new -x509 -days 365 -key /etc/squid3/ssl_cert/squid.key -out /etc/squid3/ssl_cert/squid.pem)

#sudo chown -R proxy:proxy /etc/squid3/ssl_cert
sudo mkdir -p /var/log/squid3/cache/
sudo chown -R proxy:proxy /var/log/squid3/

# Install the gsutil
sudo apt-get install gcc python-dev python-setuptools libffi-dev -y
sudo apt-get install python-pip -y
sudo pip install gsutil

# Add all the conf files and ClientIPWhitelist files
#sudo mkdir -p /etc/squid3/userACLs/
#sudo mkdir -p /etc/squid3/userACLs/userWhiteLists/
#gsutil -m cp gs://squidward/*.conf /etc/squid3/userACLs/
#gsutil -m cp gs://squidward/*ClientIPWhiteList /etc/squid3/userACLs/userWhiteLists/

# then to set up auth run:
# see https://cloud.google.com/storage/docs/gsutil_install
# gsutil config

