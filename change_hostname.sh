#!/bin/bash
read -p "当前主机名为${HOSTNAME},是否修改(y/n):" yn
if [ "$yn" == "y" ]; then
	read -p "请输入主机名：" newhostname
	cat /dev/null > /etc/sysconfig/network
	echo "NETWORKING=yes" >> /etc/sysconfig/network
	echo "HOSTNAME=$newhostname" >> /etc/sysconfig/network
	hostname $newhostname
	echo "主机名修改完毕,当前主机名为$newhostname,下一次登录时生效"
fi
