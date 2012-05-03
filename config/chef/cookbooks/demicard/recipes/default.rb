include_recipe 'iptables'
iptables_rule 'iptables_ssh'
iptables_rule 'iptables_http'

package 'libcurl4-openssl-dev'
package 'zlib1g-dev'
package 'libopenssl-ruby1.9.1'
package 'apache2-prefork-dev'
package 'libapr1-dev'
package 'libaprutil1-dev'
package 'apache2'
package 'mysql-server-5.1'
package 'git-core'
package 'libyaml-dev'

# ruby
#
remote_file '/tmp/ruby-1.9.3-p194.tar.gz' do
  source 'http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz'
  mode '0644'
  action :create_if_missing
end

execute 'tar xzf ruby-1.9.3-p194.tar.gz' do
  cwd '/tmp'
  creates '/tmp/ruby-1.9.3-p194'
end

execute './configure --prefix=/usr/local --disable-install-doc' do
  cwd '/tmp/ruby-1.9.3-p194'
  creates '/tmp/ruby-1.9.3-p194/Makefile'
end

execute 'make && make install' do
  cwd '/tmp/ruby-1.9.3-p194'
  creates '/usr/local/bin/ruby'
end

execute 'gem install bundler' do
  command 'gem install -v 1.1.3 bundler'
  creates '/usr/local/lib/ruby/gems/1.9.1/gems/bundler-1.1.3/lib/bundler.rb'
end

template '/root/.gemrc' do
  source 'gemrc'
end

# TODO: stage only
# template '/tmp/.gemrc' do
#   source 'gemrc'
# end

# passenger
#
execute 'gem install passenger' do
  command 'gem install -v 3.0.12 passenger'
  creates '/usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.12/bin/passenger'
end

execute 'passenger-install-apache2-module' do
  command 'passenger-install-apache2-module -a'
  creates '/usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.12/ext/apache2/mod_passenger.so'
end

template '/etc/apache2/mods-available/passenger.load' do
  source 'passenger.load'
end

template '/etc/apache2/mods-available/passenger.conf' do
  source 'passenger.conf'
end

execute 'a2enmod passenger' do
  command 'a2enmod passenger'
  creates '/etc/apache2/mods-enabled/passenger'
end

# deployer user
#
user 'deployer' do
  home '/home/deployer'
  shell '/bin/bash'
  supports({:manage_home => true})
end

directory '/home/deployer/.ssh' do
  mode '0700'
  owner 'deployer'
  group 'deployer'
end

template '/home/deployer/.ssh/authorized_keys' do
  source 'deployer_ssh_authorized_keys'
  owner 'deployer'
  group 'deployer'
  mode '0644'
end

# capistrano
#
directory '/u' do
  mode '0755'
  owner 'deployer'
  group 'deployer'
end

# demicard apache site
#
template '/etc/apache2/sites-available/demicard' do
  source 'demicard_site'
  owner 'root'
  group 'root'
end

execute 'a2dissite default' do
end

execute 'a2ensite demicard' do
end

# restart apache
#
service "apache2" do
  action :restart
end
