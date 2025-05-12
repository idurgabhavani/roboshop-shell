#!/bin/bash

ID=$(id -u)

TIMESTAMPE=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMPE.log"

echo "script   started executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){

    if [$1 -ne 0] 
    then
        echo -e " $2 FAIELD"
    else
        echo -e " $2 SUCCESS"
    fi
}

if [ $ID ne 0 ]
then
    echo " ERROR: please run this script with root access 4N"
    exit 1
else
    echo "you are  root  user"
fi

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "Copy mongo db repo"

dnf install mongodb-org -y &>> $LOGFILE

VALIDATE $? "installing mongodb"






