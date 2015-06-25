define p::resource::phpfpm::pool (
  $listen = undef
) {

  if !$listen {
    $real_listen = "/var/run/php5-fpm-${name}.sock"
  } else {
    $real_listen = $listen
  }

  $conf_file = "/etc/php5/fpm/pool.d/${name}.conf"

  file { $conf_file:
    ensure  => file,
    content => template('p/phpfpm/pool.conf.erb'),
    require => Package['php5-fpm'],
  }

}