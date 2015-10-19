# spinen-artifactory-cookbook

Installs Artifactory Pro using the built in installService.sh script, but adds necessary user, directories, and installs java, if desired.

_This cookbook is tested thru Artifactory 3.X. Hopefully version 4.X coming soon!_ 

## Supported Platforms

Ubuntu 14.04

## Attributes

This cookbook expects two attributes not in the attributes/default.rb

```ruby
node['artifactory']['zip_url']
node['artifactory']['zip_checksum']
```

These should be the url and the _sha256_ _checksum_ of the zip file.

### spinen-artifactory::default

Include `spinen-artifactory` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[spinen-artifactory::default]"
  ]
}
```

### spinen-artifactory::mysql_db

This installs and configures a mysql database for artifactory. you will need to set  a few more attributes:

```ruby
node['artifactory']['storage']['type'] = 'mysql'
node['artifactory']['storage']['username']
node['artifactory']['storage']['password']

```

## License and Authors

Author:: SPINEN (<luke.reimer@spinen.com>)
