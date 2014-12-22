adb push slirp /data/local/tmp/slirp
adb ppp "shell:HOME=/data/local/tmp /data/local/tmp/slirp ppp mtu 1500" nodetach noauth noipdefault defaultroute usepeerdns notty 10.0.2.15:10.64.64.64
echo nameserver 8.8.8.8 >> /etc/resolv.conf
