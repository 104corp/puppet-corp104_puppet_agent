# puppet module corp104_puppet_agent
[![Build Status](https://travis-ci.org/104corp/puppet-corp104_puppet_agent.svg?branch=master)](https://travis-ci.org/104corp/puppet-corp104_puppet_agent)


#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with corp104_puppet_agent](#setup)
    * [Beginning with corp104_puppet_agent](#beginning-with-corp104_puppet_agent)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## DEPRECATED

Dear users,

This repository is `no longer actively maintained`, and it will be officially deprecated and removed from Puppet Forge `on January 1, 2025`. We appreciate your support and contributions over the years.

Thank you for being part of our community.

## Description

The corp104_puppet_agent module installs, configures, and manages the corp104_puppet_agent service across a range of operating systems and distributions.

## Setup

### Beginning with corp104_puppet_agent

`include '::corp104_puppet_agent'` is enough to get you up and running.

## Usage

All parameters for the ntp module are contained within the main `::corp104_puppet_agent` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Install and enable corp104_puppet_agent

```puppet
include '::corp104_puppet_agent'
```

### Install specially puppet version.

```puppet
class { 'corp104_puppet_agent':
  puppet_version => '5.0.1',
}
```

### Download repository package to Use a Proxy

```puppet
class { 'corp104_puppet_agent':
  http_proxy         => 'http://change.proxy.com:3128',
  http_proxy_timeout => 60,
}
```

## Reference

### Classes

#### Public classes

* corp104_puppet_agent: Main class, includes all other classes.

#### Private classes

* corp104_puppet_agent::install: Handles the packages.
* corp104_puppet_agent::config: Handles the config.
* corp104_puppet_agent::service: Handles the service.

## Limitations

This module cannot guarantee installation of corp104_puppet_agent versions that are not available on  platform repositories.

This module is officially [supported](https://forge.puppetlabs.com/supported) for the following Java versions and platforms:

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.

For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

### Contributors

To see who's already involved, see the [list of contributors.](https://github.com/puppetlabs/puppetlabs-ntp/graphs/contributors)
