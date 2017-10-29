#!/bin/bash
#read -p "请输入需要检测的进程名称:" process_name
process_name="radiusd"
check_num=`ps -ef | grep $process_name | grep -v grep | wc -l`
if [ $check_num -gt 0 ]; then
 echo "检测到$process_name进程正在运行"
else
 echo "进程$process_name不存在,请检查!"
fi

