#!/bin/sh
sudo apt-get update
sudo apt-get -y install python-software-properties
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install postgresql-9.4 -y
sleep 3
echo "CREATE ROLE kong LOGIN ENCRYPTED PASSWORD 'kong1234';" | sudo -u postgres psql
echo "CREATE DATABASE kong OWNER kong;" | sudo -u postgres psql
echo "ALTER USER kong WITH SUPERUSER;" | sudo -u postgres psql
echo "ALTER USER kong WITH CREATEDB;" | sudo -u postgres psql
echo "ALTER USER kong WITH CREATEROLE;" | sudo -u postgres psql
sudo echo "listen_addresses = '*'" >> /etc/postgresql/9.4/main/postgresql.conf
echo "host    all             all             0.0.0.0/0                trust" >> /etc/postgresql/9.4/main/pg_hba.conf
sudo /etc/init.d/postgresql restart
