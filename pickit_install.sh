#!/bin/bash

# The MIT License (MIT)
#
# Copyright (c) 2015 Microsoft Azure
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Trent Swanson (Full Scale 180 Inc)
#


help()
{
    echo "This script installs Pickit common packages"
    echo "Parameters:"
    echo "--git_private_key GIT identity private key"
    echo "--git_public_key GIT identity public key"
    echo "--newrelic_license_key NewRelic license key"
    echo "--pickit_postgresql_user"
    echo "--pickit_postgresql_database"
    echo "--pickit_postgresql_host"
    echo "--pickit_postgresql_port"
    echo "--pickit_postgresql_password"
    echo "--pickit_postgresql_replica_user"
    echo "--pickit_postgresql_replica_database"
    echo "--pickit_postgresql_replica_host"
    echo "--pickit_postgresql_replica_port"
    echo "--pickit_postgresql_replica_password"
    echo "--pickit_azure_account_name"
    echo "--pickit_azure_account_key"
    echo "--pickit_azure_public_container"
    echo "--pickit_azure_private_container"
    echo "--pickit_email_host_user"
    echo "--pickit_email_host_password"
    echo "--pickit_email_port"
    echo "--pickit_twitter_consumer_key"
    echo "--pickit_twitter_consumer_secret"
    echo "--pickit_facebook_app_id"
    echo "--pickit_facebook_api_secret"
    echo "--pickit_linkedin_consumer_key"
    echo "--pickit_linkedin_consumer_secret"
    echo "--pickit_google_oauth2_client_id"
    echo "--pickit_google_oauth2_client_secret"
    echo "--pickit_paypal_application_id"
    echo "--pickit_paypal_user_id"
    echo "--pickit_paypal_password"
    echo "--pickit_paypal_signature"
    echo "--pickit_payex_encryption_key"
    echo "--pickit_payex_merchant_account"
    echo "--pickit_celery_broker_url"
    echo "--pickit_crowd_flower_api_key_local"
    echo "--pickit_crowd_flower_api_key"
    echo "--pickit_redis_url"
    echo "--pickit_mixpanel_token"
    echo "--pickit_powerpoint_user"
    echo "--pickit_orbeus_api_key"
    echo "--pickit_orbeus_api_secret"
    echo "--pickit_shutterstock_api_client"
    echo "--pickit_shutterstock_api_secret"
    echo "--pickit_stripe_public_ley_sandbox"
    echo "--pickit_stripe_secret_key_sandbox"
    echo "--pickit_stripe_public_key"
    echo "--pickit_stripe_secret_key"
    echo "--pickit_mobile_service_token"
    echo "--pickit_bing_translate_client_id"
    echo "--pickit_bing_translate_client_secret"
    echo "--pickit_new_relic_account_id"
    echo "--pickit_new_relic_insights_key"
    echo "--pickit_azure_moderation_subscription_id"
    echo "--pickit_vatlayer_access_key"
    echo "--pickit_vatlayer_access_dev_key"
    echo "--pickit_vision_api_key"
    echo "--pickit_cms_postgresql_user"
    echo "--pickit_cms_postgresql_database"
    echo "--pickit_cms_postgresql_host"
    echo "--pickit_cms_postgresql_port"
    echo "--pickit_cms_postgresql_password"
    echo "--pickit_cms_postgresql_replica_user"
    echo "--pickit_cms_postgresql_replica_database"
    echo "--pickit_cms_postgresql_replica_host"
    echo "--pickit_cms_postgresql_replica_port"
    echo "--pickit_cms_postgresql_replica_password"
    echo "--pickit_env"
    echo "--django_settings_module"
    echo "--clarifai_app_id"
    echo "--clarifai_app_secret"
}

# Log method to control/redirect log output
log()
{
    # If you want to enable this logging add a un-comment the line below and add your account id
    #curl -X POST -H "content-type:text/plain" --data-binary "${HOSTNAME} - $1" https://logs-01.loggly.com/inputs/<key>/tag/es-extension,${HOSTNAME}
    echo "$1"
}

