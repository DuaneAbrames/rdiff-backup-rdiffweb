#!/usr/bin/env bash

CRONJOB=/cron/cronjob

echo "${CRON_PATTERN} /usr/local/bin/rdiff-backup backup --compression /source/ /backups/" > $CRONJOB
# Suppression de cette ligne car rdifweb se charge de virer les anciens increments
# C'est rdiffweb qui doit s'en charger
#echo "${CRON_PATTERN} /usr/bin/rdiff-backup -v2 --force --remove-older-than "${REMOVE_OLDER_THAN:-1M}" /backup" >> $CRON_FOLDER/cronjob

echo "" >> $CRONJOB
chmod 0644 $CRONJOB
crontab $CRONJOB
