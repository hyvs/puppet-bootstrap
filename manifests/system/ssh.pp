class p::system::ssh (
  $firewall = true,
  $port     = 22
) {

  anchor {'p::system::ssh::begin': }

  p::resource::firewall::tcp {'sshd':
    enabled => any2bool($firewall),
    port    => $port,
    stage   => 'firewall',
  }

  anchor {'p::system::ssh::end':
    require => Anchor['p::system::ssh::begin'],
  }
  
}