NEWRELIC_LICENSE_KEY=""
GIT_PRIVATE_KEY=""
GIT_PUBLIC_KEY=""
PICKIT_POSTGRESQL_USER=""
PICKIT_POSTGRESQL_DATABASE=""
PICKIT_POSTGRESQL_HOST=""
PICKIT_POSTGRESQL_PORT=""
PICKIT_POSTGRESQL_PASSWORD=""
PICKIT_POSTGRESQL_REPLICA_USER=""
PICKIT_POSTGRESQL_REPLICA_DATABASE=""
PICKIT_POSTGRESQL_REPLICA_HOST=""
PICKIT_POSTGRESQL_REPLICA_PORT=""
PICKIT_POSTGRESQL_REPLICA_PASSWORD=""
PICKIT_AZURE_ACCOUNT_NAME=""
PICKIT_AZURE_ACCOUNT_KEY=""
PICKIT_AZURE_PUBLIC_CONTAINER=""
PICKIT_AZURE_PRIVATE_CONTAINER=""
PICKIT_EMAIL_HOST_USER=""
PICKIT_EMAIL_HOST_PASSWORD=""
PICKIT_EMAIL_PORT=""
PICKIT_TWITTER_CONSUMER_KEY=""
PICKIT_TWITTER_CONSUMER_SECRET=""
PICKIT_FACEBOOK_APP_ID=""
PICKIT_FACEBOOK_API_SECRET=""
PICKIT_LINKEDIN_CONSUMER_KEY=""
PICKIT_LINKEDIN_CONSUMER_SECRET=""
PICKIT_GOOGLE_OAUTH2_CLIENT_ID=""
PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET=""
PICKIT_PAYPAL_APPLICATION_ID=""
PICKIT_PAYPAL_USERID=""
PICKIT_PAYPAL_PASSWORD=""
PICKIT_PAYPAL_SIGNATURE=""
PICKIT_PAYEX_ENCRYPTION_KEY=""
PICKIT_PAYEX_MERCHANT_ACCOUNT=""
PICKIT_CELERY_BROKER_URL=""
PICKIT_CROWD_FLOWER_API_KEY_LOCAL=""
PICKIT_CROWD_FLOWER_API_KEY=""
PICKIT_REDIS_URL=""
PICKIT_MIXPANEL_TOKEN=""
PICKIT_POWERPOINT_USER=""
PICKIT_ORBEUS_API_KEY=""
PICKIT_ORBEUS_API_SECRET=""
PICKIT_SHUTTERSTOCK_API_CLIENT=""
PICKIT_SHUTTERSTOCK_API_SECRET=""
PICKIT_STRIPE_PUBLIC_KEY_SANDBOX=""
PICKIT_STRIPE_SECRET_KEY_SANDBOX=""
PICKIT_STRIPE_PUBLIC_KEY=""
PICKIT_STRIPE_SECRET_KEY=""
PICKIT_MOBILE_SERVICE_TOKEN=""
PICKIT_BING_TRANSLATE_CLIENT_ID=""
PICKIT_BING_TRANSLATE_CLIENT_SECRET=""
PICKIT_NEW_RELIC_ACCOUNT_ID=""
PICKIT_NEW_RELIC_INSIGHTS_KEY=""
PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID=""
PICKIT_VATLAYER_ACCESS_KEY=""
PICKIT_VATLAYER_ACCESS_DEV_KEY=""
PICKIT_VISION_API_KEY=""
PICKIT_CMS_POSTGRESQL_USER=""
PICKIT_CMS_POSTGRESQL_DATABASE=""
PICKIT_CMS_POSTGRESQL_HOST=""
PICKIT_CMS_POSTGRESQL_PORT=""
PICKIT_CMS_POSTGRESQL_PASSWORD=""
PICKIT_CMS_POSTGRESQL_REPLICA_USER=""
PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE=""
PICKIT_CMS_POSTGRESQL_REPLICA_HOST=""
PICKIT_CMS_POSTGRESQL_REPLICA_PORT=""
PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD=""
PICKIT_ENV=""
DJANGO_SETTINGS_MODULE=""
CLARIFAI_APP_ID=""
CLARIFAI_APP_SECRET=""

OPTS=`getopt -o h --long "newrelic_license_key::,git_private_key::,git_public_key::,pickit_postgresql_user::,pickit_postgresql_database::,pickit_postgresql_host::,pickit_postgresql_port::,pickit_postgresql_password::,pickit_postgresql_replica_user::,pickit_postgresql_replica_database::,pickit_postgresql_replica_host::,pickit_postgresql_replica_port::,pickit_postgresql_replica_password::,pickit_azure_account_name::,pickit_azure_account_key::,pickit_azure_public_container::,pickit_azure_private_container::,pickit_email_host_user::,pickit_email_host_password::,pickit_email_port::,pickit_twitter_consumer_key::,pickit_twitter_consumer_secret::,pickit_facebook_app_id::,pickit_facebook_api_secret::,pickit_linkedin_consumer_key::,pickit_linkedin_consumer_secret::,pickit_google_oauth2_client_id::,pickit_google_oauth2_client_secret::,pickit_paypal_application_id::,pickit_paypal_userid::,pickit_paypal_password::,pickit_paypal_signature::,pickit_payex_encryption_key::,pickit_payex_merchant_account::,pickit_celery_broker_url::,pickit_crowd_flower_api_key_local::,pickit_crowd_flower_api_key::,pickit_redis_url::,pickit_mixpanel_token::,pickit_powerpoint_user::,pickit_orbeus_api_key::,pickit_orbeus_api_secret::,pickit_shutterstock_api_client::,pickit_shutterstock_api_secret::,pickit_stripe_public_key_sandbox::,pickit_stripe_secret_key_sandbox::,pickit_stripe_public_key::,pickit_stripe_secret_key::,pickit_mobile_service_token::,pickit_bing_translate_client_id::,pickit_bing_translate_client_secret::,pickit_new_relic_account_id::,pickit_new_relic_insights_key::,pickit_azure_moderation_subscription_id::,pickit_vatlayer_access_key::,pickit_vatlayer_access_dev_key::,pickit_vision_api_key::,pickit_cms_postgresql_user::,pickit_cms_postgresql_database::,pickit_cms_postgresql_host::,pickit_cms_postgresql_port::,pickit_cms_postgresql_password::,pickit_cms_postgresql_replica_user::,pickit_cms_postgresql_replica_database::,pickit_cms_postgresql_replica_host::,pickit_cms_postgresql_replica_port::,pickit_cms_postgresql_replica_password::,pickit_env::,django_settings_module::,clarifai_app_id::,clarifai_app_secret::,help::" -n 'pickit_install' -- "$@"`

