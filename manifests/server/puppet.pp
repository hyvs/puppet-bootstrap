class p::server::puppet (
  $firewall       = true,
  $port           = 8140,
  $version        = undef,
  $puppet_version = undef
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

     anchor { 'p::server::puppet::begin': }
  -> p::resource::firewall::tcp {'puppetserver': enabled => $firewall, port => $port }
  -> p::resource::package { 'puppet-common': version => $puppet_version }
  -> p::resource::package { 'puppetserver': version => $version }
  -> anchor { 'p::server::puppet::end': }

}