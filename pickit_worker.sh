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


# apt-get -y update  > /dev/null

# Log method to control/redirect log output
log()
{
    # If you want to enable this logging add a un-comment the line below and add your account id
    #curl -X POST -H "content-type:text/plain" --data-binary "${HOSTNAME} - $1" https://logs-01.loggly.com/inputs/<key>/tag/es-extension,${HOSTNAME}
    echo "$1"
}

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

# install packages
log "** supervisor package **"
apt-get install supervisor -y > /dev/null
systemctl enable supervisor
update-rc.d supervisor defaults
# service supervisor start

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
#drwxrwxr-x  4 phme phme  4096 Oct  1 10:45 office_add_in
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
mkdir -m 755 /home/phme/office_add_in
mkdir -m 755 /home/phme/run
mkdir -m 755 /home/phme/search
mkdir -m 755 /home/phme/tmp
chown -R phme.phme /home/phme/*
chown root.root /home/phme/run

# TODO: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! office_add_in is a bit tricky to install

# virtualenv pichit.me
log "** virtualenv pichit.me **"
# cd /home/phme
runuser -l phme -c "virtualenv /home/phme/pichit.me"

# fetch pickit code
log "** pull phme_faraday **"
cd /home/phme/pichit.me
runuser -l phme -c "git clone -b master_django_1_8 git@bitbucket.org:clasperson/phme_faraday.git /home/phme/pichit.me/phme_faraday"
cd /home/phme
runuser -l phme -c "ln -s pichit.me/phme_faraday"
chown -R phme.phme /home/phme/*

# install requirements
log "** install requirements **"
runuser -l phme -c "/home/phme/pichit.me/bin/pip install -r /home/phme/phme_faraday/configs/dev/dev_requirements.txt"

# worker phme_faraday directories
log "** pull worker directory for phme_faraday **"
cd /home/phme/pichit.me
mkdir -m 755 /home/phme/pichit.me/worker
cd /home/phme/pichit.me/worker
chown -R phme.phme /home/phme/*
runuser -l phme -c "git clone -b master_django_1_8 git@bitbucket.org:clasperson/phme_faraday.git /home/phme/pichit.me/worker/phme_faraday"
chown -R phme.phme /home/phme/*

# crontab update
log "** crontab update **"
cat >/home/phme/config/crontab <<EOL
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command

DJANGO_SETTINGS_MODULE=${DJANGO_SETTINGS_MODULE}
CLARIFAI_APP_ID=${CLARIFAI_APP_ID}
CLARIFAI_APP_SECRET=${CLARIFAI_APP_SECRET}

PYTHONPATH=/home/phme/pichit.me/phme_faraday

#0 10 * * * /home/phme/pichit.me/bin/python /home/phme/pichit.me/phme_faraday/manage.py upload_crowdflower --contribution_limit 1000 -v 0 --settings ${DJANGO_SETTINGS_MODULE}

0 1 * * * /home/phme/pichit.me/bin/python /home/phme/pichit.me/phme_faraday/scripts/analytics/do_search_cam
#0 7 * * * /home/phme/pichit.me/bin/python /home/phme/pichit.me/phme_faraday/scripts/analytics/daily_analytics
*/1 * * * * /home/phme/pichit.me/bin/python /home/phme/pichit.me/phme_faraday/scripts/analytics/process_events
*/1 * * * * /home/phme/pichit.me/bin/python /home/phme/pichit.me/phme_faraday/scripts/analytics/process_actions_users...
EOL
crontab -u phme /home/phme/config/crontab

# /etc/supervisor/supervisord.conf -> We need update with environment variables
log "** supervisord.conf **"
cat >/etc/supervisor/supervisord.conf <<EOL
; supervisor config file

[unix_http_server]
file=/var/run/supervisor.sock   ; (the path to the socket file)
chmod=0700                       ; sockef file mode (default 0700)

[supervisord]
logfile=/var/log/supervisor/supervisord.log ; (main log file;default $CWD/supervisord.log)
pidfile=/var/run/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
childlogdir=/var/log/supervisor            ; ('AUTO' child log dir, default $TEMP)

