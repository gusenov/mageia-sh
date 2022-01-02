echo "______________________________________________________________________________"
echo -e "See status of network service: systemctl status network\n"

systemctl status --no-pager network




echo "______________________________________________________________________________"
echo -e "See info about ip address: ifconfig -a\n"

ifconfig -a




echo "______________________________________________________________________________"
echo -e "See info about ip address: ip a show\n"

ip a show




interface="wlo1"




echo "______________________________________________________________________________"
echo -e "See ip address info using the ip command: ip a show $interface\n"

ip a show "$interface"




echo "______________________________________________________________________________"
echo -e "The file defining an interface: etc/sysconfig/network-scripts/ifcfg-$interface\n"
cat "/etc/sysconfig/network-scripts/ifcfg-$interface"




interface="eno1"




echo "______________________________________________________________________________"
echo -e "See ip address info using the ip command: ip a show $interface\n"

ip a show "$interface"




echo "______________________________________________________________________________"
echo -e "The file defining an interface: etc/sysconfig/network-scripts/ifcfg-$interface\n"

cat "/etc/sysconfig/network-scripts/ifcfg-$interface"

