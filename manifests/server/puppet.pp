class p::server::puppet (

) {

  anchor { 'p::server::puppet::begin': }

  package { 'puppetmaster-passenger':
    ensure  => 'installed',
    require => Anchor['p::server::puppet::begin'],
    before  => Anchor['p::server::puppet::end'],
  }

  anchor { 'p::server::puppet::end':
    require => Anchor['p::server::puppet::begin'],
  }

}