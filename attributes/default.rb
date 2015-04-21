default['artifactory']['home'] = '/var/lib/artifactory'
default['artifactory']['log_dir'] = '/var/log/artifactory'
default['artifactory']['catalina_base'] = ::File.join(artifactory['home'], 'tomcat')
default['artifactory']['java']['xmx'] = '1g'
default['artifactory']['java']['xms'] = '512m'
default['artifactory']['java']['extra_opts'] = '-XX:+UseG1GC'

default['artifactory']['user'] = 'artifactory'
default['artifactory']['port'] = 8081
default['artifactory']['shutdown_port'] = 8015
default['artifactory']['install_java'] = true


# Storage options, these are written into the $ARTIFACORY_HOME/etc/storage.properties
default['artifactory']['storage']['type'] = 'derby'
default['artifactory']['storage']['url'] = 'jdbc:derby:{db.home};create=true' 
default['artifactory']['storage']['driver'] = 'org.apache.derby.jdbc.EmbeddedDriver'
default['artifactory']['storage']['cache_maxSize'] = '5GB'

default['artifactory']['storage']['binary_provider'] = 'filesystem'
