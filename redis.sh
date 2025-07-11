#!/bin/bash

ID=$(id -u)

MONGDB_HOST=mongodb.tejanamana.shop
TIMESTAMPE=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMPE.log"
exec &>$LOGFILE  #IF ANY ERROR STATEMENT COMMES THIS WILL STORE IN LOGFILE IN ENTIRE PROGRAME


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

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

VALIDATE $? "installing redis"

dnf module enable redis:remi-6.2 -y

VALIDATE $? "enabling redis"

dnf install redis -y

VALIDATE $? "instaling"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf

VALIDATE $? "allowing remote connections"

systemctl enable redis

VALIDATE $? "enkable redis"

systemctl start redis

VALIDATE $? "starting redis"


