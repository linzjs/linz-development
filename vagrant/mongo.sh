#!/usr/bin/env bash

if [ ! -e /etc/vagrant/mongo ]
    then

    echo ">>> setting up mongo shell and tools"

    # install mongo
    apt-get install -y mongodb-org-shell mongodb-org-tools

    # only run once
    touch /etc/vagrant/mongo
    
else

    echo ">>> mongo shell and tools is already setup"

fi
