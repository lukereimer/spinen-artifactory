#
# Cookbook Name:: spinen-artifactory
# Recipe:: mysql_db
#
# Copyright (C) 2015 SPINEN
#
# All rights reserved - Do Not Redistribute
#
require 'json'

include_recipe 'spinen_mysql'

package 'libmysql-java' do
  action :install
end

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['initial_root_password']
}

mysql_database 'artifactory' do
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
