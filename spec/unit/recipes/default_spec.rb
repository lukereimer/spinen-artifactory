require_relative  '../../spec_helper'

describe 'spinen-artifactory::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
      node.set['artifactory']['home'] = '/var/log/artifactory'
    end.converge(described_recipe)

    it 'includes apt::default recipe' do
      expect(chef_run).to include_recipe('java::default')
    end

    it 'creates an artifactory user' do
      expect(chef_run).to create_user(node['artifactory']['user'])
    end

    %w(
      node['artifactory']['home']
      node['artifactory'][catalina_base]
      ::File.join(node['artifactory']['catalina_base'], 'work')
      ::File.join(node['artifactory']['catalina_base'], 'temp')
      node['artifactory']['log_dir']
    ).each do |delta|
      expect(chef_run).to create_directory(delta).with(
        owner: node['artifactory']['user'],
        mode: 0755,
        recursive: true
        )
    end
  end
end
