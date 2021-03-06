# -*- mode: ruby -*-
# vi: set ft=ruby :

# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "{vm_box}"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # forward the host machines ssh agent to guest:
  config.ssh.forward_agent = true

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "./", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "{vm_memory}"
    vb.name   = "{vm_name}"
  end

  # fix for error 'stdin is not a tty' on ubuntu boxes
  # stolen from http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
  config.vm.provision :shell do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  # Enable ssh forward_agent
  config.ssh.forward_agent = true

  # Set vm hostname
  config.vm.hostname = "{vm_name}"

  # The `./setup` script will ask which env-{environment} should be executed.
  config.vm.provision :shell, path: 'bootstrap', privileged: false, keep_color: true
end
