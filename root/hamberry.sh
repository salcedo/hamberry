#!/bin/bash

USER=${USER:-hamberry}
PASSWORD=${PASSWORD:-hamberry}
HOME="/home/${USER}"

useradd -G audio,dialout,sudo -s /bin/bash "${USER}"
chown -R "${USER}:" "${HOME}"

sed -i "s|%USER%|$USER|" /etc/supervisor/conf.d/hamberry.conf
sed -i "s|%HOME%|$HOME|" /etc/supervisor/conf.d/hamberry.conf

chown -R root:audio /dev/snd
chown root:dialout /dev/ttyUSB*

htpasswd -bc /srv/.htpasswd "${USER}" "${PASSWORD}"

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
