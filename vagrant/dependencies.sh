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

    if [ ! -e /usr/lib/node_modules/linz ]; then
        ln -s /linz /usr/lib/node_modules/linz
    fi

    # install gulp
    npm install -g gulp

    # install bower
    npm install -g bower

    # Install Travis CLI.
    gem install travis -v 1.8.5 --no-rdoc --no-ri

}

# Execute the function above, in an idempotent function.
bashurator.configure "dependencies" configure_dependencies
