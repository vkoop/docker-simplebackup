FROM resin/rpi-raspbian

RUN apt-get update \
    && apt-get install -y git anacron rsync openssh-client \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./simple-server-backup /backup-script

RUN rm /etc/cron.daily/*
COPY ./backup_daily /etc/cron.daily/

COPY entrypoint.sh /usr/local/bin/

COPY anacron-runner.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]

CMD ["anacron"]
