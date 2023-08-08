source common.sh

echo -e "\e[36m>>>>>>>>>>> Install Nginx >>>>>>>>\e[0m"
yum install nginx -y
func_exit_status

echo -e "\e[36m>>>>>>>>>>> Copy Roboshop Configuaration >>>>>>>>\e[0m"
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
func_exit_status

echo -e "\e[36m>>>>>>>>>>> clean old content  >>>>>>>>\e[0m"
rm -rf /usr/share/nginx/html/*
func_exit_status

echo -e "\e[36m>>>>>>>>>>> Download Application content >>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
func_exit_status

cd /usr/share/nginx/html

echo -e "\e[36m>>>>>>>>>>> Extract Application content >>>>>>>>\e[0m"
unzip /tmp/frontend.zip
func_exit_status

echo -e "\e[36m>>>>>>>>>>> Start Nginx service >>>>>>>>\e[0m"
systemctl enable nginx
systemctl restart nginx
func_exit_status


