Vagrant.require_version ">= 1.4.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.box_download_checksum = "9a8bdea70e1d35c1d7733f587c34af07491872f2832f0bc5f875b536520ec17e"
  config.vm.box_download_checksum_type = "sha256"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]

    # add to improve NAT performance in VirtualBox
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    vb.cpus = 4
  end

  config.vm.provision :puppet
  config.ssh.forward_agent = true

  # enable host network, for nfs file access
  config.vm.network "private_network", ip: "192.168.33.10"

  # uncomment and add path to case-sensitive disk image
  # config.vm.synced_folder "/Volumes/cyanogen", "/opt/cyanogen", type: "nfs"
end
