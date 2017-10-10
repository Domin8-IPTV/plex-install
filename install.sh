#!/bin/bash
apt-get update
apt-get install unrar-free git-core openssl libssl-dev python2.7 -y
wget https://downloads.plex.tv/plex-media-server/1.9.4.4325-1bf240a65/plexmediaserver_1.9.4.4325-1bf240a65_amd64.deb
dpkg -i plexmediaserver_1.9.4.4325-1bf240a65_amd64.deb
mkdir -p /home/plex/
chown -R plex:plex /home/plex/
chmod -R 777 /home/plex/
apt-get install squid -y
service squid stop
mv /etc/squid/squid.conf /etc/squid/squid.bak
wget "https://gist.githubusercontent.com/random-robbie/9e054b61fda3f33f1360/raw/b6220bfa2d451615c34348f2c20768390c8b1896/squid.conf" -O /etc/squid/squid.conf
service squid start
touch /var/log/deluged.log
touch /var/log/deluge-web.log
chown plex:plex /var/log/deluge*
apt-get install deluged -y
apt-get install deluge-webui -y
wget "https://gist.githubusercontent.com/random-robbie/67cf79d3b44eecd15f11245c6b8e3ea4/raw/08b98a5d5f6dd81f88924f62f15609c58e83d83a/deluged.service" -O /etc/systemd/system/deluged.service
wget "https://gist.githubusercontent.com/random-robbie/757b776c85a582551e8cd80708cb1af8/raw/59cea349da1c7637143a26ae696672edc44f0c42/deluge-web.service" -O /etc/systemd/system/deluge-web.service
systemctl enable deluged
systemctl start deluged
systemctl enable deluge-web
systemctl start deluge-web
curl https://raw.githubusercontent.com/SickRage/SickRage/master/contrib/debian-ubuntu-install.sh | sudo bash
