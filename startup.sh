#!/bin/bash


#if [ ! -f /var/lib/mysql/ibdata1 ]; then
#    echo "First time running startup script"
#    mysql_install_db

    /usr/bin/mysqld_safe &
    sleep 10s

    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'mariadb' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -uroot -pmariadb

    #make table structure + database + user
    echo "CREATE DATABASE abookdb;" | mysql -uadmin -pmariadb
    sleep 2s
    echo "USE abookdb; CREATE TABLE addressbook (
      equip_id int(5) NOT NULL AUTO_INCREMENT,
      name varchar(50) DEFAULT NULL,
      address varchar(50) DEFAULT NULL,
      PRIMARY KEY(equip_id)
      );" | mysql -uadmin -pmariadb

    echo "CREATE USER 'phpuser'@'%' IDENTIFIED BY 'password';" | mysql -uadmin -pmariadb
    sleep 2s
    echo "GRANT SELECT, UPDATE, INSERT, DELETE ON abookdb.addressbook TO 'phpuser'@'%'; FLUSH PRIVILEGES;" | mysql -uadmin -pmariadb

    killall mysqld
    sleep 10s
#fi

#/usr/bin/mysqld_safe
