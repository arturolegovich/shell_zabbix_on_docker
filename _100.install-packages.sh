#/bin/bash
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /usr/lib/sysctl.d/01-disable-ipv6.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /usr/lib/sysctl.d/01-disable-ipv6.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /usr/lib/sysctl.d/01-disable-ipv6.conf
sed -i "s|.*#AddressFamily.*|AddressFamily inet|g" /etc/ssh/sshd_config
systemctl restart sshd
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
rm -f epel-release-7-11.noarch.rpm
docker volume create portainer_data
docker run -d -p 9000:9000 --name portainer --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
#docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
#wget https://94.181.94.215/files/zabbix_dump.7z --no-check-certificate
docker pull percona:latest
docker pull zabbix/zabbix-agent:latest
docker pull monitoringartist/dockbix-xxl:latest
docker pull phpmyadmin/phpmyadmin:4.6
docker pull monitoringartist/grafana-xxl:latest
mkdir /var/lib/mysql && chown 999:999 /var/lib/mysql
mkdir /backups && chown 999:999 /backups
mkdir /var/lib/grafana
