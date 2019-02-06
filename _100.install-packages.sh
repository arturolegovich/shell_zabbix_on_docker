#/bin/bash
yum -y update
yum install -y yum-utils net-tools device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
# set timezone,date,time
timedatectl set-timezone Europe/Samara
yum install -y ntp ntpdate p7zip
sed -i "s|.*ntp.org.*|0.ru.pool.ntp.org|g" /etc/ntp/step-tickers
#echo "1.ru.pool.ntp.org" >> /etc/ntp/step-tickers
#echo "2.ru.pool.ntp.org" >> /etc/ntp/step-tickers
#echo "3.ru.pool.ntp.org" >> /etc/ntp/step-tickers
#ntpdate 0.ru.pool.ntp.org
ntpdate -bs 0.ru.pool.ntp.org
systemctl enable ntpd && systemctl start ntpd
# Install docker service
yum install -y docker-ce wget
systemctl enable docker
systemctl start docker
wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm --no-check-certificate
rpm -ihv epel-release-7-11.noarch.rpm
yum install -y htop
rm epel-release-7-11.noarch.rpm
#wget https://94.181.94.215/files/zabbix_dump.7z --no-check-certificate
docker pull percona:latest
docker pull zabbix/zabbix-agent:latest
docker pull monitoringartist/dockbix-xxl:latest
docker pull phpmyadmin/phpmyadmin:4.6
docker pull monitoringartist/grafana-xxl:latest
mkdir /backups && chown zabbix:zabbix /backups
mkdir /var/lib/mysql && chown zabbix:zabbix /var/lib/mysql
mkdir /var/lib/grafana
