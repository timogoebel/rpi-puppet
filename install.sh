#!/bin/sh

wget -O - http://apt.cegeka.be/puppetlabs/pubkey.gpg | apt-key add -
echo 'deb http://apt.cegeka.be/puppetlabs/ wheezy main dependencies' > /etc/apt/sources.list.d/cegeka.list

apt-get update
apt-get -y install puppet-common
apt-get -y install git

rm -rf /etc/puppet

git clone https://github.com/timogoebel/rpi-puppet.git /etc/puppet

apt-get -y install ruby-dev
gem install --no-ri --no-rdoc librarian-puppet

cd /etc/puppet
librarian-puppet install
puppet apply --verbose /etc/puppet/manifests/config.pp
cd - >/dev/null

echo '17 05 * * * root /etc/puppet/update.sh' > /etc/cron.d/puppetrun
