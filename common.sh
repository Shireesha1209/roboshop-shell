nodejs(){
  log=/tmp/roboshop.log

  echo -e "\e[36m>>>>>>>>>>> Create ${component} service >>>>>>>>\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Create MongoDb repo >>>>>>>>\e[0m"
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Create MongoDb repo >>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Install NodeJs >>>>>>>>\e[0m"
  yum install nodejs -y &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Create Application User >>>>>>>>\e[0m"
  useradd roboshop &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Create Application directory >>>>>>>>\e[0m"
  rm -rf /app &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Create Application directory >>>>>>>>\e[0m"
  mkdir /app &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Download Application content >>>>>>>>\e[0m"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Extract Application content >>>>>>>>\e[0m"
  cd /app
  unzip /tmp/${component}.zip &>>${log}
  cd /app

  echo -e "\e[36m>>>>>>>>>>> Download NodeJs Dependencies >>>>>>>>\e[0m"
  npm install &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Install Mongo Client >>>>>>>>\e[0m"
  yum install mongodb-org-shell -y &>>${log}

  echo -e "\e[36m>>>>>>>>>>> Load Catalogue schema >>>>>>>>\e[0m"
  mongo --host mongodb.rdevops.online </app/schema/${component}.js &>>${log}

  echo -e "\e[36m>>>>>>>>>>> start catalogue service >>>>>>>>\e[0m"
  systemctl daemon-reload &>>${log}
  systemctl enable ${component} &>>${log}
  systemctl restart ${component} &>>${log}

}