class p::agent::backup (

) {

  anchor {'p::agent::backup::begin': }

  anchor {'p::agent::backup::begin':
    require => Anchor['p::agent::backup::begin'],
  }

}