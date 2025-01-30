#!/usr/bin/env bash

VERSION="waazaafr/rdiff-backup-rdiffweb:0.0.5"

echo "********************************************************************************************"

################################################################################################
##### Si le dossier /app n'existe pas on le crée
APP_FOLDER=/app
if [ ! -d "$APP_FOLDER" ]; then
    mkdir -p $APP_FOLDER
    chmod -R 0777 $APP_FOLDER
fi

################################################################################################
##### Si le dossier /cron n'existe pas on le crée
CRON_FOLDER=/cron
if [ ! -d "$CRON_FOLDER" ]; then
    mkdir -p $CRON_FOLDER
    chmod -R 0777 $CRON_FOLDER
    #echo "******    ${CRON_FOLDER} created"
fi

################################################################################################
##### Si le dossier /app/logs n'existe pas on le crée
LOGS_FOLDER=/app/logs
if [ ! -d "$LOGS_FOLDER" ]; then
    mkdir -p $LOGS_FOLDER
    chmod -R 0777 $LOGS_FOLDER
    #echo "******    ${LOGS_FOLDER} created"
fi

################################################################################################
##### Si le rdw.conf n'existe pas dans /app alors on mets une version initiale
RDW_CONF_FILE="$APP_FOLDER/rdw.conf"
if [ ! -f "$RDW_CONF_FILE" ]; then
    cp /rdiff/app/rdw.conf /app
    chmod 0777 "$RDW_CONF_FILE"
    #echo "******    ${RDW_CONF_FILE} created"
fi


################################################################################################
##### Si le dossier /app/images n'existe pas on le crée
IMAGES_FOLDER=/app/images
if [ ! -d "$IMAGES_FOLDER" ]; then
    cp -R /rdiff/app/images /app/
    chmod -R 0777 "$IMAGES_FOLDER"
    #echo "******    ${IMAGES_FOLDER} created"
fi

poids_source=$(du -sh /source | cut -f1)
echo "********************************************************************************************"
echo "******    Image:          ${VERSION}"
echo "********************************************************************************************"
echo "******    Timezone:       ${TZ}"
echo "******    Cron pattern:   ${CRON_PATTERN}"
echo "******    /source size:   ${poids_source}"
echo "********************************************************************************************"

brand_header_name=${BRAND_HEADER_NAME}

email_host=${EMAIL_HOST}
email_encryption=${EMAIL_ENCRYPTION}
email_sender=${EMAIL_SENDER}
email_username=${EMAIL_USERNAME}
email_password=${EMAIL_PASSWORD}

sed -e 's/brand-header-name=.*/brand-header-name='"$brand_header_name"'/' -i $RDW_CONF_FILE
sed -e 's/email-host=.*/email-host='"$email_host"'/' -i $RDW_CONF_FILE
sed -e 's/email-encryption=.*/email-encryption='"$email_encryption"'/' -i $RDW_CONF_FILE
sed -e 's/email-sender=.*/email-sender='"$email_sender"'/' -i $RDW_CONF_FILE
sed -e 's/email-username=.*/email-username='"$email_username"'/' -i $RDW_CONF_FILE
sed -e 's/email-password=.*/email-password='"$email_password"'/' -i $RDW_CONF_FILE


/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf