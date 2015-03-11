#!/usr/bin/env bash

if [ ! -e /etc/vagrant/development ]
then

	echo ">>> setting up the development tools"

	# install gulp
	npm install -g gulp

	# install bower
	npm install -g bower

	# install bundler
	gem install bundler --no-ri --no-rdoc

	# create a directory for our Jekyll build destination
	mkdir /ghpages/build

	# install Jekyll
	cd /ghpages/src && bundle install

	# setup a symlink to linz
	ln -s /usr/lib/node_modules/linz /linz

	# create a symlink to the ghpages script
	chmod +x /vagrant/vagrant/scripts/ghpages
	ln -s /vagrant/vagrant/scripts/ghpages /usr/bin/ghpages

	# only run once
    touch /etc/vagrant/development

else

	echo ">>> development tools already development..."

fi
