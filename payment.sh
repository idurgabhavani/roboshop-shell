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

dnf install python36 gcc python3-devel -y

useradd roboshop

mkdir /app 

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip

cd /app 

unzip /tmp/payment.zip

cd /app 

pip3.6 install -r requirements.txt

cp /home/ec2/roboshop-shell/payment.service /etc/systemd/system/payment.service

systemctl daemon-reload

systemctl enable payment 

systemctl start payment