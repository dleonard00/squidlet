function FindProxyForURL(url, host)
{
	if (
		shExpMatch(host, "192.168.*") ||
		shExpMatch(host, "172.1[6-9].*.*")||
		shExpMatch(host, "172.2[1-9].*.*")||
		shExpMatch(host, "172.3[0-1].*.*")||
		shExpMatch(host, "10.*")
	)
	{
		return "DIRECT";
	}
	return "PROXY 192.168.1.15:3128; DIRECT";
}