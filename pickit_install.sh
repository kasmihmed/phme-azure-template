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


# apt-get -y > /dev/null update  > /dev/null

help()
{
    echo "This script installs Pickit common packages"
    echo "Parameters:"
    echo "-i GIT identity private key"
    echo "-p GIT identity public key"
    echo "-l NewRelic license key"
}

# Log method to control/redirect log output
log()
{
    # If you want to enable this logging add a un-comment the line below and add your account id
    #curl -X POST -H "content-type:text/plain" --data-binary "${HOSTNAME} - $1" https://logs-01.loggly.com/inputs/<key>/tag/es-extension,${HOSTNAME}
    echo "$1"
}

NEWRELIC_LICENSE_KEY=""

#Loop through options passed
while getopts :l:h optname; do
    log "Option $optname set with value ${OPTARG}"
  case $optname in
    l) #set newrelic license key
      NEWRELIC_LICENSE_KEY=${OPTARG}
      ;;
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

log "NEWRELIC_LICENSE_KEY: $NEWRELIC_LICENSE_KEY"

#if [ "${UID}" -ne 0 ];
#then
#    log "Script executed without root permissions"
#    echo "You must be root to run this program." >&2
#    exit 3
#fi
#
## TEMP FIX - Re-evaluate and remove when possible
## This is an interim fix for hostname resolution in current VM
#grep -q "${HOSTNAME}" /etc/hosts
#if [ $? == 0 ]
#then
#  echo "${HOSTNAME}found in /etc/hosts"
#else
#  echo "${HOSTNAME} not found in /etc/hosts"
#  # Append it to the hsots file if not there
#  echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts
#  log "hostname ${HOSTNAME} added to /etchosts"
#fi

apt-get install phantomjs -y > /dev/null
log '** phantomjs **'
apt-get install binutils libproj-dev gdal-bin -y > /dev/null
log '** binutils **'
apt-get install lynx-cur -y > /dev/null
log '** lynx **'
apt-get install uwsgi-plugin-python -y > /dev/null
log '** uwsgi-plugin-python **'
apt-get install nodejs-legacy -y > /dev/null
log '** node **'
apt-get install npm -y > /dev/null
log '** npm **'
npm -g install grunt
npm install -g grunt-cli
npm install -g azure-cli
apt-get install gem -y > /dev/null
log '** gem **'

apt-get install ruby -y > /dev/null
log '** ruby **'
gem update --system
apt-get install ruby-dev -y > /dev/null
log '** ruby-dev **'

echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
apt-get update
apt-get install newrelic-sysmond -y > /dev/null
nrsysmond-config --set license_key=${NEWRELIC_LICENSE_KEY}
log '** newrelic **'

apt-get install traceroute -y > /dev/null
log '** traceroute **'
apt-get install postgresql-client -y > /dev/null
log '** postgresql-client **'
apt-get install apache2-utils -y > /dev/null
log '** apache-utils **'

service newrelic-sysmond start
log '** nerelic-sysmond **'
apt-get install bind9 -y > /dev/null
log '** bind9 **'
apt-get install dnsutils -y > /dev/null
log '** dnsutils **'
apt-get install redis-tools -y > /dev/null
log '** redis-tools **'
apt-get install python-pip -y > /dev/null
log '** python-pip **'

pip install graypy
log '** graypy **'
pip install --upgrade pip
log '** pip **'

apt-get install virtualenv -y > /dev/null
log '** virtualenv **'

runuser -l phme -c 'ssh-keyscan bitbucket.org >> /home/phme/.ssh/known_hosts'
runuser -l phme -c 'ssh-keyscan 104.192.143.1 >> /home/phme/.ssh/known_hosts'
curl -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain
mv git-credential-osxkeychain /usr/local/bin/
chmod u+x /usr/local/bin/git-credential-osxkeychain
git config --global credential.helper osxkeychain
runuser -l phme -c 'wget "https://phmecloud.blob.core.windows.net/system/deployment-keys/development/id_rsa?st=2017-01-19T23%3A33%3A00Z&se=2017-01-20T23%3A33%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=4punGhK0mjBGnccIEL9ze%2BheR1LIFd1Eqo60RQ74ECI%3D" -O /home/phme/.ssh/id_rsa'
runuser -l phme -c 'wget "https://phmecloud.blob.core.windows.net/system/deployment-keys/development/id_rsa.pub?st=2017-01-19T23%3A33%3A00Z&se=2017-01-20T23%3A33%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=R3rfeyROcjASpu8OaPNPm0JnmBKfnWVltHbSrvPOh9Q%3D" -O /home/phme/.ssh/id_rsa.pub'
runuser -l phme -c 'chmod 600 /home/phme/.ssh/id_rsa'
runuser -l phme -c 'chmod 644 /home/phme/.ssh/id_rsa.pub'
sudo ssh-agent /bin/bash
ssh-add /home/phme/.ssh/id_rsa

log '** GIT keyscan and credentials **'

# get GIT keys
#cd /home/phme/.ssh
#wget "https://phmecloud.blob.core.windows.net/system/deployment-keys/development/id_rsa?st=2017-01-19T23%3A33%3A00Z&se=2017-01-20T23%3A33%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=4punGhK0mjBGnccIEL9ze%2BheR1LIFd1Eqo60RQ74ECI%3D" -O id_rsa
#wget "https://phmecloud.blob.core.windows.net/system/deployment-keys/development/id_rsa.pub?st=2017-01-19T23%3A33%3A00Z&se=2017-01-20T23%3A33%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=R3rfeyROcjASpu8OaPNPm0JnmBKfnWVltHbSrvPOh9Q%3D" -O id_rsa.pub
#chmod 600 id_rsa
#chmod 644 id_rsa.pub

#ssh-agent /bin/bash
#ssh-add /home/phme/.ssh/id_rsa

exit 0
