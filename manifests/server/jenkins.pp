class p::server::jenkins (
  $firewall = true,
  $port     = 8080
) {

  class {'p::repo::jenkins': }

  anchor { 'p::server::jenkins::begin': }

  p::resource::firewall::tcp {'jenkins':
    enabled => any2bool($firewall),
    port    => $port,
    require => Anchor['p::server::jenkins::begin'],
    before  => Anchor['p::server::jenkins::end'],
  }

  package {'jenkins':
    ensure  => 'installed',
    require => [Anchor['p::server::jenkins::begin'], P::Resource::Apt::Repo['jenkins']],
  } ->
  service {'jenkins':
    ensure => 'running',
    before => Anchor['p::server::jenkins::end'],
  }

  anchor {'p::server::jenkins::end':
    require => Anchor['p::server::jenkins::begin'],
  }

}