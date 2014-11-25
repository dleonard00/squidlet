gcloud compute copy-files squid:/home/doug/cron/ /Users/doug/Documents/bettrnet/squidlet/onSquid/ --zone us-central1-b
gcloud compute copy-files squid:/etc/squid3/ /Users/doug/Documents/bettrnet/squidlet/onSquid/ --zone us-central1-b



gcloud compute copy-files /Users/doug/Documents/bettrnet/squidlet/onSquid/ squid:/home/doug/cron/ --zone us-central1-b
gcloud compute copy-files /Users/doug/Documents/bettrnet/squidlet/onSquid/ squid:/etc/squid3/ --zone us-central1-b