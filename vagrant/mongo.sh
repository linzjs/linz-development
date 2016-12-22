#!/usr/bin/env bash

source /vagrant/vagrant/bashurator/init.sh

# Setup the environment.
configure_mongo() {

    # install mongo
    apt-get install -y mongodb-org-shell mongodb-org-tools

    # setup a place for our data to live (MongoDB)
    groupadd -r mongodb
    useradd -r -g mongodb mongodb
    mkdir -p /data/mongodb
    chown -R mongodb:mongodb /data/mongodb

    # This will affect the mongo instance running in Docker.
    # It has to happen on the Docker host though, not in the containers themselves.
    bash -c 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
    bash -c 'echo never > /sys/kernel/mm/transparent_hugepage/defrag'

}

# Execute the function above, in an idempotent function.
bashurator.configure "mongo" configure_mongo
