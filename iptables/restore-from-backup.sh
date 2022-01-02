echo "Restore to old configuration from a backup file"
iptables-restore < iptables-backup-2021-12-12

# iptables-restore < iptables-backup-2021-12-12 
# iptables-restore v1.8.7 (legacy): Couldn't load match `psd--psd-weight-threshold':No such file or directory
# Error occurred at line: 108
# Try `iptables-restore -h' or 'iptables-restore --help' for more information.

# https://forums.mageia.org/en/viewtopic.php?t=13150&p=77064#p77046
# I got iptables-restore to accept my file from iptables-save by adding a space in the offending line in two places:
#    after -m psd    and before --psd-weight-threshold 10
#    after -j IFWLOG and before --log-prefix "SCAN"




echo "Check the status of your current iptables configuration"
iptables -L -v --line-numbers

