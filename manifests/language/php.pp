class p::language::php (
) {

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

  anchor {'p::language::php::begin': }

  package {'php5-cli':
    ensure  => installed,
    require => Anchor['p::language::php::begin'],
    before  => Anchor['p::language::php::end'],
  }

  anchor {'p::language::php::end':
    require => Anchor['p::language::php::begin'],
  }

}