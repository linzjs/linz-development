#!/usr/bin/env bash

if [ ! -e /etc/vagrant/ruby ]
then

	echo ">>> setting up ruby"

	# install ruby 1.9.3
	apt-get install -y ruby-full ruby1.9.1-dev zlib1g-dev

	# only run once
	touch /etc/vagrant/ruby

else

	echo ">>> ruby already setup..."

fi
