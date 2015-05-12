#
# Cookbook Name:: spinen-artifactory
# Recipe:: default
#
# Copyright (C) 2015 SPINEN
#
# All rights reserved - Do Not Redistribute
#
if node['artifactory']['install_java']
  node.set['java']['jdk_version'] = 7
  include_recipe 'java'
end

# ark requires rsync and unzip package
package 'unzip'
package 'rsync'

directory node['artifactory']['log_dir'] do
  owner node['artifactory']['user']
  group node['artifactory']['user']
  mode 00755
end

artifactory_install 'artifactory' do
  action :install
end

link ::File.join(node['artifactory']['catalina_base'], 'logs') do
  to node['artifactory']['log_dir']
  owner node['artifactory']['user']
end

template '/var/lib/artifactory/etc/default' do
  source 'etc.default.erb'
  owner node['artifactory']['user']
  group node['artifactory']['user']
  mode 0755
end

template "#{node['artifactory']['home']}/etc/storage.properties" do
  source 'mysql.properties.erb'
  owner 'artifactory'
  group 'artifactory'
  mode 0664
  variables({
    :type => default['artifactory']['storage']['type']
    :url => default['artifactory']['storage']['url'] 
    :driver => default['artifactory']['storage']['driver']
    :cache_maxSize => default['artifactory']['storage']['cache_maxSize']
    :username => default['artifactory']['storage']['username']
    :password => default['artifactory']['storage']['password']
    :binary_provider => node['artifactory']['storage']['binary_provider']
    })
end 

service 'artifactory' do
  action :start
end
