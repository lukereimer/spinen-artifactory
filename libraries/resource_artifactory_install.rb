require 'chef/resource/lwrp_base'

class Chef
  class Resource
    # Class information goes here.
    class ArtifactoryInstall < Chef::Resource::LWRPBase
      self.resource_name = :artifactory_install
      actions :install, :uninstall
      default_action :install
    end
  end
end
