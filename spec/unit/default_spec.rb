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

  it 'does the artifactory install with the artifactory_install lwrp' do
    expect(chef_run).to install_artifactory_install('artifactory')
  end

  it 'links catalina logs to /var/log/artifactory' do
    expect(chef_run).to create_link(::File.join('/var/lib/artifactory/tomcat', 'logs')).with(
      owner:  'artifactory')
  end

  it 'creates the default config for artifactory' do
    expect(chef_run).to create_template('/var/lib/artifactory/etc/default').with(
      source: 'etc.default.erb',
      owner: 'artifactory',
      mode: 0755
      )
  end

  it 'starts artifactory' do
    expect(chef_run).to start_service('artifactory')
  end
end
