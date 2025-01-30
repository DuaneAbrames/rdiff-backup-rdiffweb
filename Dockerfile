FROM ubuntu:24.04

ENV APP_NAME="rdiff-backup"
ENV TZ=Europe/Paris
ENV CRON_PATTERN="0 */4 * * *"
ENV BRAND_HEADER_NAME="rdiff-backup-rdiffweb"
ENV EMAIL_HOST="xxxxx"
ENV EMAIL_ENCRYPTION="starttls"
ENV EMAIL_SENDER="xxxxx"
ENV EMAIL_USERNAME="xxxxx"
ENV EMAIL_PASSWORD="xxxxx"


# Installation des paquets de base et de travail
RUN apt-get update && apt-get install -y supervisor build-essential python3-dev python3-setuptools python3-pip
RUN pip3 install --upgrade rdiff-backup rdiffweb

COPY /root /
RUN chmod a+x /rdiff/scripts/*.sh

VOLUME /source
VOLUME /backups
VOLUME /restores

WORKDIR /app

EXPOSE 8080

CMD ["/rdiff/scripts/start.sh"]