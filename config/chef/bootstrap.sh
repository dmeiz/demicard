apt-get update && \
apt-get install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert curl && \
cd /tmp && \
wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz && \
tar xzf rubygems-1.8.24.tgz && \
cd rubygems-1.8.24 && \
ruby setup.rb && \
gem install chef
