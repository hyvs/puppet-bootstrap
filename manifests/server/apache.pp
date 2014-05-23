class p::server::apache (
  $firewall = true,
  $port     = 80
) {

  p::resource::firewall::tcp {'apache2':
    enabled => any2bool($firewall),
    port    => $port,
    stage   => 'firewall',
  }

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