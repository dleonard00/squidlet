#! /bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Provide a name for your new instance. e.g: sh CreateNewSquid.sh momma-squid'
    exit 0
fi

IPADDRESSNAME="$1-ip"
echo $IPADDRESSNAME

gcloud compute addresses create $IPADDRESSNAME --region us-central1 --project mobile-foxy-proxy --format text

IPADDRESS=$(gcloud compute addresses list deep-squid-ip --project mobile-foxy-proxy --format text | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo $IPADDRESS

gcloud compute --project "mobile-foxy-proxy" instances create $1 --zone "us-central1-b" --machine-type "f1-micro" --network "squid" --address $IPADDRESS --maintenance-policy "MIGRATE" --scopes "https://www.googleapis.com/auth/devstorage.read_only" --tags "http-server" "https-server" --image "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-7-wheezy-v20140828"

for n in {15..1}; do
  printf "Waiting for instance to startup \r%s " $n
  sleep 1
done

# Now SSH into the Instance
gcloud compute --project "mobile-foxy-proxy" ssh --zone "us-central1-b" $1


apt-get update -y && apt-get upgrade -y
apt-get install sudo build-essential dpkg-dev git-core -y
apt-get build-dep squid3 openssl openssh -y

# Set the number of file descriptors
ulimit -n 8192
sudo cat username hard nofile 8192 >> /etc/security/limits.conf
sudo cat username soft nofile 8192 >> /etc/security/limits.conf

# Pull down Squid Source
cd ~
wget http://www.squid-cache.org/Versions/v3/3.4/squid-3.4.7.tar.gz
tar -xzvf squid-3.4.7.tar.gz
cd squid-3.4.7

# Configure - make all - make install
./configure '--prefix=/usr' '--localstatedir=/var' '--libexecdir=${prefix}/lib/squid3' '--srcdir=.' '--datadir=/usr/share/squid3' '--sysconfdir=/etc/squid3' '--with-default-user=proxy' '--with-logdir=/var/log/squid3' '--with-pidfile=/var/run/squid3.pid' '--enable-ssl' '--enable-ssl-crtd' '--enable-icap-client' '--with-openssl' '--enable-linux-netfilter' '--enable-underscores' '--enable-follow-x-forwarded-for'  '--with-filedescriptors=8192' '--enable-icmp' '--enable-delay-pools' '--enable-useragent-log' '--enable-referer-log' '--enable-arp-acl' '--disable-hostname-checks' '--enable-stacktrace' '--with-large-files' '--quiet'

make all
make install