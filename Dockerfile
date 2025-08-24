FROM debian:bookworm-slim

  LABEL maintainer="galeanosebastian96@gmail.com"

  ENV DEBIAN_FRONTEND noninteractive

  RUN apt-get -qq -y update; \
    apt-get -qq -y full-upgrade; \
    apt-get -qq -y install icecast2 python3-setuptools sudo cron-apt; \
    apt-get -y autoclean; \
    apt-get clean; \
    chown -R icecast2 /etc/icecast2; \
    chmod 777 /var/log/icecast2/access.log; \
    chmod 777 /var/log/icecast2/error.log ;\
    sed -i 's/ -d//' /etc/cron-apt/action.d/3-download

  CMD ["/start.sh"]
  EXPOSE 20001
  VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]

  ADD ./start.sh /start.sh
  ADD ./etc /etc
