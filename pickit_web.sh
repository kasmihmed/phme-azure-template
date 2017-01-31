#!/usr/bin/env bash

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


"""apt-get install phantomjs -y > /dev/null
apt-get install binutils libproj-dev gdal-bin -y > /dev/null
apt-get install lynx-cur -y > /dev/null
apt-get install uwsgi-plugin-python -y > /dev/null
apt-get install mutt -y > /dev/null
apt-get install npm -y > /dev/null
npm -g install grunt
npm install -g grunt-cli
npm install -g azure-cli
apt-get install nodejs-legacy -y > /dev/null
apt-get install gem -y > /dev/null

apt-get install ruby -y > /dev/null
gem update --system
apt-get install ruby-dev -y > /dev/null

echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
apt-get update
apt-get install newrelic-sysmond -y > /dev/null
nrsysmond-config --set license_key=be51bc4d1c2c5062e18816cb9afac6b7623d8413

apt-get install traceroute -y > /dev/null
apt-get install postgresql-client -y > /dev/null

service newrelic-sysmond start
apt-get install bind9 -y > /dev/null
apt-get install dnsutils -y > /dev/null
apt-get install redis-tools -y > /dev/null
apt-get install python-pip -y > /dev/null

pip install graypy
pip install --upgrade pip

apt-get install virtualenv -y > /dev/null

sudo apt-get install nginx
sudo apt-get install uwsgi
sudo apt-get install uwsgi-emperor
sudo systemctl daemon-reload
sudo systemctl enable uwsgi-emperor
sudo service uwsgi-emperor start
sudo gem install compass -v 1.0.3"""

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
    echo "--ssl_certificate_crt"
    echo "--ssl_certificate_key"
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
SSL_CERTIFICATE_CRT=""
SSL_CERTIFICATE_KEY=""

