# Class: corp104_puppet_agent
# ===========================
#
# Full description of class corp104_puppet_agent here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'corp104_puppet_agent':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class corp104_puppet_agent (
  String $puppet_version,
  String $puppet_repo,
  String $puppet_repo_file,
  String $puppet5_repo,
  String $puppet5_repo_file,
  String $package_provider,
  String $puppet_agent_install_tmp,
  String $package_name,
  String $puppet_repo_package_ensure,
  String $puppet_repo_package_name,
  String $puppet5_repo_package_name,
  String $service_name,
  Boolean $service_enable,
  String $service_ensure,
  Optional[String] $http_proxy,
  Optional[Integer] $http_proxy_timeout,
  String $puppet_agent_bin,
){
  contain corp104_puppet_agent::install
  contain corp104_puppet_agent::config
  contain corp104_puppet_agent::service

  Class['::corp104_puppet_agent::install']
  -> Class['::corp104_puppet_agent::config']
  -> Class['::corp104_puppet_agent::service']
}
