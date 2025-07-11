#!/bin/bash

ID=$(id -u)


TIMESTAMPE=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMPE.log"
exec &>$LOGFILE

echo "script   started executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){

    if [ $1 -ne 0 ] 
    then
        echo -e " $2 FAIELD"
        exit 1
    else
        echo -e " $2 SUCCESS"
    fi
}

if [ $ID -ne 0 ]
then
    echo -e " ERROR: please run this script with root access 4N"
    exit 1
else
    echo "you are  root  user"
fi

dnf module disable mysql -y

VALIDATE $? " disabelling mysq"

cp mysql.repo /etc/yum.repos.d/mysql.repo

VALIDATE $? " copied mysql repo"

dnf install mysql-community-server -y

VALIDATE $? " installing mysql server"

systemctl enable mysqld

VALIDATE $? " enabling mysql server"

systemctl start mysqld

VALIDATE $? " starting mysql server"

mysql_secure_installation --set-root-pass RoboShop@1

VALIDATE $? " setting password for my sql root server"

