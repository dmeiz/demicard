class Demicard < Thor
  desc 'rsync_to_stage', 'Rsync current directory to stage server to avoid cap deploys'
  def rsync_to_stage
    system %q(rsync -av -e 'ssh -p 2222' --exclude .git . deployer@localhost:/u/apps/demicard/current)
  end

  desc 'bootstrap_production', 'Bootstrap production server, making it ready to provision with chef'
  def bootstrap_production
    #  - apt-get install dselect
    #  - dselect update
    #  - apt-get install build-essential libyaml-dev zlib1g-dev rsync
    #  - cd /tmp
    #  - wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
    #  - tar xzf ruby-1.9.3-p194.tar.gz
    #  - cd ruby-1.9.3-p194
    #  - ./configure --prefix=/usr/local
    #  - make && make install
    #  - gem install --no-ri --no-rdoc chef
    run_command('rsync -av config/chef root@demicard.methodhead.com:/tmp')
    run_command('chef-solo -c /tmp/chef/solo.rb -j /tmp/chef/solo.json')
  end

  private

  def run_command(command)
    puts(command)
    system(command)
  end
end
