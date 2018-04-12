#!/bin/sh
apt-get update
sudo apt-get install openssl libpcre3 procps perl
wget https://github.com/Mashape/kong/releases/download/0.10.3/kong-0.10.3.xenial_all.deb
https://bintray.com/kong/kong-community-edition-deb/download_file?file_path=dists/kong-community-edition-0.11.0.xenial.all.deb
dpkg -i kong-*.deb

