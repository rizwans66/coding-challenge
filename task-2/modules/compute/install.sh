#!/bin/bash
# Update system
sudo yum update -y

# Install Node.js and Git
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs git

# Add MongoDB Repository
echo "[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc" | sudo tee /etc/yum.repos.d/mongodb-org-5.0.repo

# Install MongoDB
sudo yum install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Clone the Node.js To-Do App
cd /home/ec2-user
git clone https://github.com/scotch-io/node-todo.git
cd node-todo

# Install Dependencies
npm install

# Install PM2 for Process Management
sudo npm install -g pm2

# Start the Application Using PM2
pm2 start server.js --name node-todo
pm2 save
pm2 startup systemd