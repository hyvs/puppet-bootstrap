define p::resource::phpfpm::pool (
  $listen,
  $type = 'basic',
  $listen_backlog = undef,
  $listen_allowed_clients = undef,
  $listen_mode = undef,
  $user = "www-data",
  $group = "www-data",
  $pm = "dynamic",
  $pm_start_servers = 3,
  $pm_max_children = 5,
  $pm_min_spare_servers = 1,
  $pm_max_spare_servers = 3,
  $pm_max_requests = 500,
  $pm_status_path = undef,
  $ping_path = undef,
  $request_slowlog_timeout = "10s",
  $slowlog = '/var/log/phpfpm-pool-$pool.log.slow',
  $errorlog = '/var/log/nginx/$pool_fpm_error.log',
  $date_timezone = undef
) {

  $conf_file   = "/etc/php5/fpm/pool.d/${name}.conf"

  file { $conf_file:
    ensure  => file,
    content => template('p/phpfpm/pool.conf.erb'),
    require => Package['php5-fpm'],
  }

}