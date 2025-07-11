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

dnf module disable nodejs -y

VALIDATE $? "disabelling nodejs"

dnf module enable nodejs:18 -y

VALIDATE $? "enableling nodejs"

dnf install nodejs -y

VALIDATE $? "installing node js"

useradd roboshop

VALIDATE $? "user adding"

mkdir /app

VALIDATE $? "creating app directory"

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip

VALIDATE $? "tmp"

cd /app 

unzip /tmp/cart.zip

VALIDATE $? "un zipping the cart"

cd /app 

npm install 

VALIDATE $? "npm installing"

systemctl daemon-reload

VALIDATE $? "reloading"

systemctl enable cart 

VALIDATE $? "renabelling cart"

systemctl start cart

VALIDATE $? "starting cart"