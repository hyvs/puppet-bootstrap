class p::server::apache (

) {

  anchor {'p::server::apache::begin': }

  package {'apache2':
    ensure  => installed,
    require => Anchor['p::server::apache::begin'],
    before  => Anchor['p::server::apache::end'],
  }

  anchor {'p::server::apache::end':
    require => Anchor['p::server::apache::begin'],
  }

}