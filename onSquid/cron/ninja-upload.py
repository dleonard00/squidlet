import MySQLdb

myDB = MySQLdb.connect(host="173.194.253.134", user="root", passwd="Develop!1")

c = myDB.cursor()
c.execute("USE squidly")

print "Executing Query"

c.executemany(
	"""INSERT INTO ninja_star (proxy_port, squid_req_status, mime, host_req_header, req_url, device_ip, epoch_plus_mili, date_day, date_time, date_subsecond, useragent_header, reply_size, client_fqdn, serverip_or_peername, full_header) 
	VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""", 
	[
 (38039, "TAG_NONE", "-", "android.clients.google.com", "android.clients.google.com:443", "107.188.153.248", 1416852159.067, "2014-11-24", "18:02:39", "000067",  "GoogleAuth/1.4 (flo LRX21P)", 0, "107.188.153.248", "android.clients.google.com", "Host: android.clients.google.com\r\nUser-Agent: GoogleAuth/1.4 (flo LRX21P)\r\nProxy-Connection: Keep-Alive\r\n"),
 (38039, "TCP_MISS", "text/plain", "android.clients.google.com", "https://android.clients.google.com/auth", "107.188.153.248", 1416852159.934, "2014-11-24", "18:02:39", "000934",  "GoogleAuth/1.4 (flo LRX21P)", 682, "107.188.153.248", "-", "app: com.google.android.youtube\r\ndevice: 361b5d7ac68b9233\r\nUser-Agent: GoogleAuth/1.4 (flo LRX21P)\r\nContent-Length: 984\r\nContent-Type: application/x-www-form-urlencoded\r\nHost: android.clients.google.com\r\nConnection: Keep-Alive\r\nAccept-Encoding: gzip\r\n"),
	]
	)

print "Done Executing Query"

myDB.commit()
myDB.close()
