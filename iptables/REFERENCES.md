- https://wiki.dieg.info/iptables
- https://www.casbay.com/guide/kb/how-to-block-all-ports-in-iptables
- https://linuxconfig.org/how-to-monitor-network-activity-on-a-linux-system




# https://www.linuxquestions.org/questions/linux-security-4/configure-iptables-to-drop-everything-except-web-browsing-4175541485/#post5357138

```
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT DROP [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A OUTPUT -o lo -j ACCEPT
-A OUTPUT -p tcp -m conntrack --ctstate NEW -m tcp -m multiport --dports 53,80,443 -j ACCEPT
-A OUTPUT -p udp -m conntrack --ctstate NEW -m udp --dport 53 -j ACCEPT
```




# https://www.linuxquestions.org/questions/linux-security-4/iptables-allow-only-web-browsing-443990/page2.html#post2252058

```
#*******************************************************************************|RemoveAllRules-DeleteUserDefined|****#
$IPTABLES -F
$IPTABLES -X
#******************************************************************************************************|Policies|****#
$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT DROP
$IPTABLES -P FORWARD DROP
#**********************************************************************************************************|Loop|****#
$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -A OUTPUT -o lo -j ACCEPT
#***************************************************************************************|Snort_inline|****|Input|****#
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j QUEUE
#********************************************************************************************************|Output|****#
$IPTABLES -A OUTPUT -t filter -p udp --dport 53 -j ACCEPT
$IPTABLES -A OUTPUT -t filter -p tcp -m multiport --dports 80,443,800,3124,3125,3126,3127,3128,8080 -j ACCEPT
$IPTABLES -A OUTPUT -t filter -m state --state RELATED,ESTABLISHED -j ACCEPT
#********************************************************************************************************************#
```




# https://stackoverflow.com/a/43624167

```
#!/bin/sh
#only allow apps run from "internet" group to run

# clear previous rules
sudo iptables -F

# accept packets for internet group
sudo iptables -A OUTPUT -p tcp -m owner --gid-owner internet -j ACCEPT
sudo iptables -A OUTPUT -p udp -m owner --gid-owner internet -j ACCEPT
#Some application need more port. Such as ping.
sudo iptables -A OUTPUT -p icmp -m owner --gid-owner internet -j ACCEPT
#Less secure. Open all port.
#sudo iptables -A OUTPUT -m owner --gid-owner internet -j ACCEPT

# also allow local connections
#TODO. Use log to see which port are actually needed.
sudo iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -d 192.168.0.0/16 -j ACCEPT

# reject packets for other users
sudo iptables -A OUTPUT -j REJECT

#Taken from default rules.
sudo iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 67 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 67 -j ACCEPT

#ONLY ACCEPTS INPUT THAT WAS INITIATED BY SOME OUTPUT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#DROPS ALL INPUT and FORWARD
sudo iptables -A INPUT -j DROP
sudo iptables -A FORWARD -j DROP


#IPv6 Section

# Flush ip6tables too
sudo ip6tables -F

# same process for IPv6:
sudo ip6tables -A OUTPUT -p tcp -m owner --gid-owner internet -j ACCEPT
sudo ip6tables -A OUTPUT -p udp -m owner --gid-owner internet -j ACCEPT
sudo ip6tables -A OUTPUT -d ::1/128 -j ACCEPT
sudo ip6tables -A OUTPUT -d fe80::/10 -j ACCEPT
sudo ip6tables -A OUTPUT -j REJECT

sudo ip6tables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
sudo ip6tables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
sudo ip6tables -A INPUT -p udp -m udp --dport 67 -j ACCEPT
sudo ip6tables -A INPUT -p tcp -m tcp --dport 67 -j ACCEPT
sudo ip6tables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo ip6tables -A INPUT -j DROP
sudo ip6tables -A FORWARD -j DROP
```




# https://superuser.com/q/444000

```
#!/bin/sh
#
#
iptables -F

#
#Set default policies for INPUT, FORWARD and OUTPUT chains
#
iptables -P INPUT DROP                
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

#
# Allow TCP connections on tcp port 80
#
iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

#
# Set access for localhost
#
iptables -A INPUT -i lo -j ACCEPT


#
# List rules
#
iptables -L -v
```