# OPTS=`getopt --long newrelic_license_key:,git_private_key::,git_public_key::,help:: -n 'pickit_install' -- "$@"`

echo "$OPTS"
eval set -- "$OPTS"

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

while true ; do
    case "$1" in
        --newrelic_license_key ) NEWRELIC_LICENSE_KEY=$2; shift; shift ;;
        --git_private_key ) GIT_PRIVATE_KEY=$2; shift; shift ;;
        --git_public_key ) GIT_PUBLIC_KEY=$2; shift; shift ;;
        --pickit_postgresql_user ) PICKIT_POSTGRESQL_USER=$2; shift; shift ;;
        --pickit_postgresql_database ) PICKIT_POSTGRESQL_DATABASE=$2; shift; shift ;;
        --pickit_postgresql_host ) PICKIT_POSTGRESQL_HOST=$2; shift; shift ;;
        --pickit_postgresql_port ) PICKIT_POSTGRESQL_PORT=$2; shift; shift ;;
        --pickit_postgresql_password ) PICKIT_POSTGRESQL_PASSWORD=$2; shift; shift ;;
        --pickit_postgresql_replica_user ) PICKIT_POSTGRESQL_REPLICA_USER=$2; shift; shift ;;
        --pickit_postgresql_replica_database ) PICKIT_POSTGRESQL_REPLICA_DATABASE=$2; shift; shift ;;
        --pickit_postgresql_replica_host ) PICKIT_POSTGRESQL_REPLICA_HOST=$2; shift; shift ;;
        --pickit_postgresql_replica_port ) PICKIT_POSTGRESQL_REPLICA_PORT=$2; shift; shift ;;
        --pickit_postgresql_replica_password ) PICKIT_POSTGRESQL_REPLICA_PASSWORD=$2; shift; shift ;;
        --pickit_azure_account_name ) PICKIT_AZURE_ACCOUNT_NAME=$2; shift; shift ;;
        --pickit_azure_account_key ) PICKIT_AZURE_ACCOUNT_KEY=$2; shift; shift ;;
        --pickit_azure_public_container ) PICKIT_AZURE_PUBLIC_CONTAINER=$2; shift; shift ;;
        --pickit_azure_private_container ) PICKIT_AZURE_PRIVATE_CONTAINER=$2; shift; shift ;;
        --pickit_email_host_user ) PICKIT_EMAIL_HOST_USER=$2; shift; shift ;;
        --pickit_email_host_password ) PICKIT_EMAIL_HOST_PASSWORD=$2; shift; shift ;;
        --pickit_email_port ) PICKIT_EMAIL_PORT=$2; shift; shift ;;
        --pickit_twitter_consumer_key ) PICKIT_TWITTER_CONSUMER_KEY=$2; shift; shift ;;
        --pickit_twitter_consumer_secret ) PICKIT_TWITTER_CONSUMER_SECRET=$2; shift; shift ;;
        --pickit_facebook_app_id ) PICKIT_FACEBOOK_APP_ID=$2; shift; shift ;;
        --pickit_facebook_api_secret ) PICKIT_FACEBOOK_API_SECRET=$2; shift; shift ;;
        --pickit_linkedin_consumer_key ) PICKIT_LINKEDIN_CONSUMER_KEY=$2; shift; shift ;;
        --pickit_linkedin_consumer_secret ) PICKIT_LINKEDIN_CONSUMER_SECRET=$2; shift; shift ;;
        --pickit_google_oauth2_client_id ) PICKIT_GOOGLE_OAUTH2_CLIENT_ID=$2; shift; shift ;;
        --pickit_google_oauth2_client_secret ) PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET=$2; shift; shift ;;
        --pickit_paypal_application_id ) PICKIT_PAYPAL_APPLICATION_ID=$2; shift; shift ;;
        --pickit_paypal_userid ) PICKIT_PAYPAL_USERID=$2; shift; shift ;;
        --pickit_paypal_password ) PICKIT_PAYPAL_PASSWORD=$2; shift; shift ;;
        --pickit_paypal_signature ) PICKIT_PAYPAL_SIGNATURE=$2; shift; shift ;;
        --pickit_payex_encryption_key ) PICKIT_PAYEX_ENCRYPTION_KEY=$2; shift; shift ;;
        --pickit_payex_merchant_account ) PICKIT_PAYEX_MERCHANT_ACCOUNT=$2; shift; shift ;;
        --pickit_celery_broker_url ) PICKIT_CELERY_BROKER_URL=$2; shift; shift ;;
        --pickit_crowd_flower_api_key_local ) PICKIT_CROWD_FLOWER_API_KEY_LOCAL=$2; shift; shift ;;
        --pickit_crowd_flower_api_key ) PICKIT_CROWD_FLOWER_API_KEY=$2; shift; shift ;;
        --pickit_redis_url ) PICKIT_REDIS_URL=$2; shift; shift ;;
        --pickit_mixpanel_token ) PICKIT_MIXPANEL_TOKEN=$2; shift; shift ;;
        --pickit_powerpoint_user ) PICKIT_POWERPOINT_USER=$2; shift; shift ;;
        --pickit_orbeus_api_key ) PICKIT_ORBEUS_API_KEY=$2; shift; shift ;;
        --pickit_orbeus_api_secret ) PICKIT_ORBEUS_API_SECRET=$2; shift; shift ;;
        --pickit_shutterstock_api_client ) PICKIT_SHUTTERSTOCK_API_CLIENT=$2; shift; shift ;;
        --pickit_shutterstock_api_secret ) PICKIT_SHUTTERSTOCK_API_SECRET=$2; shift; shift ;;
        --pickit_stripe_public_key_sandbox ) PICKIT_STRIPE_PUBLIC_KEY_SANDBOX=$2; shift; shift ;;
        --pickit_stripe_secret_key_sandbox ) PICKIT_STRIPE_SECRET_KEY_SANDBOX=$2; shift; shift ;;
        --pickit_stripe_public_key ) PICKIT_STRIPE_PUBLIC_KEY=$2; shift; shift ;;
        --pickit_stripe_secret_key ) PICKIT_STRIPE_SECRET_KEY=$2; shift; shift ;;
        --pickit_mobile_service_token ) PICKIT_MOBILE_SERVICE_TOKEN=$2; shift; shift ;;
        --pickit_bing_translate_client_id ) PICKIT_BING_TRANSLATE_CLIENT_ID=$2; shift; shift ;;
        --pickit_bing_translate_client_secret ) PICKIT_BING_TRANSLATE_CLIENT_SECRET=$2; shift; shift ;;
        --pickit_new_relic_account_id ) PICKIT_NEW_RELIC_ACCOUNT_ID=$2; shift; shift ;;
        --pickit_new_relic_insights_key ) PICKIT_NEW_RELIC_INSIGHTS_KEY=$2; shift; shift ;;
        --pickit_azure_moderation_subscription_id ) PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID=$2; shift; shift ;;
        --pickit_vatlayer_access_key ) PICKIT_VATLAYER_ACCESS_KEY=$2; shift; shift ;;
        --pickit_vatlayer_access_dev_key ) PICKIT_VATLAYER_ACCESS_DEV_KEY=$2; shift; shift ;;
        --pickit_vision_api_key ) PICKIT_VISION_API_KEY=$2; shift; shift ;;
        --pickit_cms_postgresql_user ) PICKIT_CMS_POSTGRESQL_USER=$2; shift; shift ;;
        --pickit_cms_postgresql_database ) PICKIT_CMS_POSTGRESQL_DATABASE=$2; shift; shift ;;
        --pickit_cms_postgresql_host ) PICKIT_CMS_POSTGRESQL_HOST=$2; shift; shift ;;
        --pickit_cms_postgresql_port ) PICKIT_CMS_POSTGRESQL_PORT=$2; shift; shift ;;
        --pickit_cms_postgresql_password ) PICKIT_CMS_POSTGRESQL_PASSWORD=$2; shift; shift ;;
        --pickit_cms_postgresql_replica_user ) PICKIT_CMS_POSTGRESQL_REPLICA_USER=$2; shift; shift ;;
        --pickit_cms_postgresql_replica_database ) PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE=$2; shift; shift ;;
        --pickit_cms_postgresql_replica_host ) PICKIT_CMS_POSTGRESQL_REPLICA_HOST=$2; shift; shift ;;
        --pickit_cms_postgresql_replica_port ) PICKIT_CMS_POSTGRESQL_REPLICA_PORT=$2; shift; shift ;;
        --pickit_cms_postgresql_replica_password ) PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD=$2; shift; shift ;;
        --pickit_env ) PICKIT_ENV=$2; shift; shift ;;
        --django_settings_module ) DJANGO_SETTINGS_MODULE=$2; shift; shift ;;
        --clarifai_app_id ) CLARIFAI_APP_ID=$2; shift; shift ;;
        --clarifai_app_secret ) CLARIFAI_APP_SECRET=$2; shift; shift ;;
        --help )    HELP=$2; shift ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

