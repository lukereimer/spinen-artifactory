if defined?(ChefSpec)
  ChefSpec.define_matcher :artifactory_install

  #
  # When defining a custom LWRP matcher, you should always add some
  # documentation indicating how to use the custom matcher.
  #
  # @example This is an example
  #   expect(chef_run).to install_custom_matcher_thing('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def install_artifactory_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:artifactory_install, :install, resource_name)
  end

  # def remove_artifactory_install(resource_name)
  #   ChefSpec::Matchers::ResourceMatcher.new(:artifactory_install, :remove, resource_name)
  # end
end
