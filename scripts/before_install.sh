#!/bin/bash

# navigate to app folder

# install node and npm
sudo yum install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash . ~/.nvm/nvm.sh
nvm install node

sudo yum install npm -y
sudo yum install nginx -y
sudo amazon-linux-extras install epel
yum install --enablerepo="epel" ufw
sudo ufw enable
sudo ufw allow 'Nginx HTTP'