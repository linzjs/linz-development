# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

def fail_with_message(msg)
  fail Vagrant::Errors::VagrantError.new, msg
end

# Make sure we have the vagrant-hostmanager plugin. No point in going forward with out it.
if !(Vagrant.has_plugin?('vagrant-hostmanager'))
  fail_with_message "vagrant-hostmanager missing, please install the plugin with this command:\nvagrant plugin install vagrant-hostmanager"
end

CONFIG_PATH = __dir__
config_file = File.join(CONFIG_PATH, 'vagrant.json')

if File.exists?(config_file)
  custom_config = JSON.parse(File.read(config_file))
else
  fail_with_message "#{config_file} was not found. Please set `CONFIG_PATH` in your Vagrantfile."
end

Vagrant.configure('2') do |config|
  config.hostmanager.aliases = %W(#{custom_config['hostAliases']})
  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true
  config.hostmanager.manage_host = true
  config.ssh.insert_key = false
  config.vm.box = custom_config['box_path']
  config.vm.box_version = custom_config['box_version']
  config.vm.hostname = custom_config['hostname']
  config.vm.network 'private_network', type: 'dhcp'

  # Dynamically determine the IP address of the VM.
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    ip = ''
    if hostname = (vm.ssh_info && vm.ssh_info[:host])
      vm.communicate.execute("/bin/hostname -I | cut -d ' ' -f 2") do |type, contents|
        ip = contents.split()[0]
      end
    end
    ip
  end

  config.vm.provider :vmware_fusion do |v, override|
    v.gui = false
    v.vmx['memsize'] = custom_config['memory']
    v.vmx['numvcpus'] = custom_config['cpus']
    v.whitelist_verified = true
  end

  config.vm.provider :virtualbox do |v, override|
    v.customize ['modifyvm', :id, '--cpus', custom_config['cpus']]
    v.customize ['modifyvm', :id, '--ioapic', 'on']
    v.customize ['modifyvm', :id, '--memory', custom_config['memory']]
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.gui = false
  end

  # Share the folder between host and VM
  config.vm.synced_folder '.', '/vagrant'
  config.vm.synced_folder '../linz', '/linz'
  config.vm.synced_folder '../linz-minitwitter-basic/app', '/vagrant/app/root/app'

  # configuration step 1: Setup environment variables.
  config.vm.provision "shell", path: "vagrant/env.sh"

  # configuration step 2: setup the development environment
  config.vm.provision "shell", path: "vagrant/dependencies.sh"

end
