# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  ## Set base box.
  # config.vm.box = 'centos/7'

  ## Configure memory and the number of CPU.
  # config.vm.provider :virtualbox do |vb|
  #   vb.memory = 2048
  #   vb.cpus = 4
  # end

  ## Configure plugins.
  # config.vagrant.plugins = ['vagrant-vbguest']
  # config.vbguest.auto_update = false

  ## When disabling inserting key, vagrant will use `~/.vagrant.d/insecure_private_key` to connect to
  ## this box, and the final packaged box will contain the corresponding public key, so new boxes created
  ## from this base box by default will have insecure pair of ssh key replaced with a new pair of ssh key.
  ## Ref: https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html#config-ssh-insert_key
  # config.ssh.insert_key = false

  ## Enable ssh key forwarding.
  # config.ssh.forward_agent = true

  ## Provision with external shell script.
  # config.vm.provision :shell, path: 'path_relative_to_current_dir', args: ['arg'], privileged: false, env: { foo: 'bar' }

  ## Provision with inline shell script.
  # config.vm.provision :shell, run: :always, inline: <<-SHELL
  #   echo foo
  # SHELL

  ## Use `VBoxManage list bridgedifs` to get all network interfaces. When
  ## omitting `bridge` option, Vagrant will ask you to select an interface. The
  ## `ip` option can also be omitted.
  # config.vm.network :public_network, bridge: 'network_interface_name', ip: '192.168.0.2'

  ## Change the promiscuous mode and mac address of the second NIC. The mac
  ## address should not contain colon.
  # config.vm.provider :virtualbox do |vb|
  #   vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
  #   vb.customize ['modifyvm', :id, '--macaddress2', 'ffffffffffff']
  # end

  ## Attach a USB device to the VM.
  ## Use `VBoxManage list usbhost` to find the `vendorid` and `productid`.
  # config.vm.provider :virtualbox do |vb|
  #   vb.customize ['modifyvm', :id, '--usb', 'on']
  #   vb.customize ['modifyvm', :id, '--usbehci', 'on']
  #   vb.customize ['usbfilter', 'add', '0',
  #     '--target', :id,
  #     '--name', 'USB device name',
  #     '--vendorid', 'vendorid',
  #     '--productid', 'productid']
  # end
end
