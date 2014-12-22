#!/bin/bash -x
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -t raw -F
iptables -t raw -X
iptables -t security -F
iptables -t security -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
killall pppd
adb push slirp /data/local/tmp/slirp
adb ppp "shell:HOME=/data/local/tmp /data/local/tmp/slirp ppp mtu 1500" nodetach noauth noipdefault defaultroute usepeerdns notty 10.0.2.15:10.64.64.64
echo nameserver 8.8.8.8 >> /etc/resolv.conf

ifconfig em1 192.168.100.1 netmask 255.255.255.0

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
