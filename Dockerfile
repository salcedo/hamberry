FROM resin/rpi-raspbian:stretch

ADD https://www.release.jtdx.tech/Linux/jtdx-18.1.0-step87_armhf.deb /jtdx.deb
ADD https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz /srv/novnc.tar.gz
ADD https://github.com/novnc/websockify/archive/v0.8.0.tar.gz /srv/websockify.tar.gz

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
	   nginx-light wget curl ca-certificates python-numpy tigervnc-standalone-server \
           apache2-utils supervisor sudo neovim net-tools traceroute lxde gtk2-engines-murrine \
           gtk2-engines-pixbuf gnome-themes-standard traceroute less inetutils-ping \
	   netcat telnet

RUN set -x \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
           chromium-browser qsstv fldigi flrig gpredict xlog trustedqsl openssh-server direwolf xastir \
	   libqt5multimedia5-plugins libqt5serialport5 libfftw3-single3 \
	   libfftw3-double3 libgfortran3 libqt5printsupport5 libusb-1.0-0

RUN set -x \
	&& sed -i 's/:ALL)/) NOPASSWD:/g' /etc/sudoers \
	&& dpkg -i /jtdx.deb \
	&& rm -f /jtdx.deb

RUN set -x \
	&& tar -C /srv -xf /srv/novnc.tar.gz \
	&& mkdir /srv/novnc \
	&& mv /srv/noVNC-*/app /srv/novnc/ \
	&& mv /srv/noVNC-*/core /srv/novnc/ \
	&& mv /srv/noVNC-*/vendor /srv/novnc/ \
	&& rm -rf /srv/noVNC-* /srv/novnc.tar.gz \
	&& tar -C /srv -xf /srv/websockify.tar.gz \
	&& mv /srv/websockify-* /srv/websockify \
	&& rm -f /srv/websockify.tar.gz \
	&& openssl req -x509 -newkey rsa:4096 -days 3650 -nodes \
	   -subj "/C=US/ST=Michigan/L=Detroit/O=Hamberry/OU=NoVNC/CN=Hamberry" \
	   -keyout /etc/ssl/private/hamberry.pem \
	   -out /etc/ssl/certs/hamberry.pem \
	&& chmod 600 /etc/ssl/private/hamberry.pem \
	&& sed -i 's/# server_tokens/server_tokens/' /etc/nginx/nginx.conf

COPY root /

EXPOSE 443

CMD ["/hamberry.sh"]
