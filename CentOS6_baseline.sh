#!/bin/bash
# 检测是否是root用户
if [ "`whoami`" != "root" ]
	then
	echo "请使用root用户执行此脚本"
	exit
fi
# 统一备份
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config_bak
cp -p /etc/rsyslog.conf /etc/rsyslog.conf_bak
cp -p /etc/profile /etc/profile_bak
cp -p /etc/login.defs /etc/login.defs_bak
cp -p /etc/rsyslog.conf /etc/rsyslog.conf_bak
cp -p /etc/pam.d/system-auth /etc/pam.d/system-auth_bak
cp -p /etc/pam.d/su /etc/pam.d/su_bak
echo "关键配置文件备份完成"
# Linux-4_限制root用户远程登录
sed -i "s/#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
# Linux-3_登陆超时时间设置
echo "TMOUT=300" >> /etc/profile
echo "export TMOUT" >> /etc/profile
# Linux-9_口令生存期
sed -i 's#99999#90#g' /etc/login.defs
sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t10/g' /etc/login.defs
# Linux-7_文件与目录缺省权限控制
sed -i "s/umask 022/umask 027/g" /etc/profile
# Linux-22_检查是否记录安全事件日志
echo "*.err;kern.debug;daemon.notice /var/log/messages" >>/etc/rsyslog.conf
chmod 640 /var/log/messages
# Linux-18_启用远程日志功能
echo "*.* @127.0.0.1" >>/etc/rsyslog.conf
# Linux-11_口令复杂度
sed -i -e '/pam_cracklib.so/d' /etc/pam.d/system-auth
echo "password requisite pam_cracklib.so try_first_pass retry=3 dcredit=-1 lcredit=-1 ucredit=-1 ocredit=-1 minlen=8" >>/etc/pam.d/system-auth
# Linux-46_检查是否使用PAM认证模块禁止wheel组之外的用户su为root
echo "auth required pam_wheel.so group=wheel" >>/etc/pam.d/su
# 新增用户以免无法登录
echo "由于禁止了root用户远程登录,如果不创建用户,将无法登录shell"
read -p "请输入普通用户名:" username
read -p "请输入为该用户设置密码:" password
useradd $username
account=${username}:${password}
echo '$account' | chpasswd
echo "创建用户成功"
# 统一使整改生效
source /etc/profile
/etc/init.d/sshd restart
/etc/init.d/rsyslog restart
echo "基线整改完成,本脚本禁止重复执行,脚本已自动删除完毕,感谢使用"
rm -- "$0"