OPTS=`getopt -o h --long "newrelic_license_key::,git_private_key::,git_public_key::,pickit_postgresql_user::,pickit_postgresql_database::,pickit_postgresql_host::,pickit_postgresql_port::,pickit_postgresql_password::,pickit_postgresql_replica_user::,pickit_postgresql_replica_database::,pickit_postgresql_replica_host::,pickit_postgresql_replica_port::,pickit_postgresql_replica_password::,pickit_azure_account_name::,pickit_azure_account_key::,pickit_azure_public_container::,pickit_azure_private_container::,pickit_email_host_user::,pickit_email_host_password::,pickit_email_port::,pickit_twitter_consumer_key::,pickit_twitter_consumer_secret::,pickit_facebook_app_id::,pickit_facebook_api_secret::,pickit_linkedin_consumer_key::,pickit_linkedin_consumer_secret::,pickit_google_oauth2_client_id::,pickit_google_oauth2_client_secret::,pickit_paypal_application_id::,pickit_paypal_userid::,pickit_paypal_password::,pickit_paypal_signature::,pickit_payex_encryption_key::,pickit_payex_merchant_account::,pickit_celery_broker_url::,pickit_crowd_flower_api_key_local::,pickit_crowd_flower_api_key::,pickit_redis_url::,pickit_mixpanel_token::,pickit_powerpoint_user::,pickit_orbeus_api_key::,pickit_orbeus_api_secret::,pickit_shutterstock_api_client::,pickit_shutterstock_api_secret::,pickit_stripe_public_key_sandbox::,pickit_stripe_secret_key_sandbox::,pickit_stripe_public_key::,pickit_stripe_secret_key::,pickit_mobile_service_token::,pickit_bing_translate_client_id::,pickit_bing_translate_client_secret::,pickit_new_relic_account_id::,pickit_new_relic_insights_key::,pickit_azure_moderation_subscription_id::,pickit_vatlayer_access_key::,pickit_vatlayer_access_dev_key::,pickit_vision_api_key::,pickit_cms_postgresql_user::,pickit_cms_postgresql_database::,pickit_cms_postgresql_host::,pickit_cms_postgresql_port::,pickit_cms_postgresql_password::,pickit_cms_postgresql_replica_user::,pickit_cms_postgresql_replica_database::,pickit_cms_postgresql_replica_host::,pickit_cms_postgresql_replica_port::,pickit_cms_postgresql_replica_password::,pickit_env::,django_settings_module::,clarifai_app_id::,clarifai_app_secret::,ssl_certificate_crt::,ssl_certificate_key::,help::" -n 'pickit_web' -- "$@"`

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
        --ssl_certificate_crt ) SSL_CERTIFICATE_CRT=$2; shift; shift ;;
        --ssl_certificate_key ) SSL_CERTIFICATE_KEY=$2; shift; shift ;;
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
ssl_certificate_crt=${SSL_CERTIFICATE_CRT//"++++"/" "};
ssl_certificate_key=${SSL_CERTIFICATE_KEY//"++++"/" "};

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
echo "SSL_CERTIFICATE_CRT: ${SSL_CERTIFICATE_CRT}";
echo "SSL_CERTIFICATE_KEY: ${SSL_CERTIFICATE_KEY}";


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

timedatectl set-timezone Europe/Stockholm
log "** Europe/Stockholm timezone **"

apt-get update

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
sudo apt-get install libpq-dev python-dev -y > /dev/null

log "** GEO spatial **"
sudo apt-get install binutils libproj-dev gdal-bin -y > /dev/null

log "** enchant **"
sudo apt-get install enchant -y > /dev/null

log "** nginx **"
sudo apt-get install nginx -y > /dev/null
log "** uwsgi **"
sudo apt-get install uwsgi -y > /dev/null
log "** uwsgi-emperor **"
sudo apt-get install uwsgi-emperor -y > /dev/null
sudo systemctl daemon-reload
sudo systemctl enable uwsgi-emperor
sudo service uwsgi-emperor start
log "** compass **"
sudo gem install compass -v 1.0.3

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

# apt-get -y update  > /dev/null
# TEMP FIX - Re-evaluate and remove when possible
# This is an interim fix for hostname resolution in current VM

# /etc/hosts mappings
echo "10.0.2.15  phme-dev-data" >> /etc/hosts
echo "10.0.2.16  phme-dev-data" >> /etc/hosts

#drwxrwxr-x  2 phme phme  4096 Mar 31  2015 bin
#drwxrwxr-x  2 phme phme  4096 Mar 31  2015 celery
#drwxrwxr-x  2 phme phme  4096 Apr  1  2015 config
#drwxrwxr-x  2 phme phme  4096 Mar 31  2015 downloads
#-rw-rw-r--  1 phme phme 99484 Feb  4  2016 fixed.jpg
#drwxrwxr-x  3 phme phme  4096 Jan  2 13:21 images
#drwxrwxr-x  2 phme phme  4096 Oct  7 17:35 keys
#drwxr-xr-x  3 phme phme  4096 Jan 19 17:04 log
#drwx------  2 phme phme  4096 Mar 31  2015 Mail
#lrwxrwxrwx  1 phme phme    23 May 23  2015 phme_faraday -> pichit.me/phme_faraday/
#drwxrwxr-x 10 phme phme  4096 Sep  2 12:42 pichit.me
#drwxrwxr-x  2 root root  4096 Apr  1  2015 run
#drwxrwxr-x  2 phme phme  4096 Mar 31  2015 search
#drwxrwxr-x  3 phme phme  4096 Jan 18 13:43 tmp

# directory structure
log "** directory structure **"
mkdir -m 755 /home/phme/bin
mkdir -m 755 /home/phme/celery
mkdir -m 755 /home/phme/config
mkdir -m 755 /home/phme/downloads
mkdir -m 755 /home/phme/images
mkdir -m 755 /home/phme/keys
mkdir -m 755 /home/phme/log
mkdir -m 755 /home/phme/Mail
mkdir -m 755 /home/phme/run
mkdir -m 755 /home/phme/search
mkdir -m 755 /home/phme/tmp
chown root.root /home/phme/run

# virtualenv pichit.me
log "** virtualenv pichit.me **"
# cd /home/phme
runuser -l phme -c "virtualenv /home/phme/pichit.me"

# fetch pickit code
log "** pull phme_faraday **"
runuser -l phme -c 'ssh-keyscan bitbucket.org >> /home/phme/.ssh/known_hosts'
runuser -l phme -c 'ssh-keyscan 104.192.143.1 >> /home/phme/.ssh/known_hosts'
cd /home/phme/pichit.me
runuser -l phme -c "git clone -b master_django_1_8 git@bitbucket.org:clasperson/phme_faraday.git /home/phme/pichit.me/phme_faraday"
cd /home/phme
runuser -l phme -c "ln -s pichit.me/phme_faraday"
chown -R phme.phme /home/phme/*

# install requirements
log "** install requirements **"
runuser -l phme -c "/home/phme/pichit.me/bin/pip install -r /home/phme/phme_faraday/configs/dev/dev_requirements.txt"

# install uwsgi into our environment pichit.me
runuser -l phme -c "/home/phme/pichit.me/bin/pip install uwsgi"

mkdir -m 755 /etc/nginx/ssl
if [ ${PICKIT_ENV} == "dev" ]; then
# Copy certificate files
echo -e ${ssl_certificate_crt} >> /etc/nginx/ssl/pichitmedev.com-wild.crt
echo -e ${ssl_certificate_key} >> /etc/nginx/ssl/pichitmedev.com-wild.key
fi

if [ ${PICKIT_ENV} == "live" ]; then
# Copy certificate files
echo -e ${ssl_certificate_crt} >> /etc/nginx/ssl/pickit.com.crt
echo -e ${ssl_certificate_key} >> /etc/nginx/ssl/pickit.com.key
fi

# nginx config
if [ ${PICKIT_ENV} == "dev" ]; then

log "** nginx **"
cat >/home/phme/config/nginx.pichitmedev.com <<EOL

    upstream app_server {
        server unix:/tmp/uwsgi.sock fail_timeout=0;
        # For a TCP configuration:
        # server localhost:8000 fail_timeout=0;
    }

    upstream cms_server {
        #server cms.pichitmedev.com:80;
        server unix:/tmp/uwsgi_cms.sock fail_timeout=0;
    }

    server {
        server_name  www.pichitmedev.com;
        return       301 https://pichitmedev.com\$request_uri;
    }

    server {
        listen 80 default;
        client_max_body_size 4G;
        large_client_header_buffers 4 64k;
        server_name _;
        return 301 https://\$host\$request_uri;

	location /robots.txt {
	    alias /home/phme/html/robots.txt;
	}

        location /en/robots.txt {
            alias /home/phme/html/robots.txt;
        }

        if ($host = 'pichitmedev.com') {
		rewrite ^/$ https://\$host/en/ redirect;
	}

        keepalive_timeout 30;

        # path for static files
        root /home/phme/pichit.me/phme_django/static;

	location /googlea35d4bea688aa54f.html {
		alias /home/phme/pichit.me/phme_faraday/templates/googlea35d4bea688aa54f.html;
	}

        # country flags
        location /static/flags {
            autoindex off;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django_countries/static/flags;
            expires max;
        }

        location /img {
            autoindex off;
            alias /home/phme/pichit.me/phme_faraday/static/img;
        }

        # admin media
        location /static/admin {
            autoindex off;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django/contrib/admin/static/admin;
            expires max;
        }

        # site static
        location /static {
            autoindex off;
            alias /home/phme/pichit.me/phme_faraday/static;
        }

        location /static_cms {
            autoindex off;
            alias /home/phme/phme_cms/static;
            #rewrite ^/$ https://phmedevcloud.blob.core.windows.net/cms-static/ redirect;
        }

        location /media {
            autoindex off;
            alias /home/phme/phme_cms/media;
        }

        location / {
            # checks for static file, if not found proxy to app
	   #return 503;
           try_files \$uri @proxy_to_app;
        }

        location /admin-cms {
            # checks for static file, if not found proxy to app
            try_files \$uri @proxy_to_cms;
        }

        location /en {
            try_files \$uri @proxy_to_cms;
        }

	location /admin {
    	   return 301 https://\$http_host\$request_uri\$is_args\$query_string;
	}

        location @proxy_to_app {
	    proxy_read_timeout 1200;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header Host \$http_host;
            proxy_set_header PICHIT_APP \$http_x_pichit_app;
            proxy_redirect off;

            if (\$request_method = 'OPTIONS') {
                add_header 'Access-Control-Allow-Origin' '*';
                add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, OPTIONS, DELETE';
                add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,PicHit-App,PicHit-Node,X-Forwarded-For,SimpleToken-Auth,Authorization';
                add_header 'Content-Type' 'text/plain charset=UTF-8';
                add_header 'Content-Length' 0;
                return 204;
            }

            uwsgi_pass   app_server;
	    include     /etc/nginx/uwsgi_params;

            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, OPTIONS, DELETE';
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,PicHit-App,PicHit-Node,X-Forwarded-For,SimpleToken-Auth,Authorization';
            add_header PicHit-Node \$hostname;
            proxy_intercept_errors on;
            recursive_error_pages on;
            error_page 404 = @proxy_to_cms;
            log_not_found  off;


        }

        location @proxy_to_cms {
            proxy_read_timeout 1200;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header Host \$http_host;
            proxy_set_header PICHIT_APP \$http_x_pichit_app;
            proxy_redirect off;
            uwsgi_pass   cms_server;
            include     /etc/nginx/uwsgi_params;
        }

        #if (\$remote_addr != "83.227.181.198") {
        #       return 503;
        #}

        error_page 500 504 /500.html;
        location = /500.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 403 /403.html;
        location = /403.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        #error_page 503 /503.html;
        #location = /503.html {
        #    root /home/phme/pichit.me/phme_faraday/templates;
        #}
        error_page 502 /503.html;
        location = /503.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        #error_page 404 /404.html;
        error_page 404 = @proxy_to_cms;
        #location = /404.html {
        #    root /home/phme/pichit.me/phme_faraday/templates;
        #}
        #if (\$remote_addr != "83.227.181.198") {
                #return 503;
        #}
	#return 503;
        error_page 503 @maintenance;
        location @maintenance {
                root /home/phme/pichit.me/phme_faraday/templates;
                rewrite ^(.*)\$ /503.html break;

        }
	#return 503;

	#log_format combined \$remote_addr - \$remote_user [\$time_local] "\$request" \$status \$body_bytes_sent "\$http_referer" "\$http_user_agent";
    }

    server {
        listen 443 default;
        client_max_body_size 4G;
        large_client_header_buffers 4 64k;
        server_name _;

	location /robots.txt {
	    alias /home/phme/html/robots.txt;
	}

        location /en/robots.txt {
            alias /home/phme/html/robots.txt;
        }

        if (\$host = 'pichitmedev.com') {
                rewrite ^/\$ https://\$host/en/ redirect;
        }

        ssl on;
        ssl_certificate /etc/nginx/ssl/pichitmedev.com-wild.crt;
        ssl_certificate_key /etc/nginx/ssl/pichitmedev.com-wild.key;

        keepalive_timeout 30;

        # path for static files
        root /home/phme/pichit.me/phme_django/static;

        # country flags
        location /static/flags {
            autoindex off;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django_countries/static/flags;
            expires max;
        }

        # admin media
        location /static/admin {
            autoindex off;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django/contrib/admin/static/admin;
            expires max;
        }

        # site static
        location /static {
            autoindex off;
            alias /home/phme/pichit.me/phme_faraday/static;

            add_header 'Access-Control-Allow-Origin' 'https://cycastportal.1net4u.com';
            add_header 'Access-Control-Allow-Origin' 'https://cycastportal.cycast.se';

        }

        location /img {
            autoindex off;
            alias /home/phme/pichit.me/phme_faraday/static/img;
        }

        location /static_cms {
            autoindex off;
            alias /home/phme/phme_cms/static;
            #rewrite ^/\$ https://phmedevcloud.blob.core.windows.net/cms-static/ redirect;
        }

        location /media {
            autoindex off;
            alias /home/phme/phme_cms/media;
        }

        location / {
            # checks for static file, if not found proxy to app
            try_files \$uri @proxy_to_app;
        }

        location /admin-cms {
            # checks for static file, if not found proxy to app
            try_files \$uri @proxy_to_cms;
        }

        location /en {
            try_files \$uri @proxy_to_cms;
        }

        location @proxy_to_app {

            proxy_read_timeout 1200;
	    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header Host \$http_host;
            proxy_redirect off;

	    proxy_set_header X-Scheme \$scheme;
            proxy_set_header PICHIT_APP \$http_x_pichit_app;

            if (\$request_method = 'OPTIONS') {
                add_header 'Access-Control-Allow-Origin' '*';
                add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, OPTIONS, DELETE';
                add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,PicHit-App,PicHit-Node,X-Forwarded-For,SimpleToken-Auth,Authorization';
                add_header 'Content-Type' 'text/plain charset=UTF-8';
                add_header 'Content-Length' 0;
                return 204;
            }

            uwsgi_pass   app_server;
            include     /etc/nginx/uwsgi_params;

            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, OPTIONS, DELETE';
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,PicHit-App,PicHit-Node,X-Forwarded-For,SimpleToken-Auth,Authorization';
            add_header PicHit-Node \$hostname;
            proxy_intercept_errors on;
            recursive_error_pages on;
            error_page 404 = @proxy_to_cms;
            log_not_found  off;
        }

        location @proxy_to_cms {
            proxy_read_timeout 1200;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header Host \$http_host;
            proxy_set_header PICHIT_APP \$http_x_pichit_app;
            proxy_redirect off;
            uwsgi_pass   cms_server;
            include     /etc/nginx/uwsgi_params;
        }

        error_page 500 502 504 /500.html;
        location = /500.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 403 /403.html;
        location = /403.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 503 /503.html;
        location = /503.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 404 /404.html;
        location = /404.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }

	#log_format combined \$remote_addr - \$remote_user [\$time_local] "\$request" \$status \$body_bytes_sent "\$http_referer" "\$http_user_agent";
    }

EOL
fi

# TODO: Update live CMS config
# if [ ${PICKIT_ENV} == "live" ]; then
# fi

if [ ${PICKIT_ENV} == "dev" ]; then
cat >/home/phme/config/nginx.cms.pichitmedev.com <<EOL

    upstream cms_app_server {
        server unix:/tmp/uwsgi_cms.sock fail_timeout=0;
        # For a TCP configuration:
        # server localhost:8000 fail_timeout=0;
    }

    server {
        # listen 80 default;
        client_max_body_size 4G;
        #large_client_header_buffers 4 64k;
        server_name cms.*;
        gzip            on;
        gzip_min_length 1000;
        gzip_proxied    expired no-cache no-store private auth;
        gzip_types       text/html text/css text/javascript;
        gzip_static on;
        gzip_proxied any;
        gzip_buffers 16 8k;

        keepalive_timeout 5;

        # path for static files
        #root /home/phme/pichit.me/phme_django/static;
        root /home/phme/phme_cms/static;

	location /googlea35d4bea688aa54f.html {
		alias /home/phme/pichit.me/phme_faraday/templates/googlea35d4bea688aa54f.html;
	}

        # country flags
        location /static/flags {
            autoindex on;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django_countries/static/flags;
            expires max;
        }

        location /img {
            autoindex on;
            alias /home/phme/phme_cms/static/img;
        }

        # admin media
        location /static/admin {
            autoindex on;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django/contrib/admin/static/admin;
            expires max;
        }

        # site static
        location /static_cms {
            autoindex on;
            alias /home/phme/phme_cms/static;
        }

        location / {
            # checks for static file, if not found proxy to app
	   #return 503;
           try_files \$uri @proxy_to_app;
        }

	#location /admin {
    	#   return 301 https://\$http_host\$request_uri\$is_args\$query_string;
	#}

        location @proxy_to_app {
	    proxy_read_timeout 1200;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header Host \$http_host;
            proxy_set_header PICHIT_APP \$http_x_pichit_app;
            proxy_redirect off;

            uwsgi_pass   cms_app_server;
	    include     /etc/nginx/uwsgi_params;

            add_header PicHit-Node \$hostname;
        }

        error_page 500 504 /500.html;
        location = /500.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 502 /503.html;
        location = /503.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 404 /404.html;
        location = /404.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 503 @maintenance;
        location @maintenance {
                root /home/phme/pichit.me/phme_faraday/templates;
                rewrite ^(.*)\$ /503.html break;

        }
    }

    server {
        listen 443;
        client_max_body_size 4G;
        server_name cms.*;

        ssl on;
        ssl_certificate /etc/nginx/ssl/pichitmedev.com-wild.crt;
        ssl_certificate_key /etc/nginx/ssl/pichitmedev.com-wild.key;

        keepalive_timeout 5;

        # path for static files
        #root /home/phme/pichit.me/phme_django/static;
        root /home/phme/phme_cms/static;

        # country flags
        location /static/flags {
            autoindex on;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django_countries/static/flags;
            expires max;
        }

        # admin media
        location /static/admin {
            autoindex on;
            alias /home/phme/pichit.me/lib/python2.7/site-packages/django/contrib/admin/static/admin;
            expires max;
        }

        # site static
        location /static {
            autoindex on;
            alias /home/phme/phme_cms/static;

            add_header 'Access-Control-Allow-Origin' 'https://cycastportal.1net4u.com';
            add_header 'Access-Control-Allow-Origin' 'https://cycastportal.cycast.se';

        }

        location /img {
            autoindex on;
            alias /home/phme/phme_cms/static/img;
        }

        location / {
            # checks for static file, if not found proxy to app
            try_files $uri @proxy_to_app;
        }

        location @proxy_to_app {

            proxy_read_timeout 1200;
	    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header Host \$http_host;
            proxy_redirect off;

	    proxy_set_header X-Scheme \$scheme;
            proxy_set_header PICHIT_APP \$http_x_pichit_app;

            uwsgi_pass   cms_app_server;
            include     /etc/nginx/uwsgi_params;

            add_header PicHit-Node \$hostname;
        }

        error_page 500 502 504 /500.html;
        location = /500.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 503 /503.html;
        location = /503.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
        error_page 404 /404.html;
        location = /404.html {
            root /home/phme/pichit.me/phme_faraday/templates;
        }
    }

EOL
fi

# TODO: Update live CMS config
# if [ ${PICKIT_ENV} == "live" ]; then
# fi


# uwsgi config

# TODO: Define module based on live and first web instance !!!!!!!!, like module=phme_faraday.wsgi_newrelic

if [ ${PICKIT_ENV} == "dev" ]; then
log "** uwsgi **"
cat >/home/phme/config/uwsgi.pichitmedev.com.ini <<EOL
[uwsgi]
plugins = python
socket=/tmp/uwsgi.sock
chmod-socket = 777
# socket = :8000
chdir = /home/phme/pichit.me/
# wsgi-file = pichitme_wsgi.py
module = phme_faraday.wsgi
pythonpath = /home/phme/pichit.me
pythonpath = /home/phme/pichit.me/phme_faraday
processes = 10
pidfile=/home/phme/uwsgi.pid
master = true
home = /home/phme/pichit.me
env = DJANGO_SETTINGS_MODULE=${DJANGO_SETTINGS_MODULE}
# env = NEW_RELIC_CONFIG_FILE=/home/phme/pichit.me/phme_faraday/configs/dev/newrelic.ini
uid = phme
gid = phme
vacuum = true
stats = 127.0.0.1:9191
logto = /home/phme/log/uwsgi.log
# eval = import newrelic.agent, wsgi; application = newrelic.agent.wsgi_application()(wsgi.application)
enable-threads = true
single-interpreter = true
lazy-apps = true
# file = wsgi.py
env=PICKIT_POSTGRESQL_USER=${PICKIT_POSTGRESQL_USER}
env=PICKIT_POSTGRESQL_DATABASE=${PICKIT_POSTGRESQL_DATABASE}
env=PICKIT_POSTGRESQL_HOST=${PICKIT_POSTGRESQL_HOST}
env=PICKIT_POSTGRESQL_PORT=${PICKIT_POSTGRESQL_PORT}
env=PICKIT_POSTGRESQL_PASSWORD=${PICKIT_POSTGRESQL_PASSWORD}
env=PICKIT_POSTGRESQL_REPLICA_USER=${PICKIT_POSTGRESQL_REPLICA_USER}
env=PICKIT_POSTGRESQL_REPLICA_DATABASE=${PICKIT_POSTGRESQL_REPLICA_DATABASE}
env=PICKIT_POSTGRESQL_REPLICA_HOST=${PICKIT_POSTGRESQL_REPLICA_HOST}
env=PICKIT_POSTGRESQL_REPLICA_PORT=${PICKIT_POSTGRESQL_REPLICA_PORT}
env=PICKIT_POSTGRESQL_REPLICA_PASSWORD=${PICKIT_POSTGRESQL_REPLICA_PASSWORD}
env=PICKIT_AZURE_ACCOUNT_NAME=${PICKIT_AZURE_ACCOUNT_NAME}
env=PICKIT_AZURE_ACCOUNT_KEY=${PICKIT_AZURE_ACCOUNT_KEY}
env=PICKIT_AZURE_PUBLIC_CONTAINER=${PICKIT_AZURE_PUBLIC_CONTAINER}
env=PICKIT_AZURE_PRIVATE_CONTAINER=${PICKIT_AZURE_PRIVATE_CONTAINER}
env=PICKIT_EMAIL_HOST_USER=${PICKIT_EMAIL_HOST_USER}
env=PICKIT_EMAIL_HOST_PASSWORD=${PICKIT_EMAIL_HOST_PASSWORD}
env=PICKIT_EMAIL_PORT=${PICKIT_EMAIL_PORT}
env=PICKIT_TWITTER_CONSUMER_KEY=${PICKIT_TWITTER_CONSUMER_KEY}
env=PICKIT_TWITTER_CONSUMER_SECRET=${PICKIT_TWITTER_CONSUMER_SECRET}
env=PICKIT_FACEBOOK_APP_ID=${PICKIT_FACEBOOK_APP_ID}
env=PICKIT_FACEBOOK_API_SECRET=${PICKIT_FACEBOOK_API_SECRET}
env=PICKIT_LINKEDIN_CONSUMER_KEY=${PICKIT_LINKEDIN_CONSUMER_KEY}
env=PICKIT_LINKEDIN_CONSUMER_SECRET=${PICKIT_LINKEDIN_CONSUMER_SECRET}
env=PICKIT_GOOGLE_OAUTH2_CLIENT_ID=${PICKIT_GOOGLE_OAUTH2_CLIENT_ID}
env=PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET=${PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET}
env=PICKIT_PAYPAL_APPLICATION_ID=${PICKIT_PAYPAL_APPLICATION_ID}
env=PICKIT_PAYPAL_USERID=${PICKIT_PAYPAL_USERID}
env=PICKIT_PAYPAL_PASSWORD=${PICKIT_PAYPAL_PASSWORD}
env=PICKIT_PAYPAL_SIGNATURE=${PICKIT_PAYPAL_SIGNATURE}
env=PICKIT_PAYEX_ENCRYPTION_KEY=${PICKIT_PAYEX_ENCRYPTION_KEY}
env=PICKIT_PAYEX_MERCHANT_ACCOUNT=${PICKIT_PAYEX_MERCHANT_ACCOUNT}
env=PICKIT_CELERY_BROKER_URL=${PICKIT_CELERY_BROKER_URL}
env=PICKIT_CROWD_FLOWER_API_KEY_LOCAL=${PICKIT_CROWD_FLOWER_API_KEY_LOCAL}
env=PICKIT_CROWD_FLOWER_API_KEY=${PICKIT_CROWD_FLOWER_API_KEY}
env=PICKIT_REDIS_URL=${PICKIT_REDIS_URL}
env=PICKIT_MIXPANEL_TOKEN=${PICKIT_MIXPANEL_TOKEN}
env=PICKIT_POWERPOINT_USER=${PICKIT_POWERPOINT_USER}
env=PICKIT_ORBEUS_API_KEY=${PICKIT_ORBEUS_API_KEY}
env=PICKIT_ORBEUS_API_SECRET=${PICKIT_ORBEUS_API_SECRET}
env=PICKIT_SHUTTERSTOCK_API_CLIENT=${PICKIT_SHUTTERSTOCK_API_CLIENT}
env=PICKIT_SHUTTERSTOCK_API_SECRET=${PICKIT_SHUTTERSTOCK_API_SECRET}
env=PICKIT_STRIPE_PUBLIC_KEY_SANDBOX=${PICKIT_STRIPE_PUBLIC_KEY_SANDBOX}
env=PICKIT_STRIPE_SECRET_KEY_SANDBOX=${PICKIT_STRIPE_SECRET_KEY_SANDBOX}
env=PICKIT_STRIPE_PUBLIC_KEY=${PICKIT_STRIPE_PUBLIC_KEY}
env=PICKIT_STRIPE_SECRET_KEY=${PICKIT_STRIPE_SECRET_KEY}
env=PICKIT_MOBILE_SERVICE_TOKEN=${PICKIT_MOBILE_SERVICE_TOKEN}
env=PICKIT_BING_TRANSLATE_CLIENT_ID=${PICKIT_BING_TRANSLATE_CLIENT_ID}
env=PICKIT_BING_TRANSLATE_CLIENT_SECRET=${PICKIT_BING_TRANSLATE_CLIENT_SECRET}
env=PICKIT_NEW_RELIC_ACCOUNT_ID=${PICKIT_NEW_RELIC_ACCOUNT_ID}
env=PICKIT_NEW_RELIC_INSIGHTS_KEY=${PICKIT_NEW_RELIC_INSIGHTS_KEY}
env=PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID=${PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID}
env=PICKIT_VATLAYER_ACCESS_KEY=${PICKIT_VATLAYER_ACCESS_KEY}
env=PICKIT_VATLAYER_ACCESS_DEV_KEY=${PICKIT_VATLAYER_ACCESS_DEV_KEY}
env=PICKIT_CMS_POSTGRESQL_USER=${PICKIT_CMS_POSTGRESQL_USER}
env=PICKIT_CMS_POSTGRESQL_DATABASE=${PICKIT_CMS_POSTGRESQL_DATABASE}
env=PICKIT_CMS_POSTGRESQL_HOST=${PICKIT_CMS_POSTGRESQL_HOST}
env=PICKIT_CMS_POSTGRESQL_PORT=${PICKIT_CMS_POSTGRESQL_PORT}
env=PICKIT_CMS_POSTGRESQL_PASSWORD=${PICKIT_CMS_POSTGRESQL_PASSWORD}
env=PICKIT_CMS_POSTGRESQL_REPLICA_USER=${PICKIT_CMS_POSTGRESQL_REPLICA_USER}
env=PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE=${PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE}
env=PICKIT_CMS_POSTGRESQL_REPLICA_HOST=${PICKIT_CMS_POSTGRESQL_REPLICA_HOST}
env=PICKIT_CMS_POSTGRESQL_REPLICA_PORT=${PICKIT_CMS_POSTGRESQL_REPLICA_PORT}
env=PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD=${PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD}

EOL

cat >/home/phme/config/uwsgi.cms.pichitmedev.com.ini <<EOL
[uwsgi]
plugins = python
socket=/tmp/uwsgi_cms.sock
chmod-socket = 777
# socket = :8000
chdir = /home/phme/
# wsgi-file = pichitme_wsgi.py
module = cms_phme.wsgi
pythonpath = /home/phme/envs/phme_cms_env
pythonpath = /home/phme/phme_cms
processes = 10
pidfile=/home/phme/uwsgi_cms.pid
master = true
home = /home/phme/envs/phme_cms_env
env = DJANGO_SETTINGS_MODULE=cms_phme.settings.dev
# env = NEW_RELIC_CONFIG_FILE=/home/phme/pichit.me/phme_faraday/configs/dev/newrelic.ini
uid = phme
gid = phme
vacuum = true
# stats = 127.0.0.1:9191
logto = /home/phme/log/uwsgi_cms.log
# eval = import newrelic.agent, wsgi; application = newrelic.agent.wsgi_application()(wsgi.application)
enable-threads = true
single-interpreter = true
lazy-apps = true
# file = wsgi.py
env=PICKIT_TEST_ENV=${PICKIT_TEST_ENV}
env=PICKIT_CMS_POSTGRESQL_USER=${PICKIT_CMS_POSTGRESQL_USER}
env=PICKIT_CMS_POSTGRESQL_DATABASE=${PICKIT_CMS_POSTGRESQL_DATABASE}
env=PICKIT_CMS_POSTGRESQL_HOST=${PICKIT_CMS_POSTGRESQL_HOST}
env=PICKIT_CMS_POSTGRESQL_PORT=${PICKIT_CMS_POSTGRESQL_PORT}
env=PICKIT_CMS_POSTGRESQL_PASSWORD=${PICKIT_CMS_POSTGRESQL_PASSWORD}
env=PICKIT_CMS_POSTGRESQL_REPLICA_USER=${PICKIT_CMS_POSTGRESQL_REPLICA_USER}
env=PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE=${PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE}
env=PICKIT_CMS_POSTGRESQL_REPLICA_HOST=${PICKIT_CMS_POSTGRESQL_REPLICA_HOST}
env=PICKIT_CMS_POSTGRESQL_REPLICA_PORT=${PICKIT_CMS_POSTGRESQL_REPLICA_PORT}
env=PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD=${PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD}

EOL

cp /home/phme/config/uwsgi.pichitmedev.com.ini /home/phme/config/uwsgi.pichitmedev.com-src.ini
cp /home/phme/config/uwsgi.cms.pichitmedev.com.ini /home/phme/config/uwsgi.cms.pichitmedev.com-src.ini

fi

# TODO: Update UWSGI live config
# if [ ${PICKIT_ENV} == "live" ]; then
# fi

# TODO: Update UWSGI live CMS config
# if [ ${PICKIT_ENV} == "live" ]; then
# fi

# settings_local.py
if [ ${PICKIT_ENV} == "dev" ]; then
cat >/home/phme/phme_faraday/settings/development/settings_local.py <<EOL
DEBUG = True

STRIPE_PUBLIC_KEY = "${PICKIT_STRIPE_PUBLIC_KEY}"
STRIPE_SECRET_KEY = "${PICKIT_STRIPE_SECRET_KEY}"

# HTTPS_SUPPORT=False

SESSION_COOKIE_DOMAIN = '.pichitmedev.com'

REDIS_URL = "${PICKIT_REDIS_URL}"

CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "{}/10".format(REDIS_URL),
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
            "CONNECTION_POOL_KWARGS": {"max_connections": 100}
        }
    }
}

ALLOWED_HOSTS = [
	'.pichitmedev.com',
]

BROKER_URL = "${PICKIT_CELERY_BROKER_URL}"
EOL
fi

if [ ${PICKIT_ENV} == "live" ]; then
cat >/home/phme/phme_faraday/settings/live/settings_local.py <<EOL
REDIS_URL = "${PICKIT_REDIS_URL}"
CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "{}/10".format(REDIS_URL),
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
            "CONNECTION_POOL_KWARGS": {"max_connections": 100}
        }
    }
}
BROKER_URL = "${PICKIT_CELERY_BROKER_URL}"
LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
        'standard': {
            'format' : "[%(asctime)s] %(levelname)s [%(name)s:%(lineno)s] %(message)s",
            'datefmt' : "%d/%b/%Y %H:%M:%S"
        },
    },
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'logfile': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'DEBUG',
            'filename': '/home/phme/log/phme_django.log',
            'maxBytes': 1024*1024*25,
            'backupCount': 5,
            'formatter': 'standard'
        },
        'logfile_cf': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'INFO',
            'filename': '/home/phme/log/phme_crowdflower.log',
            'maxBytes': 1024*1024*25,
            'backupCount': 5,
            'formatter': 'standard'
        },
        'logfile_commands': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'DEBUG',
            'filename': '/home/phme/log/phme_commands.log',
            'maxBytes': 1024*1024*25,
            'backupCount': 5,
            'formatter': 'standard'
        },
        'logfile_search': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'INFO',
            'filename': '/home/phme/log/phme_search.log',
            'maxBytes': 1024*1024*25,
            'backupCount': 5,
            'formatter': 'standard'
        },
        'logfile_exchange': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'INFO',
            'filename': '/home/phme/log/phme_currency_exchange.log',
            'maxBytes': 1024*1024*25,
            'backupCount': 5,
            'formatter': 'standard'
        },
        'mail_admins': {
            'level': 'ERROR',
            'class': 'email_handlers.handlers.ThrottledAdminEmailHandler'
        },
        'sentry': {
            'level': 'ERROR',
            'class': 'raven.contrib.django.raven_compat.handlers.SentryHandler',
        },
        'logfile_analytics': {
            'class': 'logging.handlers.RotatingFileHandler',
            'level': 'INFO',
            'filename': '/home/phme/log/phme_analytics.log',
            'maxBytes': 1024*1024*25,
            'backupCount': 5,
            'formatter': 'standard'
        },
        'graypy': {
            'level': 'DEBUG',
            'class': 'graypy.GELFHandler',
            'host': '40.87.158.22',
            'port': 12201,
        },
    },
    'loggers': {
        'django': {
            'handlers': ['logfile', 'sentry', 'graypy'],
            'propagate': True,
            'level': 'INFO',
        },
        'django.request': {
            'handlers': ['mail_admins', 'logfile', 'sentry', 'graypy'],
            'level': 'INFO',
            'propagate': False,
        },
       'pyelasticsearch': {
            'handlers': ['logfile', 'graypy'],
            'level': 'DEBUG',
            'propagate': True,
        },
        'apps': {
            'handlers': ['logfile', 'sentry', 'graypy'],
            'level': 'ERROR',
            'propagate': True,
        },
        'haystack': {
            'handlers': ['logfile', 'sentry', 'graypy'],
            'propagate': True,
            'level': 'ERROR',
        },
        'piston': {
            'handlers': ['logfile', 'sentry', 'graypy'],
            'propagate': True,
            'level': 'ERROR',
        },
        'currency_exchange': {
            'handlers': ['logfile_exchange', 'graypy'],
            'propagate': True,
            'level': 'INFO',
        },
        'crowdflower': {
            'handlers': ['logfile_cf', 'graypy'],
            'level': 'INFO',
            'propagate': True,
        },
        'commands': {
            'handlers': ['logfile_commands', 'graypy'],
            'level': 'DEBUG',
            'propagate': True,
        },
        'search': {
            'handlers': ['logfile_search', 'graypy'],
            'level': 'INFO',
            'propagate': True,
        },
        'analytics': {
            'handlers': ['logfile_analytics', 'graypy'],
            'level': 'INFO',
            'propagate': True,
        },
    }
}
API_URL = "http://phme-web.cloudapp.net//api"
SITE_URL = "http://phme-web.cloudapp.net/"
EOL
fi

chown phme.phme /home/phme/config/*

# TODO: Copy GeoIP in ubuntu directory. How???????????????????????????

# Copy settings_local.py into /home/phme/phme_faraday/settings/development/settings_local
# for dev and live environments, depending which one is used

exit 0
