class p::server::puppet (
  $version        = hiera('puppetserver_version', undef),
  $firewall       = true,
  $port           = 8140
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

     p::resource::package       { 'puppetserver': version => $version                 }
  -> p::resource::firewall::tcp { 'puppetserver': enabled => $firewall, port => $port }

}