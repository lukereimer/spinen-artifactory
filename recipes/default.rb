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

package 'unzip'
# ark requires rsync package
package 'rsync'

directory node['artifactory']['log_dir'] do
  owner node['artifactory']['user']
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
  mode 0755
end

service 'artifactory' do
  action :start
end
