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

help()
{
    echo ""
}

# Log method to control/redirect log output
log()
{
    # If you want to enable this logging add a un-comment the line below and add your account id
    #curl -X POST -H "content-type:text/plain" --data-binary "${HOSTNAME} - $1" https://logs-01.loggly.com/inputs/<key>/tag/es-extension,${HOSTNAME}
    echo "$1"
}

ENV=""
DJANGO_SETTINGS_MODULE=""
CLARIFAI_APP_ID=""
CLARIFAI_APP_SECRET=""


#Loop through options passed
while getopts :h optname; do
    log "Option $optname set with value ${OPTARG}"
  case $optname in
    h) #show help
      help
      exit 2
      ;;
    \?) #unrecognized option - show help
      echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed."
      help
      exit 2
      ;;
  esac
done

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
apt-get install supervisor -y > /dev/null
systemctl enable supervisor
update-rc.d supervisor defaults
service supervisor start

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

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! office_add_in is a bit tricky to install

# virtualenv pichit.me
cd /home/phme
sudo su -c virtualenv pichit.me phme

# fetch pickit code
cd /home/phme/pichit.me
git clone git@bitbucket.org:clasperson/phme_faraday.git
cd /home/phme
ln -s pichit.me/phme_faraday

# worker1-3 phme_faraday directories
cd /home/phme/pichit.me
mkdir -m 755 /home/phme/pichit.me/worker1
cd /home/phme/pichit.me/worker1
git clone git@bitbucket.org:clasperson/phme_faraday.git
if [ ${ENV} -ne "dev" ]; then
    mkdir -m 755 /home/phme/pichit.me/worker2
    cd /home/phme/pichit.me/worker2
    git clone git@bitbucket.org:clasperson/phme_faraday.git
    mkdir -m 755 /home/phme/pichit.me/worker3
    cd /home/phme/pichit.me/worker2
    git clone git@bitbucket.org:clasperson/phme_faraday.git
fi

# crontab update
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

# supervisor configs building for different processes running

# /etc/supervisor/supervisord.conf -> We need update with environment variables

exit 0
