#!/bin/bash

echo "----------------------------------"  
echo "(1)设置主机名"
echo "(2)配置时间同步服务"
echo "----------------------------------"  

read -p "请输入要进行的操作:" n
case $n in
	1) ./change_hostname.sh
	;;
	2) ./check_install.sh
	;;
	*) echo "请输入正确的数字"
	;;
esac
