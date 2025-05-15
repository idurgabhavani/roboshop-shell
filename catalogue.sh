#!/bin/bash

ID=$(id -u)

MONGDB_HOST=mongodb.tejanamana.shop
TIMESTAMPE=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMPE.log"


echo "script   started executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){

    if [ $1 -ne 0 ] 
    then
        echo -e " $2 FAIELD"
    else
        echo -e " $2 SUCCESS"
    fi
}

if [ $ID ne 0 ]
then
    echo -e " ERROR: please run this script with root access 4N"
    exit 1
else
    echo "you are  root  user"
fi

dnf module disable nodejs -y

VALIDATE $? "disablelling"

dnf module enable nodejs:18 -y

VALIDATE $? "enabelling"

dnf install nodejs -y

VALIDATE $? "installing"

useradd roboshop

VALIDATE $? "crating robosheopp user"

mkdir /app

VALIDATE $? "crating app directory"

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip

VALIDATE $? "downloading cataloge application"

cd /app 

VALIDATE $? "cd app"

unzip /tmp/catalogue.zip

VALIDATE $? "un zippng"

cd /app

npm install 

VALIDATE $? "installing depencies"

cp /home/ec2/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

VALIDATE $? "copying"

systemctl daemon-reload

VALIDATE $? "catalogue demon reload"

systemctl enable catalogue

VALIDATE $? "enble catalogue"

systemctl start catalogue

VALIDATE $? "start catalogue"

cp /home/ec2/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

VALIDATE $? "copying"

dnf install mongodb-org-shell -y

VALIDATE $? "instaling mongo db shell clien"

mongo --host $MONGDB_HOST </app/schema/catalogue.js

VALIDATE $? "LOADING CATALOGUE DATE INTO MAGO DB"