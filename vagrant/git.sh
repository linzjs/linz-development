#!/usr/bin/env bash

source /vagrant/vagrant/bashurator/init.sh

# Setup the environment.
configure_git() {

    # Install Git.
    apt-get install -y git

    # install hub cli, from GitHub
    mkdir -p /opt/hub && \
    curl -sSL https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz | tar -xz -C /opt/hub --strip-components 1 && \
    /opt/hub/install && \
    rm -rf /opt/hub/* && \
    alias git=hub

}

# Execute the function above, in an idempotent function.
bashurator.configure "git" configure_git
