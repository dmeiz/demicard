#execute "apt-get update" do
#  command "apt-get update"
#  action :run
#end
#
#include_recipe 'iptables'
#include_recipe 'openssl'
#include_recipe 'java' 
#include_recipe 'postgresql::server' 
