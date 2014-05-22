class p::agent::backup (

) {

  anchor {'p::agent::backup::begin': }

  anchor {'p::agent::backup::end':
    require => Anchor['p::agent::backup::begin'],
  }

}