# Linz development

A complete development environment for Linz. All in a few commands.

This development environment uses a virtual machine on your host to provide everything you'll need to start developing on Linz. It will install Ubuntu 14.04 and a bunch of other tools required for Linz development. This setup provides support for editing both Linz, and Linz's documentation.

## Requirements

In order to get started, you'll need the following:

- [Vagrant](https://www.vagrantup.com/).
- Vagrant Host Manager plugin (execute `vagrant plugin install vagrant-hostmanager` to install).
- [VMWare](http://www.vmware.com/]) or [VirtualBox](https://www.virtualbox.org/).
- A [GitHub](https://github.com/) account.
- Git on your host.

## Getting started

- Make a clone of the [Linz development repository](https://github.com/smebberson/linz-development).
- Make a clone of the [Linz repository](https://github.com/smebberson/linz) into a directory called `linz` (alongside the `linz-development` directory from the line above).
- Make a clone of the [linz-minitwitter-basic repository](https://github.com/smebberson/linz-minitwitter-basic) into a directory called `linz-minitwitter-basic` (alongside the `linz-development` directory from the line above).
- Start your VM by running `vagrant up --provider=virtualbox`.

After a while, you should have a VM ready to go.

The source is always available on your host machine, and should be the primary place for interacting with the repository via Git, or editing the source in your favourite editor. Everything else such as any build and test scripts will happen inside the VM.

## Running linz-minitwitter-basic

linz-minitwitter-basic is a good example of a basic Linz.js website. It's also the default application to program Linz against. To preview Linz running against linz-minitwitter-basic, follow these steps.

- [host]    `vagrant ssh` to gain access the guest VM.
- [vm]      `cd /vagrant` (everything happens from this directory).
- [vm]      `dc build` to build the Docker containers.
- [vm]      `dc up -d && dc logs -f` to start the Docker containers, and tail the logs.

You should now be able to visit http://dev.linz.local. Visit http://dev.linz.local/bootstrap-users to create a default user within Linz with a username of `test` and `password` has been created for you. To log into Linz visit http://dev.linz.local/admin, enter the username and password and hit `Sign-in`.

## Viewing the documentation

A local version of readthedocs.org is setup, so that the documentation can be reviewed locally for errors, before committing to the repository.

You only need to do the following once:

- [host]    `vagrant ssh` to gain access to the guest VM.
- [vm]      `cd /vagrant` (everything happens from this directory).
- [vm]      `npm install` to install all NPM modules (i.e. Gulp).

Do the following every time:

- [host]    `vagrant ssh` to gain access to the guest VM.
- [vm]      `cd /vagrant` (everything happens from this directory).
- [vm]      `dc build` to build the Docker containers.
- [vm]      `dc up -d && dc logs -f` to start the Docker containers, and tail the logs.

You should now be able to visit http://docs.linz.local:8043 to browse the documentation.
In another terminal window, to automatically rebuild the documentation on file change:

- [host]    `vagrant ssh` to gain access to the guest VM.
- [vm]      `cd /vagrant` (everything happens from this directory).
- [vm]      `gulp docs-build-watch` to rebuild the documentation.

## License

(The MIT License (MIT))

Copyright (c) 2015 Scott Mebberson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
