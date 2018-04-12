#!/bin/sh
apt-get update
sudo apt-get install openssl libpcre3 procps perl
wget https://bintray.com/kong/kong-community-edition-deb/download_file?file_path=dists/kong-community-edition-0.13.0.trusty.all.deb -O kong-community-edition-0.13.0.trusty.all.deb
dpkg -i kong-0*.deb

