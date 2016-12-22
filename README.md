# Linz development

A complete development environment for Linz. All in a few commands.

This development environment uses a virtual machine on your host to provide everything you'll need to start developing on Linz. It will install Ubuntu 14.04 and a bunch of other tools required for Linz development. This setup provides support for editing both Linz, and Linz's documentation.

The only requirement of your host machine is Git, and an editor (of course, you could always use something like Vim inside the VM itself).

Once you've set everything up, the development workflow is a little bit like this:

- [host]    Create a new branch on your forked version of Linz.
- [host]    Make some changes to Linz.
- [host]    `vagrant ssh`.
- [vm]      `cd /vagrant`.
- [vm]      `/website/run`.
- [host]    In your browser, access test website at http://192.168.200.6 and test your changes.

Once you're satisfied:

- [vm]      `./test`.
- [host]    If you get a green light from testing, `git commit -m "I've built something fantastic for Linz."`.
- [host]    `git push`.

Then raise a PR on GitHub :)

That is the most simple test case. Of course, you can develop Linz alongside any other project you might be using. This is how the core Linz developers do it. It's just a matter of symlinking your {project}/node_modules/{linz} folder to the development version on your host. It's easy to achieve regardless if you always develop on your host, or you use something like Vagrant.

## Requirements

In order to get started, you'll need the following:

- [Vagrant](https://www.vagrantup.com/).
- [VMWare](http://www.vmware.com/]) or [VirtualBox](https://www.virtualbox.org/).
- A [GitHub](https://github.com/) account.
- Git on your host.

## Getting started

- Make a clone of the [Linz development repository](https://github.com/smebberson/linz-development).
- Make a clone of the [Linz repository](https://github.com/smebberson/linz) into a directory called `linz` (alongside the `linz-development` directory from the line above).
- Start your VM by running `vagrant up --provider=vmware_fusion` (change `vmware_fusion` with whichever provider you like).

After a while, you should have a VM ready to go.

The source is always available on your host machine, and should be the primary place for interacting with the repository via Git, or editing the source in your favourite editor. Everything else such as any build and test scripts will happen inside the VM.

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
