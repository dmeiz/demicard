class Demicard < Thor
  desc 'rsync_to_stage', 'Rsync current directory to stage server to avoid cap deploys'
  def rsync_to_stage
    system %q(rsync -av -e 'ssh -p 2222' --exclude .git . deployer@localhost:/u/apps/demicard/current)
  end

  desc 'bootstrap env=stage', 'Bootstrap server'
  def bootstrap(env = 'stage')
    user, host, options = user_host_options(env)

    # create user dan
    #
    run_command("scp #{options} config/chef/create_dan.sh #{user}@#{host}:/tmp")
    run_command("ssh #{options} #{user}@#{host} 'sudo sh /tmp/create_dan.sh'")

    # bootstrap for chef
    #
    run_command("scp #{options} config/chef/bootstrap.sh dan@#{host}:/tmp")
    run_command("ssh #{options} #{user}@#{host} 'sudo sh /tmp/bootstrap.sh'")
  end

  desc 'provision env=stage', 'Provision server with chef'
  def provision(env = 'stage')
    user, host, options = user_host_options(env)

    run_command(%Q(rsync -av -e "ssh #{options}" config/chef dan@#{host}:/tmp))
    run_command("ssh #{options} dan@#{host} 'sudo chef-solo -c /tmp/chef/solo.rb -j /tmp/chef/solo.json'")
  end

  desc 'ipfw env=development,stage', 'Forward port 80 for test'
  def ipfw(env = 'development')
    port = {'stage' => 8080, 'development' => 3000}[env]
    run_command('sudo ipfw delete 80')
    run_command("sudo ipfw add 80 fwd 127.0.0.1,#{port} tcp from any to me 80")
  end

  private

  def user_host_options(env)
    case env
    when 'stage' then ['vagrant', 'localhost', %q(-o 'Port 2222')]
    when 'production' then ['root', 'demicard.methodhead.com', '']
    else raise "Unexpected env '#{env}'"
    end
  end

  def run_command(command)
    puts(command)
    system(command)
  end
end
