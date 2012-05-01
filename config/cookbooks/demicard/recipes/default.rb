#execute "apt-get update" do
#  command "apt-get update"
#  action :run
#end
#
include_recipe 'iptables'
iptables_rule 'iptables_ssh'

package 'ruby1.9.1'
package 'rubygems1.9.1'
package 'apache2'

link '/usr/bin/ruby' do
  to '/usr/bin/ruby1.9.1'
end
#include_recipe 'openssl'
#include_recipe 'java' 
#include_recipe 'postgresql::server' 