environment=PICKIT_POSTGRESQL_USER="${PICKIT_POSTGRESQL_USER}",PICKIT_POSTGRESQL_DATABASE="${PICKIT_POSTGRESQL_DATABASE}",PICKIT_POSTGRESQL_HOST="${PICKIT_POSTGRESQL_HOST}",PICKIT_POSTGRESQL_PORT="${PICKIT_POSTGRESQL_PORT}",PICKIT_POSTGRESQL_PASSWORD="${PICKIT_POSTGRESQL_PASSWORD}",PICKIT_POSTGRESQL_REPLICA_USER="${PICKIT_POSTGRESQL_REPLICA_USER}",PICKIT_POSTGRESQL_REPLICA_DATABASE="${PICKIT_POSTGRESQL_REPLICA_DATABASE}",PICKIT_POSTGRESQL_REPLICA_HOST="${PICKIT_POSTGRESQL_REPLICA_HOST}",PICKIT_POSTGRESQL_REPLICA_PORT="${PICKIT_POSTGRESQL_REPLICA_PORT}",PICKIT_POSTGRESQL_REPLICA_PASSWORD="${PICKIT_POSTGRESQL_REPLICA_PASSWORD}",PICKIT_AZURE_ACCOUNT_NAME="${PICKIT_AZURE_ACCOUNT_NAME}",PICKIT_AZURE_ACCOUNT_KEY="${PICKIT_AZURE_ACCOUNT_KEY}",PICKIT_AZURE_PUBLIC_CONTAINER="${PICKIT_AZURE_PUBLIC_CONTAINER}",PICKIT_AZURE_PRIVATE_CONTAINER="${PICKIT_AZURE_PRIVATE_CONTAINER}",PICKIT_EMAIL_HOST_USER="${PICKIT_EMAIL_HOST_USER}",PICKIT_EMAIL_HOST_PASSWORD="${PICKIT_EMAIL_HOST_PASSWORD}",PICKIT_EMAIL_PORT="${PICKIT_EMAIL_PORT}",PICKIT_TWITTER_CONSUMER_KEY="${PICKIT_TWITTER_CONSUMER_KEY}",PICKIT_TWITTER_CONSUMER_SECRET="${PICKIT_TWITTER_CONSUMER_SECRET}",PICKIT_FACEBOOK_APP_ID="${PICKIT_FACEBOOK_APP_ID}",PICKIT_FACEBOOK_API_SECRET="${PICKIT_FACEBOOK_API_SECRET}",PICKIT_LINKEDIN_CONSUMER_KEY="${PICKIT_LINKEDIN_CONSUMER_KEY}",PICKIT_LINKEDIN_CONSUMER_SECRET="${PICKIT_LINKEDIN_CONSUMER_SECRET}",PICKIT_GOOGLE_OAUTH2_CLIENT_ID="${PICKIT_GOOGLE_OAUTH2_CLIENT_ID}",PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET="${PICKIT_GOOGLE_OAUTH2_CLIENT_SECRET}",PICKIT_PAYPAL_APPLICATION_ID="${PICKIT_PAYPAL_APPLICATION_ID}",PICKIT_PAYPAL_USERID="${PICKIT_PAYPAL_USERID}",PICKIT_PAYPAL_PASSWORD="${PICKIT_PAYPAL_PASSWORD}",PICKIT_PAYPAL_SIGNATURE="${PICKIT_PAYPAL_SIGNATURE}",PICKIT_PAYEX_ENCRYPTION_KEY="${PICKIT_PAYEX_ENCRYPTION_KEY}",PICKIT_PAYEX_MERCHANT_ACCOUNT="${PICKIT_PAYEX_MERCHANT_ACCOUNT}",PICKIT_CELERY_BROKER_URL="${PICKIT_CELERY_BROKER_URL}",PICKIT_CROWD_FLOWER_API_KEY_LOCAL="${PICKIT_CROWD_FLOWER_API_KEY_LOCAL}",PICKIT_CROWD_FLOWER_API_KEY="${PICKIT_CROWD_FLOWER_API_KEY}",PICKIT_REDIS_URL="${PICKIT_REDIS_URL}",PICKIT_MIXPANEL_TOKEN="${PICKIT_MIXPANEL_TOKEN}",PICKIT_POWERPOINT_USER="${PICKIT_POWERPOINT_USER}",PICKIT_ORBEUS_API_KEY="${PICKIT_ORBEUS_API_KEY}",PICKIT_ORBEUS_API_SECRET="${PICKIT_ORBEUS_API_SECRET}",PICKIT_SHUTTERSTOCK_API_CLIENT="${PICKIT_SHUTTERSTOCK_API_CLIENT}",PICKIT_SHUTTERSTOCK_API_SECRET="${PICKIT_SHUTTERSTOCK_API_SECRET}",PICKIT_STRIPE_PUBLIC_KEY_SANDBOX="${PICKIT_STRIPE_PUBLIC_KEY_SANDBOX}",PICKIT_STRIPE_SECRET_KEY_SANDBOX="${PICKIT_STRIPE_SECRET_KEY_SANDBOX}",PICKIT_STRIPE_PUBLIC_KEY="${PICKIT_STRIPE_PUBLIC_KEY}",PICKIT_STRIPE_SECRET_KEY="${PICKIT_STRIPE_SECRET_KEY}",PICKIT_MOBILE_SERVICE_TOKEN="${PICKIT_MOBILE_SERVICE_TOKEN}",PICKIT_BING_TRANSLATE_CLIENT_ID="${PICKIT_BING_TRANSLATE_CLIENT_ID}",PICKIT_BING_TRANSLATE_CLIENT_SECRET="${PICKIT_BING_TRANSLATE_CLIENT_SECRET}",PICKIT_NEW_RELIC_ACCOUNT_ID="${PICKIT_NEW_RELIC_ACCOUNT_ID}",PICKIT_NEW_RELIC_INSIGHTS_KEY="${PICKIT_NEW_RELIC_INSIGHTS_KEY}",PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID="${PICKIT_AZURE_MODERATION_SUBSCRIPTION_ID}",PICKIT_VATLAYER_ACCESS_KEY="${PICKIT_VATLAYER_ACCESS_KEY}",PICKIT_VATLAYER_ACCESS_DEV_KEY="${PICKIT_VATLAYER_ACCESS_DEV_KEY}",PICKIT_VISION_API_KEY="${PICKIT_VISION_API_KEY}",PICKIT_CMS_POSTGRESQL_USER="${PICKIT_CMS_POSTGRESQL_USER}",PICKIT_CMS_POSTGRESQL_DATABASE="${PICKIT_CMS_POSTGRESQL_DATABASE}",PICKIT_CMS_POSTGRESQL_HOST="${PICKIT_CMS_POSTGRESQL_HOST}",PICKIT_CMS_POSTGRESQL_PORT="${PICKIT_CMS_POSTGRESQL_PORT}",PICKIT_CMS_POSTGRESQL_PASSWORD="${PICKIT_CMS_POSTGRESQL_PASSWORD}",PICKIT_CMS_POSTGRESQL_REPLICA_USER="${PICKIT_CMS_POSTGRESQL_REPLICA_USER}",PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE="${PICKIT_CMS_POSTGRESQL_REPLICA_DATABASE}",PICKIT_CMS_POSTGRESQL_REPLICA_HOST="${PICKIT_CMS_POSTGRESQL_REPLICA_HOST}",PICKIT_CMS_POSTGRESQL_REPLICA_PORT="${PICKIT_CMS_POSTGRESQL_REPLICA_PORT}",PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD="${PICKIT_CMS_POSTGRESQL_REPLICA_PASSWORD}"

