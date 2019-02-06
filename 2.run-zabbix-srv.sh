#!/usr/bin/bash
docker stop zabbixsrv
docker rm zabbixsrv
docker run \
    -d \
    --name zabbixsrv \
    --hostname zabbixsrv \
    --network zabbixlan \
    -p 80:80/tcp \
    -p 10051:10051/tcp \
    -p 162:162/udp \
    -v /etc/localtime:/etc/localtime:ro \
    --env="ZA_enabled=false" \
    --env="ZP_enabled=false" \
    --env="ZJ_enabled=false" \
    --env="ZS_enabled=true" \
    --env="ZS_DBHost=zabbixdb" \
    --env="ZS_DBName=zabbixsrv" \
    --env="ZS_DBPort=3306" \
    --env="ZS_DBUser=zabbix" \
    --env="ZS_DBPassword=zabbix" \
    --env="ZS_StartPingers=5" \
    --env="XXL_searcher=false" \
    --env="XXL_zapix=false" \
    --env="XXL_grapher=false" \
    --env="XXL_api=false" \
    --env="XXL_analytics=false" \
    --env="XXL_updatechecker=true" \
    --env="SNMPTRAP_enabled=true" \
    --env="ZS_StartSNMPTrapper=1" \
    --restart unless-stopped \
    monitoringartist/dockbix-xxl:latest
