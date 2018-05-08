#!/bin/bash
#检测是否是root用户
if [ "`whoami`" != "root" ]
        then
        echo "请使用root用户执行此脚本"
        exit
fi
#安装Docker依赖组件
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sed -i "s|download.docker.com|mirrors.ustc.edu.cn/docker-ce|g" /etc/yum.repos.d/docker-ce.repo
#安装Docker服务
yum install docker-ce
#开启Docker服务并配置开机运行
systemctl start docker
systemctl enable docker
#下载Oracle-12c镜像
docker pull sath89/oracle-12c
#启动Oracle容器
docker run -d -p 8080:8080 -p 1521:1521 sath89/oracle-12c
#输出安装日志
docker logs -f oracle-12c