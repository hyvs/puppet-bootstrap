define p::resource::nginx::vhost (
  $docroot     = undef,
  $listen      = 80,
  $server_name = $name,
  $type        = 'phpfpm',
  $params      = undef
) {

  $conf_file = "/etc/nginx/conf.d/${name}.conf"

  file { $conf_file:
    ensure  => file,
    content => template('p/nginx/vhost.conf.erb'),
    require => Package['nginx'],
  }

}