# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile copies the current user's private key into the vm on creation.
# So don't repackage and distribute the box without cleaning this up!

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.synced_folder "~/.ssh", "/host_ssh"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.network :forwarded_port, guest: 31337, host: 31337
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :shell, :inline => %Q{

    install -o vagrant -g vagrant -m 600 \
      /host_ssh/id_rsa ~vagrant/.ssh/id_rsa

    echo -e "Host github.com\n  StrictHostKeyChecking no" >> /etc/ssh/ssh_config

    export DEBIAN_FRONTEND=noninteractive
    apt-get -qq update
    apt-get -y install \
      git mysql-server memcached redis-server build-essential \
      ruby1.9.1 ruby1.9.1-dev libruby1.9.1 libssl-dev libxml2-dev libxslt1-dev \
      unixodbc-dev libmysqlclient-dev sphinxsearch chrpath git-core libssl-dev \
      libfontconfig1-dev

    wget -q https://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2
    tar xf phantomjs-1.9.1-linux-x86_64.tar.bz2
    cp phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/bin

    gem install bundler
    sudo -u vagrant -i sh -c "git clone git@github.com:PeopleAdmin/hr_suite portals"
    sudo -u vagrant -i sh -c "cd portals; bundle"

    install -o vagrant -g vagrant ~vagrant/portals/sample.env ~vagrant/portals/.env
    echo "drop database if exists acceptance_test" | mysql -uroot
    echo "create database acceptance_test" | mysql -uroot
    mysql -uroot acceptance_test < ~vagrant/portals/hr_suite/db/gold_sites/ats_gold_site.sql
  }

end