if [ $HELP ]
then
help
exit 0
fi

git_public_key=${GIT_PUBLIC_KEY//"++++"/" "};
git_private_key=${GIT_PRIVATE_KEY//"++++"/" "};

echo "NEWRELIC_LICENSE_KEY: $NEWRELIC_LICENSE_KEY";
echo "PICKIT_POSTGRESQL_USER: ${PICKIT_POSTGRESQL_USER}";
echo "PICKIT_POSTGRESQL_DATABASE: ${PICKIT_POSTGRESQL_DATABASE}";
echo "PICKIT_POSTGRESQL_HOST: ${PICKIT_POSTGRESQL_HOST}";
echo "PICKIT_POSTGRESQL_PORT: ${PICKIT_POSTGRESQL_PORT}";
echo "PICKIT_POSTGRESQL_PASSWORD: ${PICKIT_POSTGRESQL_PASSWORD}";
echo "PICKIT_POSTGRESQL_REPLICA_USER: ${PICKIT_POSTGRESQL_REPLICA_USER}";
echo "PICKIT_POSTGRESQL_REPLICA_DATABASE: ${PICKIT_POSTGRESQL_REPLICA_DATABASE}";
echo "PICKIT_POSTGRESQL_REPLICA_HOST: ${PICKIT_POSTGRESQL_REPLICA_HOST}";
echo "PICKIT_POSTGRESQL_REPLICA_PORT: ${PICKIT_POSTGRESQL_REPLICA_PORT}";
echo "PICKIT_POSTGRESQL_REPLICA_PASSWORD: ${PICKIT_POSTGRESQL_REPLICA_PASSWORD}";
echo "PICKIT_AZURE_ACCOUNT_NAME: ${PICKIT_AZURE_ACCOUNT_NAME}";
echo "PICKIT_AZURE_ACCOUNT_KEY: ${PICKIT_AZURE_ACCOUNT_KEY}";
echo "PICKIT_AZURE_PUBLIC_CONTAINER: ${PICKIT_AZURE_PUBLIC_CONTAINER}";
echo "PICKIT_AZURE_PRIVATE_CONTAINER: ${PICKIT_AZURE_PRIVATE_CONTAINER}";
echo "PICKIT_EMAIL_HOST_USER: ${PICKIT_EMAIL_HOST_USER}";
echo "PICKIT_EMAIL_HOST_PASSWORD: ${PICKIT_EMAIL_HOST_PASSWORD}";
echo "PICKIT_EMAIL_PORT: ${PICKIT_EMAIL_PORT}";
echo "PICKIT_TWITTER_CONSUMER_KEY: ${PICKIT_TWITTER_CONSUMER_KEY}";
echo "PICKIT_TWITTER_CONSUMER_SECRET: ${PICKIT_TWITTER_CONSUMER_SECRET}";
echo "PICKIT_FACEBOOK_APP_ID: ${PICKIT_FACEBOOK_APP_ID}";
echo "PICKIT_FACEBOOK_API_SECRET: ${PICKIT_FACEBOOK_API_SECRET}";
echo "PICKIT_LINKEDIN_CONSUMER_KEY: ${PICKIT_LINKEDIN_CONSUMER_KEY}";
echo "PICKIT_LINKEDIN_CONSUMER_SECRET: ${PICKIT_LINKEDIN_CONSUMER_SECRET}";
echo "PICKIT_GOOGLE_OAUTH2_CLIENT_ID: ${PICKIT_GOOGLE_OAUTH2_CLIENT_ID}";
echo "PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET: ${PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET}";
echo "PICKIT_PAYPAL_APPLICATION_ID: ${PICKIT_PAYPAL_APPLICATION_ID}";
echo "PICKIT_PAYPAL_USERID: ${PICKIT_PAYPAL_USERID}";
echo "PICKIT_PAYPAL_PASSWORD: ${PICKIT_PAYPAL_PASSWORD}";
echo "PICKIT_PAYPAL_SIGNATURE: ${PICKIT_PAYPAL_SIGNATURE}";
echo "PICKIT_PAYEX_ENCRYPTION_KEY: ${PICKIT_PAYEX_ENCRYPTION_KEY}";
echo "PICKIT_PAYEX_MERCHANT_ACCOUNT: ${PICKIT_PAYEX_MERCHANT_ACCOUNT}";
echo "PICKIT_CELERY_BROKER_URL: ${PICKIT_CELERY_BROKER_URL}";
echo "PICKIT_CROWD_FLOWER_API_KEY_LOCAL: ${PICKIT_CROWD_FLOWER_API_KEY_LOCAL}";
echo "PICKIT_CROWD_FLOWER_API_KEY: ${PICKIT_CROWD_FLOWER_API_KEY}";
echo "PICKIT_REDIS_URL: ${PICKIT_REDIS_URL}";
echo "PICKIT_MIXPANEL_TOKEN: ${PICKIT_MIXPANEL_TOKEN}";
echo "PICKIT_POWERPOINT_USER: ${PICKIT_POWERPOINT_USER}";
echo "PICKIT_ORBEUS_API_KEY: ${PICKIT_ORBEUS_API_KEY}";
echo "PICKIT_ORBEUS_API_SECRET: ${PICKIT_ORBEUS_API_SECRET}";
echo "PICKIT_SHUTTERSTOCK_API_CLIENT: ${PICKIT_SHUTTERSTOCK_API_CLIENT}";
echo "PICKIT_SHUTTERSTOCK_API_SECRET: ${PICKIT_SHUTTERSTOCK_API_SECRET}";
echo "PICKIT_STRIPE_PUBLIC_KEY_SANDBOX: ${PICKIT_STRIPE_PUBLIC_KEY_SANDBOX}";
echo "PICKIT_STRIPE_SECRET_KEY_SANDBOX: ${PICKIT_STRIPE_SECRET_KEY_SANDBOX}";
echo "PICKIT_STRIPE_PUBLIC_KEY: ${PICKIT_STRIPE_PUBLIC_KEY}";
echo "PICKIT_STRIPE_SECRET_KEY: ${PICKIT_STRIPE_SECRET_KEY}";
echo "PICKIT_MOBILE_SERVICE_TOKEN: ${PICKIT_MOBILE_SERVICE_TOKEN}";
echo "PICKIT_BING_TRANSLATE_CLIENT_ID: ${PICKIT_BING_TRANSLATE_CLIENT_ID}";
echo "PICKIT_BING_TRANSLATE_CLIENT_SECRET: ${PICKIT_BING_TRANSLATE_CLIENT_SECRET}";
echo "PICKIT_NEW_RELIC_ACCOUNT_ID: ${PICKIT_NEW_RELIC_ACCOUNT_ID}";
echo "PICKIT_NEW_RELIC_INSIGHTS_KEY: ${PICKIT_NEW_RELIC_INSIGHTS_KEY}";
echo "PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID: ${PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID}";
echo "PICKIT_VATLAYER_ACCESS_KEY: ${PICKIT_VATLAYER_ACCESS_KEY}";
echo "PICKIT_VATLAYER_ACCESS_DEV_KEY: ${PICKIT_VATLAYER_ACCESS_DEV_KEY}";
echo "PICKIT_VISION_API_KEY: ${PICKIT_VISION_API_KEY}";
echo "PICKIT_CMS_POSTGRESQL_USER: ${PICKIT_CMS_POSTGRESQL_USER}";
echo "PICKIT_CMS_POSTGRESQL_DATABASE: ${PICKIT_CMS_POSTGRESQL_DATABASE}";
echo "PICKIT_CMS_POSTGRESQL_HOST: ${PICKIT_CMS_POSTGRESQL_HOST}";
echo "PICKIT_CMS_POSTGRESQL_PORT: ${PICKIT_CMS_POSTGRESQL_PORT}";
echo "PICKIT_CMS_POSTGRESQL_PASSWORD: ${PICKIT_CMS_POSTGRESQL_PASSWORD}";
echo "PICKIT_CMS_POSTGRESQL_REPLICA_USER: ${PICKIT_CMS_POSTGRESQL_REPLICA_USER}";
echo "PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE: ${PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE}";
echo "PICKIT_CMS_POSTGRESQL_REPLICA_HOST: ${PICKIT_CMS_POSTGRESQL_REPLICA_HOST}";
echo "PICKIT_CMS_POSTGRESQL_REPLICA_PORT: ${PICKIT_CMS_POSTGRESQL_REPLICA_PORT}";
echo "PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD: ${PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD}";
echo "PICKIT_ENV: ${PICKIT_ENV}";
echo "DJANGO_SETTINGS_MODULE: ${DJANGO_SETTINGS_MODULE}";
echo "CLARIFAI_APP_ID: ${CLARIFAI_APP_ID}";
echo "CLARIFAI_APP_SECRET: ${CLARIFAI_APP_SECRET}";


if [ "${UID}" -ne 0 ];
then
    log "Script executed without root permissions"
    echo "You must be root to run this program." >&2
    exit 3
fi

# TEMP FIX - Re-evaluate and remove when possible
# This is an interim fix for hostname resolution in current VM
grep -q "${HOSTNAME}" /etc/hosts
if [ $? == 0 ]
then
  echo "${HOSTNAME}found in /etc/hosts"
else
  echo "${HOSTNAME} not found in /etc/hosts"
  # Append it to the hsots file if not there
  echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts
  log "hostname ${HOSTNAME} added to /etchosts"
fi

apt-get install phantomjs -y > /dev/null
log "** phantomjs **"
apt-get install binutils libproj-dev gdal-bin -y > /dev/null
log "** binutils **"
apt-get install lynx-cur -y > /dev/null
log "** lynx **"
apt-get install uwsgi-plugin-python -y > /dev/null
log "** uwsgi-plugin-python **"
apt-get install nodejs-legacy -y > /dev/null
log "** node **"
apt-get install npm -y > /dev/null
log "** npm **"
npm -g install grunt
npm install -g grunt-cli
npm install -g azure-cli
apt-get install gem -y > /dev/null
log "** gem **"

apt-get install ruby -y > /dev/null
log "** ruby **"
gem update --system
apt-get install ruby-dev -y > /dev/null
log "** ruby-dev **"

echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
apt-get update
apt-get install newrelic-sysmond -y > /dev/null
nrsysmond-config --set license_key=${NEWRELIC_LICENSE_KEY}
log "** newrelic **"

apt-get install traceroute -y > /dev/null
log "** traceroute **"
apt-get install postgresql-client -y > /dev/null
log "** postgresql-client **"
apt-get install apache2-utils -y > /dev/null
log "** apache-utils **"

service newrelic-sysmond start
log "** nerelic-sysmond **"
apt-get install bind9 -y > /dev/null
log "** bind9 **"
apt-get install dnsutils -y > /dev/null
log "** dnsutils **"
apt-get install redis-tools -y > /dev/null
log "** redis-tools **"
apt-get install python-pip -y > /dev/null
log "** python-pip **"

log "** postgresql libpq-dev python-dev **"
sudo apt-get install libpq-dev python-dev -y  /dev/null

log "** GEO spatial **"
sudo apt-get install binutils libproj-dev gdal-bin -y  /dev/null

log "** enchant **"
sudo apt-get install enchant -y  /dev/null

pip install graypy
log "** graypy **"
pip install --upgrade pip
log "** pip **"

apt-get install virtualenv -y > /dev/null
log "** virtualenv **"

runuser -l phme -c 'ssh-keyscan bitbucket.org >> /home/phme/.ssh/known_hosts'
runuser -l phme -c 'ssh-keyscan 104.192.143.1 >> /home/phme/.ssh/known_hosts'
curl -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain
mv git-credential-osxkeychain /usr/local/bin/
chmod u+x /usr/local/bin/git-credential-osxkeychain
git config --global credential.helper osxkeychain
echo -e ${git_private_key} >> /home/phme/.ssh/id_rsa
echo ${git_public_key} >> /home/phme/.ssh/id_rsa.pub
chown phme.phme /home/phme/.ssh/id_rsa
chown phme.phme /home/phme/.ssh/id_rsa.pub
runuser -l phme -c "chmod 600 /home/phme/.ssh/id_rsa"
runuser -l phme -c "chmod 644 /home/phme/.ssh/id_rsa.pub"
sudo ssh-agent /bin/bash
ssh-add /home/phme/.ssh/id_rsa

log "** GIT keyscan and credentials **"

## environment variables. /etc/environment

echo "NEWRELIC_LICENSE_KEY=$NEWRELIC_LICENSE_KEY" >> /etc/environment
echo "PICKIT_POSTGRESQL_USER=$PICKIT_POSTGRESQL_USER" >> /etc/environment
echo "PICKIT_POSTGRESQL_DATABASE=$PICKIT_POSTGRESQL_DATABASE" >> /etc/environment
echo "PICKIT_POSTGRESQL_HOST=$PICKIT_POSTGRESQL_HOST" >> /etc/environment
echo "PICKIT_POSTGRESQL_PORT=$PICKIT_POSTGRESQL_PORT" >> /etc/environment
echo "PICKIT_POSTGRESQL_PASSWORD=$PICKIT_POSTGRESQL_PASSWORD" >> /etc/environment
echo "PICKIT_POSTGRESQL_REPLICA_USER=$PICKIT_POSTGRESQL_REPLICA_USER" >> /etc/environment
echo "PICKIT_POSTGRESQL_REPLICA_DATABASE=$PICKIT_POSTGRESQL_REPLICA_DATABASE" >> /etc/environment
echo "PICKIT_POSTGRESQL_REPLICA_HOST=$PICKIT_POSTGRESQL_REPLICA_HOST" >> /etc/environment
echo "PICKIT_POSTGRESQL_REPLICA_PORT=$PICKIT_POSTGRESQL_REPLICA_PORT" >> /etc/environment
echo "PICKIT_POSTGRESQL_REPLICA_PASSWORD=$PICKIT_POSTGRESQL_REPLICA_PASSWORD" >> /etc/environment
echo "PICKIT_AZURE_ACCOUNT_NAME=$PICKIT_AZURE_ACCOUNT_NAME" >> /etc/environment
echo "PICKIT_AZURE_ACCOUNT_KEY=$PICKIT_AZURE_ACCOUNT_KEY" >> /etc/environment
echo "PICKIT_AZURE_PUBLIC_CONTAINER=$PICKIT_AZURE_PUBLIC_CONTAINER" >> /etc/environment
echo "PICKIT_AZURE_PRIVATE_CONTAINER=$PICKIT_AZURE_PRIVATE_CONTAINER" >> /etc/environment
echo "PICKIT_EMAIL_HOST_USER=$PICKIT_EMAIL_HOST_USER" >> /etc/environment
echo "PICKIT_EMAIL_HOST_PASSWORD=$PICKIT_EMAIL_HOST_PASSWORD" >> /etc/environment
echo "PICKIT_EMAIL_PORT=$PICKIT_EMAIL_PORT" >> /etc/environment
echo "PICKIT_TWITTER_CONSUMER_KEY=$PICKIT_TWITTER_CONSUMER_KEY" >> /etc/environment
echo "PICKIT_TWITTER_CONSUMER_SECRET=$PICKIT_TWITTER_CONSUMER_SECRET" >> /etc/environment
echo "PICKIT_FACEBOOK_APP_ID=$PICKIT_FACEBOOK_APP_ID" >> /etc/environment
echo "PICKIT_FACEBOOK_API_SECRET=$PICKIT_FACEBOOK_API_SECRET" >> /etc/environment
echo "PICKIT_LINKEDIN_CONSUMER_KEY=$PICKIT_LINKEDIN_CONSUMER_KEY" >> /etc/environment
echo "PICKIT_LINKEDIN_CONSUMER_SECRET=$PICKIT_LINKEDIN_CONSUMER_SECRET" >> /etc/environment
echo "PICKIT_GOOGLE_OAUTH2_CLIENT_ID=$PICKIT_GOOGLE_OAUTH2_CLIENT_ID" >> /etc/environment
echo "PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET=$PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET" >> /etc/environment
echo "PICKIT_PAYPAL_APPLICATION_ID=$PICKIT_PAYPAL_APPLICATION_ID" >> /etc/environment
echo "PICKIT_PAYPAL_USERID=$PICKIT_PAYPAL_USERID" >> /etc/environment
echo "PICKIT_PAYPAL_PASSWORD=$PICKIT_PAYPAL_PASSWORD" >> /etc/environment
echo "PICKIT_PAYPAL_SIGNATURE=$PICKIT_PAYPAL_SIGNATURE" >> /etc/environment
echo "PICKIT_PAYEX_ENCRYPTION_KEY=$PICKIT_PAYEX_ENCRYPTION_KEY" >> /etc/environment
echo "PICKIT_PAYEX_MERCHANT_ACCOUNT=$PICKIT_PAYEX_MERCHANT_ACCOUNT" >> /etc/environment
echo "PICKIT_CELERY_BROKER_URL=$PICKIT_CELERY_BROKER_URL" >> /etc/environment
echo "PICKIT_CROWD_FLOWER_API_KEY_LOCAL=$PICKIT_CROWD_FLOWER_API_KEY_LOCAL" >> /etc/environment
echo "PICKIT_CROWD_FLOWER_API_KEY=$PICKIT_CROWD_FLOWER_API_KEY" >> /etc/environment
echo "PICKIT_REDIS_URL=$PICKIT_REDIS_URL" >> /etc/environment
echo "PICKIT_MIXPANEL_TOKEN=$PICKIT_MIXPANEL_TOKEN" >> /etc/environment
echo "PICKIT_POWERPOINT_USER=$PICKIT_POWERPOINT_USER" >> /etc/environment
echo "PICKIT_ORBEUS_API_KEY=PICKIT_ORBEUS_API_KEY" >> /etc/environment
echo "PICKIT_ORBEUS_API_SECRET=$PICKIT_ORBEUS_API_SECRET" >> /etc/environment
echo "PICKIT_SHUTTERSTOCK_API_CLIENT=$PICKIT_SHUTTERSTOCK_API_CLIENT" >> /etc/environment
echo "PICKIT_SHUTTERSTOCK_API_SECRET=$PICKIT_SHUTTERSTOCK_API_SECRET" >> /etc/environment
echo "PICKIT_STRIPE_PUBLIC_KEY_SANDBOX=$PICKIT_STRIPE_PUBLIC_KEY_SANDBOX" >> /etc/environment
echo "PICKIT_STRIPE_SECRET_KEY_SANDBOX=$PICKIT_STRIPE_SECRET_KEY_SANDBOX" >> /etc/environment
echo "PICKIT_STRIPE_PUBLIC_KEY=$PICKIT_STRIPE_PUBLIC_KEY" >> /etc/environment
echo "PICKIT_STRIPE_SECRET_KEY=$PICKIT_STRIPE_SECRET_KEY" >> /etc/environment
echo "PICKIT_MOBILE_SERVICE_TOKEN=$PICKIT_MOBILE_SERVICE_TOKEN" >> /etc/environment
echo "PICKIT_BING_TRANSLATE_CLIENT_ID=$PICKIT_BING_TRANSLATE_CLIENT_ID" >> /etc/environment
echo "PICKIT_BING_TRANSLATE_CLIENT_SECRET=$PICKIT_BING_TRANSLATE_CLIENT_SECRET" >> /etc/environment
echo "PICKIT_NEW_RELIC_ACCOUNT_ID=$PICKIT_NEW_RELIC_ACCOUNT_ID" >> /etc/environment
echo "PICKIT_NEW_RELIC_INSIGHTS_KEY=$PICKIT_NEW_RELIC_INSIGHTS_KEY" >> /etc/environment
echo "PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID=$PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID" >> /etc/environment
echo "PICKIT_VATLAYER_ACCESS_KEY=$PICKIT_VATLAYER_ACCESS_KEY" >> /etc/environment
echo "PICKIT_VATLAYER_ACCESS_DEV_KEY=$PICKIT_VATLAYER_ACCESS_DEV_KEY" >> /etc/environment
echo "PICKIT_VISION_API_KEY=$PICKIT_VISION_API_KEY" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_USER=$PICKIT_CMS_POSTGRESQL_USER" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_DATABASE=$PICKIT_CMS_POSTGRESQL_DATABASE" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_HOST=$PICKIT_CMS_POSTGRESQL_HOST" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_PORT=$PICKIT_CMS_POSTGRESQL_PORT" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_PASSWORD=$PICKIT_CMS_POSTGRESQL_PASSWORD" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_REPLICA_USER=$PICKIT_CMS_POSTGRESQL_REPLICA_USER" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE=$PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_REPLICA_HOST=$PICKIT_CMS_POSTGRESQL_REPLICA_HOST" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_REPLICA_PORT=$PICKIT_CMS_POSTGRESQL_REPLICA_PORT" >> /etc/environment
echo "PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD=$PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD" >> /etc/environment
echo "PICKIT_ENV=$PICKIT_ENV" >> /etc/environment
echo "DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE" >> /etc/environment
echo "CLARIFAI_APP_ID=$CLARIFAI_APP_ID" >> /etc/environment
echo "CLARIFAI_APP_SECRET=$CLARIFAI_APP_SECRET" >> /etc/environment

. /etc/environment

exit 0