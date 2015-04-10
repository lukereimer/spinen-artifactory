#
# Cookbook Name:: spinen-artifactory
# Recipe:: mysql_db
#
# Copyright (C) 2015 SPINEN
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'spinen_mysql'

package 'libmysql-java' do
  action :install
end
