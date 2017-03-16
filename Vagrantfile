# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Make sure we have the vagrant-hostmanager plugin. No point in going forward with out it.
if !(Vagrant.has_plugin?('vagrant-hostmanager'))
    fail_with_message "vagrant-hostmanager missing, please install the plugin with this command:\nvagrant plugin install vagrant-hostmanager\n"
end

require "json"

# Load in external config
config_file = "#{File.dirname(__FILE__)}/vagrant.json"
vm_ext_conf = JSON.parse(File.read(config_file))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "phusion/ubuntu-14.04-amd64"

    # VM configuration for vmware_fusion
    config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = vm_ext_conf["memory"]
        v.vmx["numvcpus"] = vm_ext_conf["cpus"]
    end

    # VM configuration for virtualbox
    config.vm.provider "virtualbox" do |vb|

        vb.memory = vm_ext_conf["memory"]
        vb.cpus = vm_ext_conf["cpus"]

        # Make VirtualBox work like VMware and use the host's resolving as a DNS proxy in NAT mode
        # https://www.virtualbox.org/manual/ch09.html#nat_host_resolver_proxy
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on" ]

    end

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", type: "dhcp"

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network "public_network"

    # define the hostname
    config.vm.hostname = vm_ext_conf["hostname"]

    # Setup hostmanager plugin.
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.aliases = %W(#{vm_ext_conf['hostAliases']})

    # Dynamically determine the IP address of the VM.
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
        ip = ""
        if hostname = (vm.ssh_info && vm.ssh_info[:host])
            vm.communicate.execute("/bin/hostname -I | cut -d ' ' -f 2") do |type, contents|
                ip = contents.split()[0]
            end
        end
        ip
    end

    # If true, then any SSH connections made will enable agent forwarding.
    config.ssh.forward_agent = true

    # using NFS to increase speed between synchronised folders https://coderwall.com/p/uaohzg, https://docs.vagrantup.com/v2/synced-folders/nfs.html
    # config.vm.synced_folder ".", "/vagrant", type: 'nfs'
    config.vm.synced_folder ".", "/vagrant", type: 'nfs'
    config.vm.synced_folder "../linz", "/linz", type: 'nfs'
    config.vm.synced_folder "../linz-minitwitter-basic/app", "/vagrant/app/root/app", type: 'nfs'

    # configuration step 1: Setup environment variables.
    config.vm.provision "shell", path: "vagrant/env.sh"

    # configuration step 2: setup apt-get
    config.vm.provision "shell", path: "vagrant/apt-get.sh"

    # configuration step 3: install docker
    config.vm.provision "shell", path: "vagrant/docker.sh"

    # configuration step 4: install Docker Compose
    config.vm.provision "shell", path: "vagrant/docker-compose.sh"

    # configuration step 5: install git
    config.vm.provision "shell", path: "vagrant/git.sh"

    # configuration step 6: install nodejs
    config.vm.provision "shell", path: "vagrant/nodejs.sh"

    # configuration step 7: install mongo shell and tools only (the actual DB will run on Docker)
    config.vm.provision "shell", path: "vagrant/mongo.sh"

    # configuration step 8: install ruby
    config.vm.provision "shell", path: "vagrant/ruby.sh"

    # configuration step 9: setup the development environment
    config.vm.provision "shell", path: "vagrant/dependencies.sh"

    # configuration step 10: clean-up!
    config.vm.provision "shell", path: "vagrant/clean.sh"

end
