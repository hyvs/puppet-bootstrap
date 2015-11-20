class p::server::nginx (
  $firewall = true,
  $port     = 80,
  $version  = undef,
  $vhosts   = hiera_hash('nginx_vhosts'),
  $vhost_resource = 'p::resource::nginx::vhost',
  $users    = hiera_hash('nginx_users', {}),
  $log_format = hiera('nginx_log_format', '$remote_addr - $remote_user [$time_local] $host "$request_uri" $request_method $request_time $status $body_bytes_sent "$http_referer" "$http_user_agent" $upstream_response_time "$http_x_forwarded_for"')
) {

  $vhosts_defaults = {
    require => P::Resource::Package['nginx'],
    notify  => Service['nginx'],
  }

  if !defined(Class['p::repo::nginx']) {
    class {'p::repo::nginx': }
  }

     p::resource::package       { 'nginx': version => $version                 }
  -> p::resource::directory     { '/var/log/nginx': owner => 'root', group => 'nginx', mode => '0775' }
  -> p::resource::firewall::tcp { 'nginx': enabled => $firewall, port => $port }
  -> service                    { 'nginx': ensure => 'running', enable => true }

  create_resources($vhost_resource, $vhosts, $vhosts_defaults)

  file { "/etc/nginx/.htpasswd":
    ensure  => 'file',
    content => template('p/nginx/htpasswd.erb'),
    require => P::Resource::Package['nginx'],
    notify  => Service['nginx'],
  }

  file { "/etc/nginx/conf.d/00-logformat.conf":
    ensure  => 'file',
    content => template('p/nginx/logformat.conf.erb'),
    require => P::Resource::Package['nginx'],
    notify  => Service['nginx'],
  }

}