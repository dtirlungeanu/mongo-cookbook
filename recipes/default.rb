#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update

# mongoDB
apt_repository 'mongod' do
 	uri          'http://repo.mongodb.org/apt/ubuntu'
 	distribution 'xenial/mongodb-org/3.2'
 	components   ['multiverse']
 	key 'EA312927'
 	keyserver 'hkp://keyserver.ubuntu.com'
end

package 'mongodb-org' do
	action :upgrade
end

template '/etc/mongod.conf' do
	source "mongod.conf.erb"
	notifies :restart, "service[mongod]"
	owner 'mongodb'
	group 'mongodb'
	mode '0750'
end

template'/lib/systemd/system/mongod.service' do
	source "mongod.service"
	notifies :restart, "service[mongod]"
	owner 'root'
	group 'root'
	mode '0750'
end

service 'mongod' do
	# source "mongod.conf.erb"
	action [:enable, :restart]
end
