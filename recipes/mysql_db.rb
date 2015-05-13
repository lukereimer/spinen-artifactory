#
# Cookbook Name:: spinen-artifactory
# Recipe:: mysql_db
#
# Copyright (C) 2015 SPINEN
#
# All rights reserved - Do Not Redistribute
#
require 'json'

include_recipe 'spinen-mysql'

package 'libmysql-java' do
  action :install
end

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['initial_root_password']
}

mysql_database 'artdb' do
  connection mysql_connection_info
  action :create
end

mysql_database_user "#{node['artifactory']['storage']['user']}" do
  connection mysql_connection_info
  password "#{node['artifactory']['storage']['password']}"
  action :create
end

mysql_database_user "#{node['artifactory']['storage']['user']}" do
  connection mysql_connection_info
  password "#{node['artifactory']['storage']['password']}"
  database_name 'artifactory'
  host '%'
  privileges [:all]
  require_ssl false
  action :grant
end

include_recipe 'spinen-artifactory::default'

link "#{node['artifactory']['home']}/tomcat/lib/mysql.jar" do
  to '/usr/share/java/mysql.jar'
  owner 'artifactory'
  group 'artifactory'
  mode 0644
end