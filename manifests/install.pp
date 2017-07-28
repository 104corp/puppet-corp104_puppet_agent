class corp104_puppet_agent::install inherits corp104_puppet_agent {
  if $corp104_puppet_agent::http_proxy {
    exec { 'download-repo':
      command => "curl -x ${corp104_puppet_agent::http_proxy} --connect-timeout ${corp104_puppet_agent::http_proxy_timeout} -o ${corp104_puppet_agent::puppet_agent_install_tmp} -O ${corp104_puppet_agent::package_repo}",
      path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      creates => $corp104_puppet_agent::puppet_agent_install_tmp
    }
  }
  else {
    exec { 'download-repo':
      command => "curl -o ${corp104_puppet_agent::puppet_agent_install_tmp} -O ${corp104_puppet_agent::package_repo}",
      path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
      creates => $corp104_puppet_agent::puppet_agent_install_tmp
    }
  }

  package { 'install-repo':
    ensure    => $corp104_puppet_agent::repo_package_ensure,
    name      => $corp104_puppet_agent::repo_package_name,
    provider  => $corp104_puppet_agent::package_provider,
    source    => $corp104_puppet_agent::puppet_agent_install_tmp,
    before    => Package['puppet-agent'],
    subscribe => Exec['download-repo'],
  }

  package { 'puppet-agent':
    ensure => $corp104_puppet_agent::package_ensure,
    name   => $corp104_puppet_agent::package_name,
    notify => Service['puppet-agent'],
  }
}