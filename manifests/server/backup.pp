class p::server::backup (

) {

  anchor {'p::server::backup::begin': }

  # todo

  anchor {'p::server::backup::end':
    require => Anchor['p::server::backup::begin'],
  }
}