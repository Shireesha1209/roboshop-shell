echo ">>>>>>>>>>> Create catalogue service >>>>>>>>"
cp catalogue.service /etc/systemd/system/catalogue.service
echo ">>>>>>>>>>> Create MongoDb repo >>>>>>>>"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>>>>>>> Install NodeJs repos >>>>>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo ">>>>>>>>>>> Install NodeJs >>>>>>>>"
yum install nodejs -y

echo ">>>>>>>>>>> Create Application User >>>>>>>>"
useradd roboshop

echo ">>>>>>>>>>> Create Application directory >>>>>>>>"
mkdir /app

echo ">>>>>>>>>>> Download Application content >>>>>>>>"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>>>>>>> Extract Application content >>>>>>>>"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo ">>>>>>>>>>> Download NodeJs Dependencies >>>>>>>>"
npm install

echo ">>>>>>>>>>> Install Mongo Client >>>>>>>>"
yum install mongodb-org-shell -y
echo ">>>>>>>>>>> Load Catalogue schema >>>>>>>>"
mongo --host mongodb.rdevops.online </app/schema/catalogue.js

echo ">>>>>>>>>>> start catalogue service >>>>>>>>"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
