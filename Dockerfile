FROM node:6.9.3
MAINTAINER OpusCapita

# ------------------------
# Azure SSH Server support
# ------------------------

RUN apt update \
    && apt install -y --no-install-recommends openssh-server curl \
    && echo "root:Docker!" | chpasswd

COPY sshd_config /etc/ssh/

COPY init_container.sh /bin/

RUN chmod 755 /bin/init_container.sh

EXPOSE 2222 80

# ------------------------
# App
# ------------------------

RUN mkdir /root/app
WORKDIR /root/app

COPY . /root/app

EXPOSE 3000
EXPOSE 3020

CMD ["/bin/init_container.sh"]