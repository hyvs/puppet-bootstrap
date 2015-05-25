class p::server::puppet (
  $version        = hiera('puppetserver_version'),
  $firewall       = true,
  $port           = 8140
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

     anchor                     { 'p::server::puppet::begin': }
  -> p::resource::package       { 'puppetserver':             version => $version                 }
  -> p::resource::firewall::tcp { 'puppetserver':             enabled => $firewall, port => $port }
  -> anchor                     { 'p::server::puppet::end':   }

}