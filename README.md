squidlet
========

Land of the Sea and Home of the Squid


Make sure you have gcloud command line tool installed: 
https://developers.google.com/cloud/sdk/gcloud/

Run CreateNewSquid.sh to create a new instance in our Google Compute Cloud

We use time based ACLs - meaning we can shut off the internet to devices at a certain time, in order for this to work properly, we must configure the time zone info of each linux instance. For now we set all squid instances to Mountain Time.

login to the new squid instance and set the timezone info using the following command:
dpkg-reconfigure tzdata

Run InstallSquid.sh to Pull down the squid3.4 source and install it.




TODO:
Modify install script so squid starts after a restart.
