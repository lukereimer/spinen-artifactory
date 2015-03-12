require 'spec_helper'

describe 'spinen-artifactory::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['artifactory']['home'] = '/var/lib/artifactory'
      node.set['artifactory']['log_dir'] = '/var/log/artifactory'
      node.set['artifactory']['catalina_base'] = '/var/lib/artifactory/tomcat'
      node.set['artifactory']['user'] = 'artifactory'
    end.converge(described_recipe)
  end

  %w(
    unzip
    rsync
  ).each do |panda|
    it "installs #{panda}" do
      expect(chef_run).to install_package(panda)
    end
  end

  it 'creates a log directory' do
    expect(chef_run).to create_directory('/var/log/artifactory').with(
      owner: 'artifactory',
      mode: 0755,
      recursive: true)
  end

  it 'links catalina logs to /var/log/artifactory' do
    expect(chef_run).to create_link(::File.join('/var/lib/artifactory/tomcat', 'logs')).to(
      '/var/log/artifactory').with(
        owner:  'artifactory')
  end
end
