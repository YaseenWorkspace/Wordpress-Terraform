#!/bin/bash

#variables used later in the script
db_name="wordpress"
db_username="wordpressuser"
# In a real-world scenario, you should use a more secure method to handle passwords, such as using AWS Secrets Manager or environment variables. For this example, we will hardcode the password for simplicity.
db_user_password="MyStrongPassword123!"

# Update the system and install necessary packages
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
yum install -y php
yum install -y php-mysql
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

#Installs MariaDB
yum install -y mariadb-server
#Start MariaDB
systemctl start mariadb
systemctl enable mariadb
sed -i "s/database_name_here/$db_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_user_password/g" wp-config.php
sed -i “s/localhost/${DB_HOST}/” wp-config.php

CREATE DATABASE $db_name;
CREATE USER $wordpressuser@’%’ IDENTIFIED BY $MyStrongPassword123;
GRANT ALL PRIVILEGES ON $wordpress.* TO $wpadmin@’%’;
mysql -u $db_username -p"$db_user_password" -e "CREATE DATABASE $db_name;"
EXIT;


chown -R httpd:httpd /usr/share/httpd/html
chmod -R 755 /usr/share/httpd/html

cp -r wordpress/* /var/www/html/