; the below section must remain in the config file for RPC
; (supervisorctl/web interface) to work, additional interfaces may be
; added by defining them in separate rpcinterface: sections
[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock ; use a unix:// URL  for a unix socket

; The [include] section can just contain the "files" setting.  This
; setting can list multiple files (separated by whitespace or
; newlines).  It can also contain wildcards.  The filenames are
; interpreted as relative to this file.  Included files *cannot*
; include files themselves.

[include]
files = /etc/supervisor/conf.d/*.conf
...
EOL

# supervisor configs building for different processes running
log "** phme_celerybeat.conf **"
cat > /etc/supervisor/conf.d/phme_celerybeat.conf <<EOL
; =======================================
;  celerybeat for phme
; =======================================

[program:phme_celerybeat]
command=/home/phme/pichit.me/bin/python manage.py celerybeat -S djcelery.schedulers.DatabaseScheduler -v 2 -l INFO --settings ${DJANGO_SETTINGS_MODULE} --pythonpath .

directory=/home/phme/pichit.me/phme_faraday
user=phme
numprocs=1
stdout_logfile=/home/phme/log/phme_celerybeat.log
logfile_maxbytes = 50MB
logfile_backups=10
redirect_stderr=true
autostart=true
autorestart=true
startsecs=10

; Need to wait for currently executing tasks to finish at shutdown.
; Increase this if you have very long running tasks.
stopwaitsecs = 120

; if rabbitmq is supervised, set its priority higher
; so it starts first
priority=997
...
EOL

log "** phme_celerycam.conf **"
cat > /etc/supervisor/conf.d/phme_celerycam.conf <<EOL
; =======================================
;  celerycam for phme
; =======================================

[program:phme_celerycam]
command=/home/phme/pichit.me/bin/python manage.py celerycam -v 2 -l INFO --settings ${DJANGO_SETTINGS_MODULE} --pythonpath .

directory=/home/phme/pichit.me/phme_faraday
user=phme
numprocs=1
stdout_logfile=/home/phme/log/phme_celerycam.log
logfile_maxbytes = 50MB
logfile_backups=10
redirect_stderr=true
autostart=true
autorestart=true
startsecs=10

; Need to wait for currently executing tasks to finish at shutdown.
; Increase this if you have very long running tasks.
stopwaitsecs = 120

; if rabbitmq is supervised, set its priority higher
; so it starts first
priority=997
...
EOL

log "** phme_celeryd_worker.conf **"
cat > /etc/supervisor/conf.d/phme_celeryd_worker.conf <<EOL
; =======================================
;  celeryd worker for phme
; =======================================

[program:phme_celeryd_worker]
command=/home/phme/pichit.me/bin/python manage.py celeryd -v 2 -E -l INFO --settings ${DJANGO_SETTINGS_MODULE} --pythonpath .

directory=/home/phme/pichit.me/worker/phme_faraday
user=phme
numprocs=3
stdout_logfile=/home/phme/log/phme_celeryd_worker.log
logfile_maxbytes = 50MB
logfile_backups=10
redirect_stderr=true
autostart=true
autorestart=true
startsecs=10

; Need to wait for currently executing tasks to finish at shutdown.
; Increase this if you have very long running tasks.
stopwaitsecs = 120

; if rabbitmq is supervised, set its priority higher
; so it starts first
priority=997
...
EOL


exit 0
