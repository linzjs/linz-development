#!/usr/bin/env bash

source /vagrant/vagrant/bashurator/init.sh

# Setup the environment.
configure_nodejs() {

    # install nodejs
    apt-get install -y nodejs

    # upgrade npm to the latest
    npm -g install npm@latest

}

# Execute the function above, in an idempotent function.
bashurator.configure "nodejs" configure_nodejs
