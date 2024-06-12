#!/bin/bash
set -e

echo "Pinging 172.130.10.10..."
ping -c 4 172.130.10.10


REPO=$REPO
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT

echo "Changing to /root/api directory..."
cd /root/api

echo "Removing existing .git directory..."
rm -rf .git


echo "Configuring Git..."
git config --global init.defaultBranch master
git config --global http.sslverify false
git init
git remote add origin ${REPO}
git branch -m master
git pull origin master


echo "Modifying .env file..."
sed -i "s/127.0.0.1/${DB_HOST}/g" .env
sed -i "s/5433/${DB_PORT}/g" .env
cat .env


echo "Installing npm-check-updates..."
npm install -g npm-check-updates

echo "Installing npm dependencies..."
npm install --force

echo "Installing @nestjs/common..."
npm install @nestjs/common



echo "Starting the server..."
npm run start dev
echo "si no sale esq ue ha ocurrido un error"


echo "Keeping the container running..."
tail -f /dev/null

