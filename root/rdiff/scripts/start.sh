#!/usr/bin/env bash

VERSION="waazaafr/rdiff-backup-rdiffweb:0.0.5"

echo "********************************************************************************************"

################################################################################################
##### If the /app folder does not exist, we create it.
APP_FOLDER=/app
if [ ! -d "$APP_FOLDER" ]; then
    mkdir -p $APP_FOLDER
    chmod -R 0777 $APP_FOLDER
fi

################################################################################################
##### If the /app/include-list.txt file does not exist, we create it.

INCL_FILE=/app/include-list.txt
if [ ! -d "$INCL_FILE" ]; then
    touch $INCL_FILE
    chmod -R 0777 $INCL_FILE
fi

################################################################################################
##### If the /cron folder does not exist, we create it.
CRON_FOLDER=/cron
if [ ! -d "$CRON_FOLDER" ]; then
    mkdir -p $CRON_FOLDER
    chmod -R 0777 $CRON_FOLDER
    #echo "******    ${CRON_FOLDER} created"
fi

################################################################################################
##### If the /app/logs folder does not exist, we create it.
LOGS_FOLDER=/app/logs
if [ ! -d "$LOGS_FOLDER" ]; then
    mkdir -p $LOGS_FOLDER
    chmod -R 0777 $LOGS_FOLDER
    #echo "******    ${LOGS_FOLDER} created"
fi

################################################################################################
##### If rdw.conf does not exist in /app then we create an initial version
RDW_CONF_FILE="$APP_FOLDER/rdw.conf"
if [ ! -f "$RDW_CONF_FILE" ]; then
    cp /rdiff/app/rdw.conf /app
    chmod 0777 "$RDW_CONF_FILE"
    #echo "******    ${RDW_CONF_FILE} created"
fi


################################################################################################
##### If the /app/images folder does not exist, we create it.
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
