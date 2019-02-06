#!/usr/bin/bash
#docker stop grafanasrv
#docker rm grafanasrv
# start grafana-xxl
docker run \
    -d \
    --network zabbixlan \
    -p 3000:3000 \
    -v /etc/localtime:/etc/localtime:ro \
    --name grafanasrv \
    --hostname grafanasrv \
    -v /var/lib/grafana:/var/lib/grafana \
    -v /var/lib/grafana/plugins/:/grafana-plugins \
    monitoringartist/grafana-xxl:latest
