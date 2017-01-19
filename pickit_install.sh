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

apt-get install phantomjs -y > /dev/null
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
apt-get install apache2-utils -y > /dev/null

service newrelic-sysmond start
apt-get install bind9 -y > /dev/null
apt-get install dnsutils -y > /dev/null
apt-get install redis-tools -y > /dev/null
apt-get install python-pip -y > /dev/null

pip install graypy
pip install --upgrade pip

apt-get install virtualenv -y > /dev/null

ssh-keyscan bitbucket.org >> /home/phme/.ssh/known_hosts
curl -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain
mv git-credential-osxkeychain /usr/local/bin/
chmod u+x /usr/local/bin/git-credential-osxkeychain
git config --global credential.helper osxkeychain
ssh-agent /bin/bash
