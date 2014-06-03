class p::server::beanstalkd (
  $default_file     = '/etc/default/beanstalkd',
  $default_template = 'p/beanstalkd/default.erb',
  $enabled          = true,
  $ensure           = 'running',
  $firewall         = false,
  $has_status       = true,
  $ip               = '127.0.0.1',
  $package          = 'beanstalkd',
  $port             = 11300,
  $restart_command  = 'service beanstalkd reload',
  $service          = 'beanstalkd'
) {

  anchor {'p::server::beanstalkd::begin': } ->
  p::resource::package {$package: } ->
  file {$default_file:
    ensure  => 'file',
    content => template($default_template),
  } ->
  service {$service :
    ensure    => $ensure,
    enable    => $enabled,
    restart   => $restart_command,
    hasstatus => $has_status,
  } ->
  p::resource::firewall::tcp {'beanstalkd':
    port    => $port,
    enabled => any2bool($firewall),
  } ->
  anchor {'p::server::beanstalkd::end':}

}