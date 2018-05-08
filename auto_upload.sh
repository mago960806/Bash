#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
local_time=`date "+%Y-%m-%d"`
ftp -inv <<EOF 
open 134.224.95.41
user alert JxDx!@#GJ 
passive 
binary 
cd 4A_DB
put /home/jx4a/pg_backup/venustech_$local_time.dmp
EOF 