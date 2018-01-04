FROM resin/rpi-raspbian

RUN apt-get update \
    && apt-get install -y git anacron sendmail \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/vkoop/simple-server-backup.git /backup-script

RUN rm /etc/cron.daily/*
COPY ./backup_daily /etc/cron.daily/

RUN mkdir -p /usr/local/bin

COPY entrypoint.sh /usr/local/bin/

COPY anacron-runner.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]

CMD ["anacron"]
