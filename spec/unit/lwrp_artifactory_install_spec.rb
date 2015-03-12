require 'spec_helper'

describe 'spinen-artifactory::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['artifactory_install']) do |node|
      node.set['artifactory']['home'] = '/var/lib/artifactory'
      node.set['artifactory']['log_dir'] = '/var/log/artifactory'
      node.set['artifactory']['catalina_base'] = '/var/lib/artifactory/tomcat'
      node.set['artifactory']['user'] = 'artifactory'
      node.set['artifactory']['zip_url'] = 'http://someurl.com/artifactory.zip'
      node.set['artifactory']['zip_checksum'] = '5019e4a4cac7936b3d4e1fc457d36fff60cdf27de42886184b0b5a844f43f0b0'
    end.converge('spinen-artifactory::default')
  end

  it 'creates the artifactory user' do
    expect(chef_run).to create_user('artifactory')
  end

  %w(
    /var/lib/artifactory
    /var/lib/artifactory/tomcat
    /var/log/artifactory
  ).each do |delta|
    it "creates directory #{delta}" do
      expect(chef_run).to create_directory(delta).with(
        owner: 'artifactory',
        mode: 0755,
        recursive: true
      )
    end
  end

  join = [
    ::File.join('/var/lib/artifactory/tomcat', 'work'),
    ::File.join('/var/lib/artifactory/tomcat', 'temp')
  ]
  join.each do |delta|
    it "creates directory #{delta}" do
      expect(chef_run).to create_directory(delta).with(
        owner: 'artifactory',
        mode: 0755
      )
    end
  end
end
