class p::server::mysql (

) {

  anchor {'p::server::mysql::begin': }

  package {'mysql-server':
    ensure  => installed,
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  }

  anchor {'p::server::mysql::end':
    require => Anchor['p::server::mysql::begin'],
  }

}