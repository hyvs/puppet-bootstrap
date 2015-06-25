class p::server::nginx (
  $firewall = true,
  $port     = 80,
  $version  = undef,
  $vhosts   = hiera_hash('nginx_vhosts'),
  $vhost_resource = 'p::resource::nginx::vhost'
) {

  $vhosts_defaults = {
    require => P::Resource::Package['nginx'],
    notify  => Service['nginx'],
  }

  if !defined(Class['p::repo::nginx']) {
    class {'p::repo::nginx': }
  }

     p::resource::package       { 'nginx': version => $version                 }
  -> p::resource::firewall::tcp { 'nginx': enabled => $firewall, port => $port }

  create_resources($vhost_resource, $vhosts, $vhosts_defaults)

}