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

user node['artifactory']['user'] do
  home node['artifactory']['home']
end

directory node['artifactory']['home'] do
  owner node['artifactory']['user']
  mode 00755
  recursive true
end

directory node['artifactory']['catalina_base'] do
  owner node['artifactory']['user']
  mode 00755
  recursive true
end

%w(work temp).each do |tomcat_dir|
  directory ::File.join(node['artifactory']['catalina_base'], tomcat_dir) do
    owner node['artifactory']['user']
    mode 00755
  end
end

directory node['artifactory']['log_dir'] do
  owner node['artifactory']['user']
  mode 00755
end

artifactory_install 'artifactory' do
  action :install
end

link ::File.join(node['artifactory']['home'], 'webapps') do
  to '/usr/local/artifactory/webapps'
end

link ::File.join(node['artifactory']['catalina_base'], 'logs') do
  to node['artifactory']['log_dir']
end

link ::File.join(node['artifactory']['catalina_base'], 'conf') do
  to '/usr/local/artifactory/tomcat/conf'
end

service 'artifactory' do
  action :start
end
