# spinen-artifactory-cookbook

Installs Artifactory Pro using the built in installService.sh script, but adds necessary user, diretories, and installs java.

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
## TO-DO

+ Tests currently pass, but only because 0 resources are detected. 
+ Also need to test the LWRP separately


## License and Authors

Author:: SPINEN (<luke.reimer@spinen.com>)
