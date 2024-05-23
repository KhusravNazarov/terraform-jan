#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo 'Hello ${enviroment} from the instance' > /var/www/html/index.html