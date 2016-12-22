#!/usr/bin/env bash

source /vagrant/vagrant/bashurator/init.sh

# Setup the environment.
configure_dependencies() {

    # alias the docker-clean-containers script
    if [ ! -e /usr/local/bin/docker-clean-containers ]; then
        ln -s /vagrant/vagrant/scripts/docker-clean-containers.sh /usr/local/bin/docker-clean-containers
    fi

    if [ ! -e /usr/local/bin/docker-clean-images ]; then
        ln -s /vagrant/vagrant/scripts/docker-clean-images.sh /usr/local/bin/docker-clean-images
    fi

    # install gulp
    npm install -g gulp

    # install bower
    npm install -g bower

    # setup a symlink to linz
    ln -s /usr/lib/node_modules/linz /linz

}

# Execute the function above, in an idempotent function.
bashurator.configure "dependencies" configure_dependencies
