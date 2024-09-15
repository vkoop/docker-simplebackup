FROM debian:bookworm-20240904-slim

RUN apt-get update \
    && apt-get install -y git anacron rsync openssh-client \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

ARG CACHEBUST=1 
RUN git clone --recursive https://github.com/vkoop/simple-server-backup.git /backup-script


RUN rm /etc/cron.daily/*
COPY ./backup_daily /etc/cron.daily/
RUN chmod +x /etc/cron.daily/backup_daily

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY anacron-runner.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/anacron-runner.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["anacron"]
