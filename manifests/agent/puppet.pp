class p::agent::puppet (

) {

  anchor { 'p::agent::puppet::begin': }

  package { 'puppet':
    ensure  => 'installed',
    require => Anchor['p::agent::puppet::begin'],
    before  => Anchor['p::agent::puppet::end'],
  }

  anchor { 'p::agent::puppet::end':
    require => Anchor['p::agent::puppet::begin'],
  }

}