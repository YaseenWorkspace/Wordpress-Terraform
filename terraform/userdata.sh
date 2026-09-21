#!/bin/bash

#variables used later in the script
db_name="wordpress"
db_username="wordpressuser"
# In a real-world scenario, you should use a more secure method to handle passwords, such as using AWS Secrets Manager or environment variables. For this example, we will hardcode the password for simplicity.
db_user_password="MyStrongPassword123!"
db_host="localhost"
# Update the system 
dnf update -y
#dnf is the package manager on Amazon Linux 2023 (it replaces yum)
dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel
#MariaDB database server on the instance.
dnf install -y mariadb105-server
#Make Apache automatically start whenever the EC2 machine boots up
systemctl start httpd
systemctl enable httpd

#Start MariaDB and make it start on every boot
systemctl start mariadb
systemctl enable mariadb

wget https://wordpress.org/latest.tar.gz
#Command extracts the zipped file and decompresses it.
tar -xzf latest.tar.gz





#Commands to create the database and user for WordPress
mysql -u root -e "CREATE DATABASE $db_name;"
mysql -u root -e "CREATE USER '$db_username'@'localhost' IDENTIFIED BY '$db_user_password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_username'@'localhost';"


#creates WordPress's configuration file and fills it with the database details WordPress needs to connect to MariaDB
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sed -i "s/database_name_here/$db_name/g" wordpress/wp-config.php
sed -i "s/username_here/$db_username/g" wordpress/wp-config.php
sed -i "s/password_here/$db_user_password/g" wordpress/wp-config.php
sed -i "s/localhost/${db_host}/g" wordpress/wp-config.php

#chown -R httpd:httpd /usr/share/httpd/html
#chmod -R 755 /usr/share/httpd/html

#cp -r wordpress/* /var/www/html/