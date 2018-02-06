#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update

package 'nginx'

service "nginx" do
    action [:enable, :start]
end

# install nodejs

remote_file '/tmp/nodesource_setup.sh' do
    source 'https://deb.nodesource.com/setup_6.x'
    action :create
end

execute "update node resources" do
    command "sh /tmp/nodesource_setup.sh"
end

package 'nodejs' do
    action :upgrade
end

apt_repository 'mongodb' do
  uri  "http://repo.mongodb.org/apt/ubuntu"
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
end

package 'mongodb-org'

template "/etc/mongod.conf" do
  source "mongod.conf.erb"
  notifies :restart,  "service[mongod]"
  owner 'mongodb'
  group 'mongodb'
  mode '0750'
end

template "/lib/systemd/system/mongod.service" do
  source "mongod.service"
  owner 'root'
  group 'root'
  mode '0750'
  notifies :restart,  "service[mongod]"
end

service "mongod" do
  action [:enable, :start]
end


# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
# echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
#
# sudo apt-get install mongodb-org -y
#
# sudo rm /etc/mongod.conf
# sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf
#
# sudo systemctl restart mongod
# sudo systemctl enable mongod
