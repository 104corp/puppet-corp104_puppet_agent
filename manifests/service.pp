class corp104_puppet_agent::service inherits corp104_puppet_agent {
  service { 'puppet-agent':
    ensure    => $corp104_puppet_agent::service_ensure,
    enable    => $corp104_puppet_agent::service_enable,
    name      => $corp104_puppet_agent::service_name,
    subscribe => Package['puppet-agent'],
    require   => Class['corp104_puppet_agent::install'],
  }
}