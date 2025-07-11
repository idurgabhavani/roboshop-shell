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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

VALIDATE $? " DOWNLOADING ERLANG SCRIPT"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

VALIDATE $? " DOWNLOADING RABNQ SCRIP"

dnf install rabbitmq-server -y 

VALIDATE $? " INSTALLIG RABIT MQ SERVER"

systemctl enable rabbitmq-server 

VALIDATE $? " ENABLING RABIT MQ "

systemctl start rabbitmq-server 

VALIDATE $? " STARTING RABIT MQ"

rabbitmqctl add_user roboshop roboshop123

VALIDATE $? " CREATING USER"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

VALIDATE $? " SETTING PERMISSIONS "