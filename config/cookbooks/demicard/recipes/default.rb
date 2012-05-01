#execute "apt-get update" do
#  command "apt-get update"
#  action :run
#end
#
include_recipe 'iptables'
iptables_rule 'iptables_ssh'

package 'ruby1.9.1'
package 'apache2'

link '/usr/bin/ruby' do
  to '/usr/bin/ruby1.9.1'
end

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

#execute 'gem install passenger' do
#  command 'gem install passenger'
#  action :run
#end
#
#execute 'passenger-install-apache2-module' do
#  command 'passenger-install-apache2-module'
#  action :run
#end
#include_recipe 'openssl'
#include_recipe 'java' 
#include_recipe 'postgresql::server' 
