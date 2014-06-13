class p::system (
) {

  anchor { 'p::system::begin': }

  class { 'p::system::repos':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::locales':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::network':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::firewall':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::packages':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::hosts':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::users':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::directories':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::files':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::links':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::crons':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::ssh':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  class { 'p::system::commands':
    require => Anchor['p::system::begin'],
    before  => Anchor['p::system::end'],
  }

  anchor { 'p::system::end':
    require => Anchor['p::system::begin'],
  }

}