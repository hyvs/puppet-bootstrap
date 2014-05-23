class p::system (
  $sshd_firewall = true,
  $sshd_port     = 22
) {

  p::resource::firewall::tcp {'sshd':
    enabled => any2bool($sshd_firewall),
    port    => $sshd_port,
    stage   => 'firewall',
  }

  anchor { 'p::base::begin': }

  class { 'p::system::packages':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::hosts':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::groups':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::users':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::directories':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::files':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::links':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  class { 'p::system::crons':
    require => Anchor['p::base::begin'],
    before  => Anchor['p::base::end'],
  }

  anchor { 'p::base::end':
    require => Anchor['p::base::begin'],
  }

}