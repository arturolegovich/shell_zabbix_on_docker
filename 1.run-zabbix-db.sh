#!/usr/bin/bash
# Start DB for Dockbix - default 1GB innodb_buffer_pool_size is used
docker stop zabbixdb
docker rm zabbixdb
docker run \
    -d \
    -p 3306:3306 \
    --name zabbixdb \
    --hostname zabbixdb \
    --network zabbixlan \
    -v /backups:/backups \
    -v /etc/localtime:/etc/localtime:ro \
    -v /var/lib/mysql:/var/lib/mysql \
    --env="MYSQL_ROOT_PASSWORD=zabbix" \
    --env="MYSQL_DATABASE=zabbixsrv" \
    --env="MYSQL_USER=zabbix" \
    --env="MYSQL_PASSWORD=zabbix" \
    --restart unless-stopped \
    percona:latest --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci