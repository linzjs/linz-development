#!/usr/bin/env bash

if [ ! -e /etc/vagrant/apt-get ]
then

	echo ">>> setting up apt-get"

	# Required for nodejs
	curl -sL https://deb.nodesource.com/setup | sudo bash -

	# Required for mongodb
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

	# Required for add-apt-repository
	apt-get install -y software-properties-common build-essential

	# update apt-get
	apt-get update

	# only run once
	touch /etc/vagrant/apt-get

else

	echo ">>> apt-get is already setup..."

fi
