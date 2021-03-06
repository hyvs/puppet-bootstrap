class p::server::apache2 (
  $admin_email             = 'apache2@localhost',
  $apache_expires          = hiera_hash('apache_expires'),
  $apache_modules          = hiera_hash('apache_modules'),
  $apache_vhosts           = hiera_hash('apache_vhosts'),
  $apache_types            = hiera_hash('apache_types'),
  $apache_module_resource  = 'p::resource::apache::module',
  $apache_vhost_resource   = 'p::resource::apache::vhost',
  $confd_dir               = '/etc/apache2/conf.d',
  $default_template        = 'p/apache/default.erb',
  $dirs                    = hiera_hash('dirs'),
  $group                   = 'www-data',
  $keepalive               = 'Off',
  $keepalive_timeout       = 15,
  $log_format_template     = 'p/apache/LogFormat.conf.erb',
  $mpm_module              = 'prefork',
  $port                    = 80,
  $server_signature        = 'Off',
  $server_tokens           = 'Prod',
  $timeout                 = 120,
  $user                    = 'www-data',
  $firewall                = true,
  $default_docroot         = '/var/www'
) {

  $logs_dir        = $dirs['logs']
  $apache_logs_dir = "${logs_dir}/apache2"

  $apache_modules_defaults = {
    require => Anchor['p::server::apache2::begin'],
    before  => Anchor['p::server::apache2::end'],
  }

  $apache_vhosts_defaults = {
    logs_dir => $apache_logs_dir,
    expires  => $apache_expires,
    require  => Anchor['p::server::apache2::begin'],
    before   => Anchor['p::server::apache2::end'],
    types    => $apache_types
  }

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

  anchor {'p::server::apache2::begin': }

  p::resource::directory {[$apache_logs_dir]:
    owner   => $user,
    group   => $group,
    require => [User[$user], Group[$group], Anchor['p::server::apache2::begin']],
    before  => Anchor['p::server::apache2::end'],
  }

  class {'::apache' :
    mpm_module        => $mpm_module,
    serveradmin       => $admin_email,
    logroot           => $apache_logs_dir,
    default_vhost     => true,
    timeout           => $timeout,
    keepalive         => $keepalive,
    keepalive_timeout => $keepalive_timeout,
    server_tokens     => $server_tokens,
    server_signature  => $server_signature,
    require           => Anchor['p::server::apache2::begin'],
    before            => Anchor['p::server::apache2::end'],
  }

  file {"${confd_dir}/LogFormat.conf" :
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($log_format_template),
    require => [File["${confd_dir}"], Anchor['p::server::apache2::begin']],
    before  => Anchor['p::server::apache2::end'],
  }

  apache::listen {"${port}":
    require => Anchor['p::server::apache2::begin'],
    before  => Anchor['p::server::apache2::end'],
  }

  p::resource::file {"${default_docroot}/index.html":
    owner => $user,
    group => $group,
    template => 'p/apache/index.html.erb',
    require  => File[$default_docroot],
  }

  create_resources($apache_module_resource, $apache_modules, $apache_modules_defaults)
  create_resources($apache_vhost_resource, $apache_vhosts, $apache_vhosts_defaults)

  User <| title == $user |>
  User <| title == $user |> {groups +> 'www-data'}
  User <| title == 'www-data' |>

  file { '/etc/default/apache2' :
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($default_template),
    notify  => Service['httpd'],
    require => Class['::apache'],
    before  => Anchor['p::server::apache2::end'],
  }

  p::resource::firewall::tcp {'apache':
    enabled => any2bool($firewall),
    port    => $port,
    require => Anchor['p::server::apache2::begin'],
    before  => Anchor['p::server::apache2::end'],
  }

  anchor {'p::server::apache2::end':
    require => Anchor['p::server::apache2::begin'],
  }

}