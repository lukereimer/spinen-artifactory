name             'spinen-artifactory'
maintainer       'SPINEN'
maintainer_email 'luke.reimer@spinen.com'
license          'MIT'
description      'Installs/Configures Artifactory Pro'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

%w(
  java
  ark
  spinen-mysql
  apt
  database
).each do |cookbook|
  depends cookbook
end

supports 'ubuntu'
