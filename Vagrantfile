# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile copies the current user's private key into the vm on creation.
# So don't repackage and distribute the box without cleaning this up!

Vagrant.configure('2') do |config|

  config.ssh.private_key_path = '~/.ssh/id_dsa'
  #config.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
  config.vm.box = 'precise64'
  config.image = 'Ubuntu 12.10 x64'

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_dsa'
    # using dsa for personal account, rsa is my work ssh key
    # override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
    config.ssh.private_key_path = '~/.ssh/id_rsa'
    provider.ca_path = '/etc/ssl/certs/ca-certificates.crt'
    provider.image = 'Ubuntu 12.10 x64'
    provider.region = 'New York 2'
    provider.client_id = ENV['DO_CLIENT_ID']
    provider.api_key = ENV['DO_API_KEY']
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_KEY']
    aws.keypair_name = ENV['AWS_KEYPAIR_NAME']

    #aws.ami = 'ami-7747d01e'
    #aws.instance_type = ''
    #aws.availability_zone = ''
    #aws.region = ''
    aws.tags = {
      'Name' => "Ruby Pair Box: #{Time.now}",
      'date_created' => "#{Date.today}"
    }

    override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = '~/.ssh/id_dsa'
  end

  config.vm.network :forwarded_port, guest: 5900, host: 5900
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :shell, :path => "install-rvm.sh",  :args => "stable"
  config.vm.provision :shell, :path => "install-ruby.sh", :args => "2.0.0-p353"
  config.vm.provision :shell, :inline => %Q{

    install -o vagrant -g vagrant -m 600 \
      /host_ssh/id_dsa ~vagrant/.ssh/id_dsa

    echo -e "Host github.com\n \
    StrictHostKeyChecking no\n \
    GatewayPorts yes" \n \
    PasswordAuthentication yes \n \
    UsePam yes \n \
    >> /etc/ssh/ssh_config

    export DEBIAN_FRONTEND=noninteractive
    apt-get -qq update
    apt-get -y install \
    autoconf automake build-essential bison chrpath curl firefox git-core \
    ghostscript libgs-dev gs-esp libtool libgdbm-dev libfontconfig1-dev \
    libffi-dev libreadline6 libreadline6-dev libssl-dev libyaml-dev \
    libmysqlclient-dev libncurses5-dev libxml2 libxml2-dev libxslt-dev \
    libxslt1-dev libfontconfig1-dev libsqlite3-0 libsqlite3-dev libqt4-dev \
    libqtwebkit-dev libc6-dev mysql-client mysql-server memcached nodejs \
    openssl openjdk-7-jre-headless postgresql postgresql-contrib \
    postgresql-server-dev-9.1 pkg-config redis-server sqlite3 tightvncserver \
    tmux unixodbc-dev vim xtightvncviewer xvfb zlib1g zlib1g-dev  -y

    echo "install screen sharing libraries"
    wget http://64.34.173.142/download/3.5.0/Linux/nxclient_3.5.0-7_amd64.deb
    wget http://64.34.173.142/download/3.5.0/Linux/nxnode_3.5.0-9_amd64.deb
    wget http://64.34.173.142/download/3.5.0/Linux/FE/nxserver_3.5.0-11_amd64.deb
    sudo dpkg -i nxnode_3.5.0-3_i386.deb nxserver_3.5.0-4_i386.deb \
    > nxclient_3.5.0-7_i386.deb
    service ssh restart
    /etc/init.d/nxserver restart

    echo "install phantomjs"
    wget -q https://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2
    tar xf phantomjs-1.9.1-linux-x86_64.tar.bz2
    cp phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/bin

    echo "install elasticsearch"
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.9.deb
    sudo dpkg -i elasticsearch-0.90.9.deb

    echo "create gemset, install rails"
    source /etc/profile.d/rvm.sh
    rvm use ruby-2.0.0-p353@pair --create
    gem install bundler
    gem install rails

    sudo -u vagrant -i sh -c "git clone git@github.com:harrisjosh/dots dots"

  }

    # echo "cd into rails project, bundle"
    #sudo -u vagrant -i sh -c "cd pair_box; bundle"

    # echo "install .env file from sample in project"
    #install -o vagrant -g vagrant ~vagrant/pair_box/sample.env ~vagrant/pair_box/.env

    ### FOR MYSQL PROJECT WITH SAMPLE DB
    # echo "drop old db and create mysql db, use sql file in project to populate"

    #echo "drop database if exists pair_db" | mysql -uroot
    #echo "create database pair_db" | mysql -uroot
    #mysql -uroot pair_db < ~vagrant/pair_box/db/sample_pair_project_db.sql

   ### FOR PG PROJECT, NO SAMPLE DB FILE

   # rake db:setup
   # rake db:migrate
   # rake test:prepare

end

