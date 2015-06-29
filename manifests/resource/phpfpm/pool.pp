define p::resource::phpfpm::pool (
  $listen,
  $listen_backlog = -1,
  $listen_allowed_clients = "127.0.0.1",
  $listen_mode = "0600",
  $user = "www-data",
  $group = "www-data",
  $pm = "dynamic",
  $pm_max_children = 5,
  $pm_min_spare_servers = 1,
  $pm_max_spare_servers = 3,
  $pm_max_requests = 500,
  $pm_status_path = undef,
  $ping_path = undef,
  $request_slowlog_timeout = "10s"
) {

  $conf_file   = "/etc/php5/fpm/pool.d/${name}.conf"

  file { $conf_file:
    ensure  => file,
    content => template('p/phpfpm/pool.conf.erb'),
    require => Package['php5-fpm'],
  }

}