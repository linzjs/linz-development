# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require "json"

def fail_with_message(msg)
  fail Vagrant::Errors::VagrantError.new, msg
end

# Load in external config
config_file = "#{File.dirname(__FILE__)}/vagrant.json"
vm_ext_conf = JSON.parse(File.read(config_file))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.

    # VM configuration for vmware_fusion
    config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = vm_ext_conf["memory"]
        v.vmx["numvcpus"] = vm_ext_conf["cpus"]
    end

    # VM configuration for virtualbox
    config.vm.provider "virtualbox" do |vb|
        vb.memory = vm_ext_conf["memory"]
        vb.cpus = vm_ext_conf["cpus"]
    end

    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "phusion/ubuntu-14.04-amd64"

    # Set the host ip
    config.vm.hostname = vm_ext_conf["hostname"]

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network "forwarded_port", guest: 80, host: 4000

    # using NFS to increase speed between synchronised folders https://coderwall.com/p/uaohzg, https://docs.vagrantup.com/v2/synced-folders/nfs.html
    # config.vm.synced_folder ".", "/vagrant", type: 'nfs'
    config.vm.synced_folder ".", "/vagrant", type: 'nfs'
    config.vm.synced_folder "../linz", "/linz", type: 'nfs'
    config.vm.synced_folder "../linz-minitwitter-basic/app", "/vagrant/app/root/app", type: 'nfs'

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network 'private_network', type: 'dhcp'

    ip = ''

    # Setup hostmanager for dhcp.
    if Vagrant.has_plugin?('vagrant-hostmanager')
        config.hostmanager.aliases = %W(#{vm_ext_conf['aliases'].compact.join(' ')})
        config.hostmanager.enabled = true
        config.hostmanager.manage_guest = true
        config.hostmanager.manage_host = true

        # Dynamically determine the IP address of the VM.
        config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
            if hostname = (vm.ssh_info && vm.ssh_info[:host])
                vm.communicate.execute("/bin/hostname -I | cut -d ' ' -f 2") do |type, contents|
                    ip = contents.split()[0]
                end
            end
            ip
        end
    else
        fail_with_message "vagrant-hostmanager missing, please install the plugin with this command:\nvagrant plugin install vagrant-hostmanager"
    end

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    config.ssh.forward_agent = true

    # configuration step 0: set the host ip as an environment variable within the VM itself
    config.vm.provision "shell", inline: "echo ""export HOST_IP=#{vm_ext_conf["ip"]}"" > /etc/profile.d/hostip.sh"

    # configuration step 2: Setup environment variables.
    config.vm.provision "shell", path: "vagrant/env.sh"

    # configuration step 2: setup apt-get
    config.vm.provision "shell", path: "vagrant/apt-get.sh"

    # configuration step 3: install docker
    config.vm.provision "shell", path: "vagrant/docker.sh"

    # configuration step 3: install Docker Compose
    config.vm.provision "shell", path: "vagrant/docker-compose.sh"

    # configuration step 4: install git
    config.vm.provision "shell", path: "vagrant/git.sh"

    # configuration step 5: install nodejs
    config.vm.provision "shell", path: "vagrant/nodejs.sh"

    # configuration step 7: install mongo shell and tools only (the actual DB will run on Docker)
    config.vm.provision "shell", path: "vagrant/mongo.sh"

    # configuration step 9: setup the development environment
    config.vm.provision "shell", path: "vagrant/dependencies.sh"

    # configuration step 10: clean-up!
    config.vm.provision "shell", path: "vagrant/clean.sh"

end
