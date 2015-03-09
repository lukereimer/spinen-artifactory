require 'chef/provider/lwrp_base'

class Chef
  class Provider
    # Class information goes here.
    class ComposerInstall < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      def whyrun_supported?
        true
      end
      action :install do
        ark 'artifactory' do
          url node['artifactory']['zip_url']
          checksum node['artifactory']['zip_checksum']
          action :install
        end

        unless ::File.exist?('/etc/init.d/artifactory')
          cmd_str = "bash #{node['artifactory']['home']}/bin/installService.sh"
          execute cmd_str do
            Chef::Log.debug "artifactory_install: #{cmd_str}"
            Chef::Log.info 'Installing artifactory.'
            new_resource.updated_by_last_action(true)
          end
        end
      end
      action :uninstall do
        if ::File.exist?('/etc/init.d/artifactory')
          cmd_str = "bash #{node['artifactory']['home']}/bin/uninstallService.sh"
          execute cmd_str do
            Chef::Log.debug "artifactory_uninstall: #{cmd_str}"
            Chef::Log.info 'Installing artifactory.'
            new_resource.updated_by_last_action(true)
          end
        end
      end
    end
  end
end
