#!/usr/bin/bash
docker stop zabbixagent
docker rm zabbixagent
docker run \
    -d \
    --name zabbixagent \
    --network zabbixlan \
    --hostname zabbixagent \
    -v /etc/localtime:/etc/localtime:ro \
    --privileged \
    -v /:/rootfs \
    -v /var/run:/var/run \
    --env="ZBX_SERVER_HOST=zabbixsrv" \
    --env="ZBX_HOSTNAME=R18ZABBIX011" \
    --restart unless-stopped \
    zabbix/zabbix-agent:latest
