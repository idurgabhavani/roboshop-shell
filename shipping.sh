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


dnf install maven -y

VALIDATE $? " installing maven "

useradd roboshop

mkdir /app

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip

VALIDATE $? " downloading application "

cd /app

unzip /tmp/shipping.zip

cd /app

mvn clean package

mv target/shipping-1.0.jar shipping.jar

cp /home/ec2/roboshop-shell/shipping.service /etc/systemd/system/shipping.service

systemctl daemon-reload

systemctl enable shipping 

systemctl enable shipping 

dnf install mysql -y

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql 

systemctl restart shipping