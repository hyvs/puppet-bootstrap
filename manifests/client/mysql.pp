class p::client::mysql (
) {

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

  anchor {'p::client::mysql::begin': }

  package {'mysql-client':
    ensure  => installed,
    require => Anchor['p::client::mysql::begin'],
    before  => Anchor['p::client::mysql::end'],
  }

  anchor {'p::client::mysql::end': }

}