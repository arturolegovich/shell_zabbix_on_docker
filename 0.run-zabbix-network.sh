#!/usr/bin/bash
# Start DB for Dockbix - default 1GB innodb_buffer_pool_size is used
docker network create --subnet=10.10.10.0/24 zabbixlan