class corp104_puppet_agent::install inherits corp104_puppet_agent {

  case $facts['os']['family'] {
    'Debian': {
      $package_ensure = "${$corp104_puppet_agent::puppet_version}-1${::lsbdistcodename}"
    }
    'RedHat': {
      $package_ensure = "${$corp104_puppet_agent::puppet_version}-1.el${::operatingsystemmajrelease}"
    }
    default: {
      fail ("unsupported OS ${facts['os']['family']} .")
    }
  }

  if versioncmp($corp104_puppet_agent::puppet_version, '5.0.0') >= 0 {
    $package_repo = $corp104_puppet_agent::puppet5_repo
    $package_repo_file = $corp104_puppet_agent::puppet5_repo_file
    $repo_package_name = $corp104_puppet_agent::puppet5_repo_package_name
    $repo_package_rpm = $corp104_puppet_agent::puppet5_repo_package_rpm
  }
  else {
    $package_repo = $corp104_puppet_agent::puppet_repo
    $package_repo_file = $corp104_puppet_agent::puppet_repo_file
    $repo_package_name = $corp104_puppet_agent::puppet_repo_package_name
    $repo_package_rpm = $corp104_puppet_agent::puppet_repo_package_rpm
  }

  if $facts['os']['release']['major'] == '5' {
    exec { 'download-repo':
      command => 'echo do not anything',
      path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      unless  => "test -f ${package_repo_file}",
    }
    file { $corp104_puppet_agent::puppet_agent_install_tmp:
      ensure => present,
      source => "puppet:///modules/${module_name}/${repo_package_rpm}",
    }
  }
  else {
    if $corp104_puppet_agent::http_proxy {
      exec { 'download-repo':
        command => "curl -x ${corp104_puppet_agent::http_proxy} --connect-timeout ${corp104_puppet_agent::http_proxy_timeout} -o ${corp104_puppet_agent::puppet_agent_install_tmp} -O ${package_repo}",
        path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
        unless  => "test -f ${package_repo_file}",
      }
    }
    else {
      exec { 'download-repo':
        command => "curl -o ${corp104_puppet_agent::puppet_agent_install_tmp} -O ${package_repo}",
        path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
        unless  => "test -f ${package_repo_file}",
      }
    }
  }

  case $facts['os']['family'] {
    'Debian': {
      package { $repo_package_name:
        ensure    => $corp104_puppet_agent::puppet_repo_package_ensure,
        provider  => $corp104_puppet_agent::package_provider,
        source    => $corp104_puppet_agent::puppet_agent_install_tmp,
        before    => Package['puppet-agent'],
        notify    => Exec['apt-update'],
        subscribe => Exec['download-repo'],
      }
      exec { 'apt-update':
        command     => 'apt-get update',
        path        => '/bin:/usr/sbin:/usr/bin:/sbin',
        user        => 'root',
        refreshonly => true,
      }
    }
    'RedHat': {
      package { $repo_package_name:
        ensure    => $corp104_puppet_agent::puppet_repo_package_ensure,
        provider  => $corp104_puppet_agent::package_provider,
        source    => $corp104_puppet_agent::puppet_agent_install_tmp,
        before    => Package['puppet-agent'],
        subscribe => Exec['download-repo'],
      }
    }
    default: {
      fail ("unsupported OS ${facts['os']['family']} .")
    }
  }

  package { 'puppet-agent':
    ensure  => $package_ensure,
    name    => $corp104_puppet_agent::package_name,
    notify  => Service['puppet-agent'],
    require => Package[$repo_package_name],
  }
}
