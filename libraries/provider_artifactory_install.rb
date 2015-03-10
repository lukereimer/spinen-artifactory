require 'chef/provider/lwrp_base'

class Chef
  class Provider
    # Class information goes here.
    class ArtifactoryInstall < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      def whyrun_supported?
        true
      end
      action :install do
        user node['artifactory']['user'] do
          home node['artifactory']['home']
        end

        ark 'artifactory' do
          url node['artifactory']['zip_url']
          checksum node['artifactory']['zip_checksum']
          path '/var/lib'
          owner node['artifactory']['user']
          action :put
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
