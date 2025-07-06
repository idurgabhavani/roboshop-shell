#!/bin/bash

ID=$(id -u)

CATALOGUE_HOST=catalogue.tejanamana.shop
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

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip

VALIDATE $? " downloaling application "
 
cd /app

unzip /tmp/user.zip

VALIDATE $? "un zipping app directory"

npm install 

VALIDATE $? "installing"

cp /home/ec2/roboshop-shell/user.service/etc/systemd/system/user.service