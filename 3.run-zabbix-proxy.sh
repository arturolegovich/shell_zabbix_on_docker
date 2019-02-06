#!/usr/bin/bash
docker run \
    -d \
    --name zabbixproxy \
    --hostname zabbixproxy \
    --network zabbixlan \
    -p 10051:10051 \
    -v /etc/localtime:/etc/localtime:ro \
    --env="ZA_enabled=false" \
    --env="ZP_enabled=true" \
    --env="ZJ_enabled=false" \
    --env="ZS_enabled=false" \
    --env="ZW_enabled=false" \
    --env="ZP_Server=zabbixsrv" \
    --env="ZP_DBHost=zabbixdb" \
    --env="ZP_DBName=zabbixproxy" \
    --env="ZP_DBPort=3306" \
    --env="ZP_DBUser=zabbix" \
    --env="ZP_DBPassword=zabbix" \
    --env="XXL_searcher=false" \
    --env="XXL_zapix=false" \
    --env="XXL_grapher=false" \
    --env="XXL_api=false" \
    --env="XXL_analytics=false" \
    --env="XXL_updatechecker=false" \
    --restart unless-stopped \
    monitoringartist/dockbix-xxl:latest
