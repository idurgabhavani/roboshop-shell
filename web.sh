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

dnf install nginx -y

VALIDATE $? "installing nginx"

systemctl enable nginx

VALIDATE $? "enabling  nginx"

systemctl start nginx

VALIDATE $? "start  nginx"

rm -rf /usr/share/nginx/html/*

VALIDATE $? "remove dfault website"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip

VALIDATE $? "downloading application"

cd /usr/share/nginx/html

VALIDATE $? "moving to nginx html directory"

unzip -o /tmp/web.zip

VALIDATE $? "unzipping web"

cp /home/ec2/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf 

VALIDATE $? "copy roboshop reverse proxy config"

systemctl restart nginx 

VALIDATE $? "restart nginx"