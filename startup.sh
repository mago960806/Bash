#!/bin/bash
#开启Open-Falcon后端
cd /home/work/open-falcon/
./open-falcon start
#开启Open-Falcon前端
cd /home/work/open-falcon/dashboard/
./control start
#开启Seafile后端
cd /home/venustech/seafile-server-latest/
./seafile.sh start
#开启Seafile前端
./seahub.sh start