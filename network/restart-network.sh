function stop_and_start()
{
	# do not run them over remote ssh session as you will get disconnected
	/etc/init.d/network stop
	/etc/init.d/network start
}

# /etc/init.d/network restart
systemctl restart network

