class p::server::puppet (
  $firewall = true,
  $port     = 8140
) {


  anchor { 'p::server::puppet::begin': }

  p::resource::firewall::tcp {'puppetmaster':
    enabled => any2bool($firewall),
    port    => $port,
    require => Anchor['p::server::puppet::begin'],
    before  => Anchor['p::server::puppet::end'],
  }

  package { 'puppetmaster-passenger':
    ensure  => 'installed',
    require => Anchor['p::server::puppet::begin'],
    before  => Anchor['p::server::puppet::end'],
  }

  anchor { 'p::server::puppet::end':
    require => Anchor['p::server::puppet::begin'],
  }

}