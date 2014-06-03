class p::server::mongodb (
  $firewall = true,
  $port     = 27017,
  $version  = '2.6.1'
) {

  if !defined(Class['p::repo::tengen']) {
    class {'p::repo::tengen': }
  }

  anchor {'p::server::mongodb::begin': }

  p::resource::firewall::tcp {'mongodb':
    enabled => any2bool($firewall),
    port    => $port,
    require => Anchor['p::server::mongodb::begin'],
    before  => Anchor['p::server::mongodb::end'],
  }

  p::resource::package {['mongodb-org', 'mongodb-org-server', 'mongodb-org-shell', 'mongodb-org-mongos', 'mongodb-org-tools']:
    version => $version,
    require => Anchor['p::server::mongodb::begin'],
    before  => Anchor['p::server::mongodb::end'],
  }

  anchor {'p::server::mongodb::end':
    require => Anchor['p::server::mongodb::begin'],
  }

}