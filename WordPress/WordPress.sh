#!/bin/sh
echo "Hello my friends"

echo "Step 1: Update CentOS"

yum -y update

echo "Step 2: Install Apache2"

sudo -y yum install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
iptables -F

echo "Step 3: Install MYSQL"

sudo yum -y install mariadb-server mariadb
sudo systemctl start mariadb

echo "Step 4: Securing MariaDB"

sudo mysql_secure_installation
sudo systemctl enable mariadb.service

echo "Step 5: Install PHP"

sudo yum -y install php php-mysql
sudo systemctl restart httpd.service

echo "Step 6: Update PHP"

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
yum install yum-utils
yum-config-manager --enable remi-php72
yum update -y

echo "Step 7: Install WP"

cd /opt
yum -y install wget unzip
wget http://wordpress.org/latest.zip
yum -y install php-gd

echo "Step 8: WP"

wget https://wordpress.org/latest.zip
unzip latest.zip
rm -rf /var/www/html/*
cp -r WordPres/wordpress/* /var/www/html/  

