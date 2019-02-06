#!/usr/bin/bash
docker run \
    -d \
    --name phpmyadmin \
    --hostname phpmyadmin \
    --network zabbixlan \
    -p 8181:80 \
    --env "PMA_HOST=zabbixdb" \
    --restart unless-stopped \
    phpmyadmin/phpmyadmin:4.6
