class p::server::puppet (
  $firewall       = true,
  $port           = 8140,
  $version        = undef,
  $puppet_version = undef
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

  if !defined(Class['p::repo::puppetlabs_dependencies']) {
    class {'p::repo::puppetlabs_dependencies': }
  }

     anchor { 'p::server::puppet::begin': }
  -> p::resource::firewall::tcp {'puppetserver': enabled => any2bool($firewall), port => $port }
  -> p::resource::pacakge { 'puppet-common': version => $puppet_version }
  -> p::resource::package { 'puppetserver': version => $version }
  -> anchor { 'p::server::puppet::end': }

}