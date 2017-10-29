#!/bin/bash
echo "开始检查是否安装了ntp客户端"
check_num=`rpm -qa | grep ntpdate | wc -l`
if [ "$check_num" -ne "0" ];then
echo "已检测到客户端，正在配置时间同步"
echo "0 */6 * * * /usr/sbin/ntpdate 134.224.95.77 >/dev/null 2>&1" >> /var/spool/cron/root
/usr/sbin/ntpdate 134.224.95.77
echo "时间同步配置完毕"
else
echo "未检测到客户端，程序退出"
fi
