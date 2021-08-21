#!/bin/bash

DIR=$(cd $(dirname $0); pwd)

echo "### Stop webapp ###"
sudo systemctl stop isucondition.go.service

echo "### Build webapp ###"
cd ${DIR}/webapp/go/
if [ -z isucondition ]; then
  rm isucondition
fi

/home/isucon/local/go/bin/go build -o isucondition
cp -f isucondition /home/isucon/webapp/go/


echo "### Start webapp ###"
sudo systemctl daemon-reload
sudo systemctl start isucondition.go.service

echo "### Deploy nginx.conf ###"
sudo cp ${DIR}/nginx.conf /etc/nginx/nginx.conf

echo "### Deploy mysqld.conf ###"
#sudo cp ${DIR}/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

echo "### Reload & restarting systemd ###"
sudo systemctl daemon-reload
sudo systemctl restart nginx.service
#sudo systemctl restart mysql.service

echo "### Rotate log ###"
COMMIT=$(git rev-parse HEAD)
sudo cp /var/log/nginx/access.log /var/log/nginx/access.log.$(date +%s).${COMMIT:0:6}
echo '' | sudo tee /var/log/nginx/access.log
#sudo cp /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$(date +%s).${COMMIT:0:6}
#echo '' | sudo tee /var/log/mysql/mysql-slow.log