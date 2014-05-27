class p::server::mongodb (
  $firewall = true,
  $port     = 27017
) {

  if !defined(Class['p::repo::10gen']) {
    class {'p::repo::10gen': }
  }

  anchor {'p::server::mongodb::begin': }

  p::resource::firewall::tcp {'mongodb-10gen':
    enabled => any2bool($firewall),
    port    => $port,
    require => Anchor['p::server::10gen::begin'],
    before  => Anchor['p::server::10gen::end'],
  }

  package {'apache2':
    ensure  => installed,
    require => Anchor['p::server::10gen::begin'],
    before  => Anchor['p::server::10gen::end'],
  }

  anchor {'p::server::10gen::end':
    require => Anchor['p::server::10gen::begin'],
  }

}