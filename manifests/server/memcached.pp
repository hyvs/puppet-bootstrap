class p::server::memcached (
  $default_connections = 1024,
  $default_ip          = false,
  $default_items_size  = '1m',
  $default_port        = 11211,
  $default_size        = 64,
  $dirs                = hiera_hash('dirs'),
  $instance_resource   = 'p::resource::memcached::instance',
  $instances           = hiera_hash('memcached_instances'),
  $log_dir_user        = 'root',
  $log_dir_group       = 'adm',
  $firewall            = false
) {

  $logs_dir           = $dirs['logs']
  $memcached_log_dir  = "${logs_dir}/memcached"
  $instances_defaults = {
    connections => $default_connections,
    ip          => $default_ip,
    items_size  => $default_items_size,
    log_dir     => $memcached_log_dir,
    port        => $default_port,
    size        => $default_size,
    firewall    => $firewall,
    require     => [Class['::memcached'], Anchor['p::server::memcached::begin']],
    before      => Anchor['p::server::memcached::end'],
  }

  anchor {'p::server::memcached::begin': } ->
  anchor {'p::server::memcached::end': }

  if !defined(File[$memcached_log_dir]) {
    p::resource::directory {$memcached_log_dir:
      owner   => $log_dir_user,
      group   => $log_dir_group,
      require => [File[$logs_dir], Anchor['p::server::memcached::begin']],
      before  => Anchor['p::server::memcached::end'],
    }
  }

  class {'::memcached':
    require => Anchor['p::server::memcached::begin'],
    before  => Anchor['p::server::memcached::end'],
  }

  create_resources($instance_resource, $instances, $instances_defaults)

}