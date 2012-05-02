#execute "apt-get update" do
#  command "apt-get update"
#  action :run
#end
#
include_recipe 'iptables'
iptables_rule 'iptables_ssh'

package 'build-essential'
package 'libcurl4-openssl-dev'
package 'zlib1g-dev'
package 'ruby1.9.1'
package 'ruby1.9.1-dev'
package 'libopenssl-ruby1.9.1'
package 'apache2-prefork-dev'
package 'libapr1-dev'
package 'libaprutil1-dev'
package 'apache2'
package 'mysql-server-5.1'

link '/usr/bin/ruby' do
  to '/usr/bin/ruby1.9.1'
end

# rubygems
#
remote_file '/home/vagrant/rubygems-1.8.24.tgz' do
  source 'http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz'
  mode '0644'
  action :create_if_missing
end

execute 'tar xzf rubygems-1.8.24.tgz' do
  cwd '/home/vagrant'
  command 'tar xzf rubygems-1.8.24.tgz'
  creates '/home/vagrant/rubygems-1.8.24'
end

execute 'ruby setup.rb' do
  cwd '/home/vagrant/rubygems-1.8.24'
  command 'ruby setup.rb'
  creates '/usr/bin/gem1.9.1'
end

link '/usr/bin/gem' do
  to '/usr/bin/gem1.9.1'
end

template '/root/.gemrc' do
  source 'gemrc'
end

template '/home/vagrant/.gemrc' do
  source 'gemrc'
end

# passenger
#
execute 'gem install passenger' do
  command 'gem install -v 3.0.12 passenger'
  creates '/var/lib/gems/1.9.1/gems/passenger-3.0.12/bin/passenger'
end

execute 'passenger-install-apache2-module' do
  command 'passenger-install-apache2-module -a'
  creates '/usr/lib/ruby/gems/1.9.1/gems/passenger-3.0.12/ext/apache2/mod_passenger.so'
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

service "apache2" do
  action :restart
end

#include_recipe 'openssl'
#include_recipe 'java' 
#include_recipe 'postgresql::server' 
