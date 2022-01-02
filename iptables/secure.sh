function clear_previous()
{
	iptables -F  # deleting all the rules one by one.
	iptables -X  # delete every non-builtin chain in the table.
}

function set_default()
{
	iptables -P INPUT DROP
	iptables -P OUTPUT DROP
	iptables -P FORWARD DROP
}

function allow_all()
{
	iptables -A INPUT -j ACCEPT
	iptables -A OUTPUT -j ACCEPT
}

function allow_udp()
{
	iptables -A OUTPUT -p udp -j ACCEPT
}

function allow_tcp()
{
	iptables -A OUTPUT -p tcp -j ACCEPT
}

function disallow_all()
{
	iptables -A INPUT -j DROP
	iptables -A OUTPUT -j DROP
}

function allow_dns()
{
	iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
}

function allow_http_and_https()
{
	# iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
	# iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
	
	iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
}

function allow_input_that_was_initiated_by_some_output()
{
	# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
}

function main()
{
	set_default

	allow_dns
	allow_http_and_https

	allow_input_that_was_initiated_by_some_output

	disallow_all
}

function show()
{
	iptables -L -v --line-numbers
}

function save()
{
	iptables-save
}

clear_previous
# allow_all
main
show
save

