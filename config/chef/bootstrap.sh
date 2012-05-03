apt-get update && \
apt-get install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert curl rsync && \
cd /tmp && \
wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz && \
tar xzf rubygems-1.8.24.tgz && \
cd rubygems-1.8.24 && \
ruby setup.rb && \
gem1.8 install --no-ri --no-rdoc chef
