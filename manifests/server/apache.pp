class p::server::apache (
  $firewall = true,
  $port     = 80,
  $version  = undef,
  $vhosts   = hiera_hash('apache_vhosts'),
  $vhost_resource = 'p::resource::apache::vhost'
) {

  $vhosts_defaults = {
    require => P::Resource::Package['apache2'],
    notify  => Service['apache2'],
  }

     p::resource::package       { 'apache2': version => $version                 }
  -> p::resource::firewall::tcp { 'apache2': enabled => $firewall, port => $port }

  create_resources($vhost_resource, $vhosts, $vhosts_defaults)

}