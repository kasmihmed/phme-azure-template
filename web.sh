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
sudo gem install compass -v 1.0.3
